import 'package:ass_blog_app/features/auth/controller/auth_controller.dart';
import 'package:ass_blog_app/features/blogs/controller/blog_controller.dart';
import 'package:ass_blog_app/features/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<BlogController>(() => BlogController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
