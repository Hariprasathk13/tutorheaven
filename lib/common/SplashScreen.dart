import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorheaven/app/modules/Home/views/HomePage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Get.toNamed('/');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/splash.png",
          // width: 100,
        ),
      ),
    );
  }
}
