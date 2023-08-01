import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layoutCubit/layout_cubit.dart';
import '../layoutCubit/layout_state.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.cubit, required this.index})
      : super(key: key);
  final LayoutCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // title: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.arrow_back_ios_new_sharp),
          //   color: Colors.black,
          // ),
        ),
        body: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (BuildContext context, Object? state) {
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
          builder: (BuildContext context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                Expanded(
                  flex: 2,
                  child: Image.network(
                    cubit.products[index].img,
                    // color: Color(0xffe7ded7),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffe7ded7),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cubit.products[index].name.length > 17
                                    ? cubit.products[index].name
                                            .substring(0, 20) +
                                        '...'
                                    : cubit.products[index].name,
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                "\$ ${cubit.products[index].price.toString()} ",
                                // maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            cubit.products[index].desc,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        const Text(
                          'Similar this ',
                          style: TextStyle(fontSize: 20),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: cubit.products[index].images.length == 1
                                ? Image.network(
                                    cubit.products[index].images[0],
                                    errorBuilder:
                                        (BuildContext, Object, StackTrace) {
                                      return const CupertinoActivityIndicator();
                                    },
                                    width: 100,
                                    height: 100,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: cubit.products[index].images
                                        .map((imageUrl) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Image.network(
                                          imageUrl,
                                          width: 100,
                                          height: 100,
                                          errorBuilder: (BuildContext, Object,
                                              StackTrace) {
                                            return const CupertinoActivityIndicator();
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white24.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: 30,
                                    ),
                                    color: cubit.favProductIds.contains(
                                            cubit.products[index].id.toString())
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cubit.addToCarts(
                                      cubit.products[index].id.toString());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .black, // Set the background color to black
                                ),
                                child: const Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                      color: Colors
                                          .white), // Set the text color to white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
