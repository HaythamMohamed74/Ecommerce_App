abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class ProfileDataLoading extends LayoutState {}

class ProfileDataSuccess extends LayoutState {
  // final UserModel user;

  // ProfileDataSuccess({required this.user});
}

class ProfileDataFailed extends LayoutState {
  String msg;
  ProfileDataFailed({required this.msg});
}

//navBar states
class Changenavbar extends LayoutState {}

// Banners states
class BannersSuccess extends LayoutState {}

class BannersFailed extends LayoutState {}

class BannersLoading extends LayoutState {}

//Category states
class CategoryLoading extends LayoutState {}

class CategorySuccsess extends LayoutState {}

class CategoryFailed extends LayoutState {}

//Productd states
class ProductdLoading extends LayoutState {}

class ProductdSuccsess extends LayoutState {}

class ProductdFailed extends LayoutState {
  // final Widget widget;
  // ProductdFailed({required this.widget});
}

//Category states
class SearchProductLoading extends LayoutState {}

class SearchProductSuccsess extends LayoutState {}

class SearchProductFailed extends LayoutState {}

//ADD to Favorites
class FavoritesLoading extends LayoutState {}

class FavoritesSuccess extends LayoutState {
  String message;
  FavoritesSuccess({required this.message});
}

class FavoritesFailed extends LayoutState {}

class GetFavoritesSuccess extends LayoutState {}

class GetFavoritesfailed extends LayoutState {}

class GetFavoritesLoading extends LayoutState {}

class GetCartSuccess extends LayoutState {}

class GetCartFailed extends LayoutState {}

class AddToCartsSuccess extends LayoutState {
  String message;
  AddToCartsSuccess({required this.message});
}

class AddToCartsFailed extends LayoutState {}
