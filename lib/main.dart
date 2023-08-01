import 'package:ecommerce_app/layoutCubit/layout_cubit.dart';
import 'package:ecommerce_app/layoutCubit/logout_cubit.dart';
import 'package:ecommerce_app/views/layout_screen.dart';
import 'package:ecommerce_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helper/constant.dart';
import 'helper/user_token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache.cacheInit();
  token = Cache.getUser(key: 'token');
  print("token is : $token");
  runApp(const MyApp());
  // print()
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogoutCubit>(
          create: (context) => LogoutCubit(),
        ),
        BlocProvider<LayoutCubit>(
          create: (context) => LayoutCubit()
            ..GetBanners()
            ..GetCategory()
            ..getProfile()
            ..GetProduct()
            ..GetFavorites()
            ..GetCart(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: token != null ? const LayoutScreen() : LoginScreen()),
    );
  }
}
