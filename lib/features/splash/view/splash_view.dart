import 'package:ass_blog_app/core/resources/images.dart';
import 'package:ass_blog_app/features/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(child: Image.asset(Images.logo)),
    );
  }
}
