import 'dart:async';
import 'package:ass_blog_app/core/helper/get_storage_helper.dart';
import 'package:get/get.dart';

import '../../../core/routes/router.dart';

class SplashController extends GetxController {
  void authenticate() async {
    if (box.read("is_logged_in") != null && box.read("is_logged_in")) {
      Get.offAllNamed(AppRoutes.dashboardScreen);
    } else {
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }

  @override
  void onInit() {
    super.onInit();
    Timer(
      const Duration(seconds: 2),
      () {
        authenticate();
      },
    );
  }
}
