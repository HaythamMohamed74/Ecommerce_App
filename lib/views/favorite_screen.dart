import 'package:ecommerce_app/layoutCubit/layout_cubit.dart';
import 'package:ecommerce_app/layoutCubit/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('Favorites'),
          //   centerTitle: true,
          // ),
          body: cubit.favProducts.isEmpty
              ? Center(
                  child: Text(
                    'No Favorites Yet',
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                )
              : ListView.builder(
                  itemCount: cubit.favProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = cubit.favProducts[index];
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        children: [
                          Image.network(product.img,
                              width: 100,
                              // height: 100,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                            // Display the CupertinoActivityIndicator if there is an error
                            return const CupertinoActivityIndicator();
                          }),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('\$ ${product.price.toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      '\$ ${product.oldPrice.toString()}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     final productId = product.id.toString();
                          //     if (cubit.isProductInFavorites(productId)) {
                          //       cubit.removeFromFavorites(productId);
                          //     } else {
                          //       cubit.addToFavorites(productId);
                          //     }
                          //   },
                          //   icon: Icon(
                          //     cubit.isProductInFavorites(product.id.toString())
                          //         ? Icons.favorite
                          //         : Icons.favorite_border,
                          //     color: cubit.isProductInFavorites(product.id.toString())
                          //         ? Colors.red
                          //         : Colors.grey,
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
