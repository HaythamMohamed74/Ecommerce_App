import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layoutCubit/layout_cubit.dart';
import '../views/details_screen.dart';

ProductItem(LayoutCubit cubit, int index, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => DetailsScreen(
                    cubit: cubit,
                    index: index,
                  )));
    },
    child: Container(
      color: Colors.grey.withOpacity(0.2),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Image.network(
            cubit.products[index].img,
            // width: 150,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              // Display the CupertinoActivityIndicator if there is an error
              return const CupertinoActivityIndicator();
            },
          )),
          const SizedBox(
            height: 10,
          ),
          Text(
            cubit.products[index].name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ ${cubit.products[index].price.toString()} ",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              Text(
                "\$ ${cubit.products[index].oldPrice.toString()} ",
                style: const TextStyle(
                    color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
              IconButton(
                onPressed: () {
                  print(cubit.products[index].id);
                  BlocProvider.of<LayoutCubit>(context).addToFavorite(
                      productId: cubit.products[index].id.toString());
                },
                icon: Icon(Icons.favorite),
                color: cubit.favProductIds
                        .contains(cubit.products[index].id.toString())
                    ? Colors.red
                    : Colors.grey,
              )
            ],
          ),
          // CircleAvatar(
          //   child: IconButton(
          //       color: Colors.red,
          //       onPressed: () {
          //         print('cart');
          //         BlocProvider.of<LayoutCubit>(context)
          //             .addToCarts(cubit.products[index].id.toString());
          //       },
          //       icon: const Icon(
          //         Icons.shopping_cart_rounded,
          //         size: 30,
          //       )),
          // )
        ],
      ),
    ),
  );
}
