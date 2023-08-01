import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layoutCubit/layout_cubit.dart';
import '../layoutCubit/layout_state.dart';
import '../widgets/buildTextFormField.dart';
import '../widgets/carsol_slider_builder.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    // final int bannerLength = cubit.bannerslist.length;
    final TextEditingController searchController = TextEditingController();
    print({"banner length is :", cubit.bannerslist.length});
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (BuildContext context, state) {
        if (state is BannersLoading) {
          const Center(child: CircularProgressIndicator());
        }
        if (state is FavoritesSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(state.message),
              );
            },
          );
        }
        if (state is AddToCartsSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(state.message),
              );
            },
          );
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          // appBar: AppBar(leading: Icon(Icons.search),),
          body: ListView(
            // shrinkWrap: true,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildTextFormField(
                      hintText: 'search',
                      sufix: Icons.clear,
                      controller: searchController,
                      perfixIcon: Icons.search,
                      onChanged: (input) {
                        cubit.searchProduct(text: input);
                      })),
              const SizedBox(
                height: 5,
              ),
              cubit.bannerslist.isEmpty
                  ? const CupertinoActivityIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CarsolSliderBuilder(
                          bannerLength: cubit.bannerslist.length, cubit: cubit),
                    ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(color: Colors.blue, fontSize: 22),
                    ),
                    Text(
                      'veiwAll',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              cubit.categoryList.isNotEmpty
                  ? SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ListView.separated(
                        itemCount: cubit.categoryList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(cubit.categoryList[index].image),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 20,
                          );
                        },
                      ),
                    )
                  : const CupertinoActivityIndicator(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(color: Colors.blue, fontSize: 22),
                  ),
                  Text(
                    'veiwAll',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              cubit.products.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    2, // Number of columns in the grid
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.8),
                        itemCount: cubit.filterProducts.isEmpty
                            ? cubit.products.length
                            : cubit.filterProducts.length,
                        itemBuilder: (context, index) {
                          return ProductItem(cubit, index, context);
                        },
                      ),
                    )
                  : const CupertinoActivityIndicator()
            ],
          ),
        );
      },
    );
  }
}
