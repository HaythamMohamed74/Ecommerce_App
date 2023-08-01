import 'package:ecommerce_app/helper/app_images/images.dart';
import 'package:ecommerce_app/layoutCubit/layout_cubit.dart';
import 'package:ecommerce_app/layoutCubit/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    print(cubit.cartList.length);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: cubit.cartList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(AppImages.emptyCart),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cubit.cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final cartProduct = cubit.cartList[index];
                          return Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Image.network(
                                  cartProduct.img,
                                  width: 100,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Display the CupertinoActivityIndicator if there is an error
                                    return const CupertinoActivityIndicator();
                                  },
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartProduct.name,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$ ${cartProduct.price.toString()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.favorite),
                                            color: cubit.favProductIds.contains(
                                                    cubit.products[index].id
                                                        .toString())
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<LayoutCubit>(
                                                      context)
                                                  .addToCarts(cubit
                                                      .cartList[index].id
                                                      .toString());
                                            },
                                            icon: const Icon(Icons.delete),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "TotalPrice : ${cubit.totalPrice} \$",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
