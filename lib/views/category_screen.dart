import 'package:ecommerce_app/layoutCubit/layout_cubit.dart';
import 'package:ecommerce_app/layoutCubit/layout_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
        body: BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            shrinkWrap: true,
            clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8),
            itemCount: cubit.filterProducts.isEmpty
                ? cubit.categoryList.length
                : cubit.filterProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(
                      cubit.categoryList[index].image,
                      errorBuilder: (BuildContext, Object, StackTrace) {
                        return const CupertinoActivityIndicator();
                      },
                    ),
                    Text(cubit.categoryList[index].name)
                  ],
                ),
              );
            },
          ),
        );
      },
    ));
  }
}
