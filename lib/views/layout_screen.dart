import 'package:ecommerce_app/layoutCubit/layout_cubit.dart';
import 'package:ecommerce_app/layoutCubit/layout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutState>(listener: (context, state) {
      // do stuff here based on BlocA's state
    }, builder: (context, state) {
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 20,
              backgroundColor: Colors.yellow[200],
              title: Text('Smart Shopping'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.buttomnavindex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.onchanged(index: index);
              },
              // backgroundColor: Colors.redAccent,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.blue,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_rounded), label: 'cart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'profile')
              ],
            ),
            body: cubit.screens[cubit.buttomnavindex]),
      );
    });
  }
}
