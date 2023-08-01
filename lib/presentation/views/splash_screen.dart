import 'package:flutter/material.dart';

import '../../utils/helper/app_images/images.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4))
        .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.splashImage)

          // Text('Developed by Haytham')
        ],
      ),
    );
  }
}
