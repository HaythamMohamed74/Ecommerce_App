import 'dart:convert';

// import 'package:ecommerce_app/helper/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../data/models/banner_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/user_model.dart';
import '../../utils/helper/constant.dart';
import '../views/cart_screen.dart';
import '../views/category_screen.dart';
import '../views/favorite_screen.dart';
import '../views/home_screen.dart';
import '../views/profile_screen.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  // UserModel? user;
  //Buttom nav Bar
  final List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];
  int buttomnavindex = 0;
  onchanged({required int index}) {
    buttomnavindex = index;
    emit(Changenavbar());
  }

  // Get Profile data
  UserModel? user;
  Future<void> getProfile() async {
    var url = 'https://student.valuxapps.com/api/profile';
    var headrs = {'Authorization': token!, 'lang': "en"};
    emit(ProfileDataLoading());
    try {
      Response response = await http.get(Uri.parse(url), headers: headrs);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == true) {
        print(responsebody);
        user = UserModel.fromJson(responsebody['data']);
        emit(ProfileDataSuccess());
        print(responsebody);
      } else {
        print(responsebody);
        emit(ProfileDataFailed(msg: responsebody['message']));
      }
    } on Exception catch (e) {
      emit(ProfileDataFailed(msg: 'this is error ${e.toString()}'));
      print(e.toString());
    }
  }

//  Get Banners
  List<Banners> bannerslist = [];
  Future<void> GetBanners() async {
    var url = 'https://student.valuxapps.com/api/banners';
    var response = await http.get(
      Uri.parse(url),
    );
    emit(BannersLoading());
    try {
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        for (var item in responseBody['data']) {
          bannerslist.add(Banners.fromJson(item));
        }

        print(bannerslist);
        emit(BannersSuccess());
      } else {
        emit(BannersFailed());
      }
    } on Exception catch (e) {
      print({"this error: ${e.toString()}"});
    }
  }

//  Get Category
  List<Category> categoryList = [];
  Future<void> GetCategory() async {
    var url = 'https://student.valuxapps.com/api/categories';
    var response = await http.get(Uri.parse(url), headers: {'lang': 'en'});
    emit(CategoryLoading());
    try {
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        for (var item in responseBody['data']['data']) {
          categoryList.add(Category.fromJson(item));
        }
        print(responseBody);
        emit(CategorySuccsess());
      } else {
        emit(CategoryFailed());
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  // Get Products
  List<Product> products = [];
  Future<void> GetProduct() async {
    var url = 'https://student.valuxapps.com/api/products';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': token!, 'lang': 'en'});
    emit(ProductdLoading());
    try {
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        for (var item in responseBody['data']['data']) {
          products.add(Product.fromJson(item));
          // products.add(item);
        }
        print(responseBody);
        emit(ProductdSuccsess());
      } else {
        emit(ProductdFailed());
      }
    } on Exception catch (e) {
      emit(ProductdFailed());
      print(e.toString());
    }
  }

//Search
  List<Product> filterProducts = [];

  searchProduct({required String text}) {
    emit(SearchProductLoading());
    try {
      filterProducts = products
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      emit(ProductdSuccsess());
    } on Exception catch (e) {
      print(e.toString());
      emit(SearchProductFailed());
    }
  }

  //Fav products
  List<Product> favProducts = [];
  Set<String> favProductIds = {};
  Future<void> GetFavorites() async {
    favProducts.clear();
    var url = 'https://student.valuxapps.com/api/favorites';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': token!, 'lang': 'en'});
    emit(GetFavoritesLoading());
    try {
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        // Clear the list before adding new products
        for (var item in responseBody['data']['data']) {
          favProducts.add(Product.fromJson(item['product']));
          favProductIds.add(item['product']['id'].toString());
          // print('Added favorite product: ${item['product']['name']}');
        }
        print('Favorites list length: ${favProducts.length}');
        emit(GetFavoritesSuccess());
      } else {
        emit(GetFavoritesfailed());
      }
    } catch (e) {
      emit(GetFavoritesfailed());
      print(e.toString());
    }
  }

  // Add to Favorite
  Future<void> addToFavorite({String? productId}) async {
    var url = 'https://student.valuxapps.com/api/favorites';
    var body = {'product_id': productId};
    var headrs = {'Authorization': token!, 'lang': 'en'};
    var response = await http.post(Uri.parse(url), body: body, headers: headrs);
    emit(FavoritesLoading());
    try {
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        if (favProductIds.contains(productId)) {
          favProductIds.remove(productId); // Remove product from favorites
        } else {
          favProductIds.add(productId!); // Add product to favorites
        }
        await GetFavorites();
        emit(FavoritesSuccess(message: responseBody['message']));
      } else {
        emit(FavoritesFailed());
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(FavoritesFailed());
    }
  }

//  Get Cart items
  List<Product> cartList = [];
  Set<String> cartsIds = {};
  int totalPrice = 0;
  Future<void> GetCart() async {
    cartList.clear();
    var url = 'https://student.valuxapps.com/api/carts';
    var headrs = {'Authorization': token!, 'lang': 'en'};
    var response = await http.get(Uri.parse(url), headers: headrs);
    try {
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        for (var item in responseBody['data']['cart_items']) {
          cartsIds.add(item['product']['id'].toString());
          cartList.add(Product.fromJson(item['product']));
        }
        totalPrice = (responseBody['data']['total']) ?? 0.toString();
        print(totalPrice);
        print("cart length is :${cartList.length}");
        emit(GetCartSuccess());
      } else {
        emit(GetCartFailed());
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(GetCartFailed());
    }
  }

  Future<void> addToCarts(String? productId) async {
    var url = 'https://student.valuxapps.com/api/carts';
    var headrs = {'Authorization': token!, 'lang': 'en'};
    var body = {'product_id': productId};
    var response = await http.post(Uri.parse(url), headers: headrs, body: body);
    try {
      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        cartsIds.contains(productId) == true
            ? cartsIds.remove(productId)
            : cartsIds.add(productId!);
        await GetCart();
        emit(AddToCartsSuccess(message: responseBody['message']));
      } else {
        emit(AddToCartsFailed());
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
