import 'package:ass_blog_app/core/routes/router.dart';
import 'package:ass_blog_app/features/auth/view/login_view.dart';
import 'package:ass_blog_app/features/auth/view/signup_view.dart';
import 'package:ass_blog_app/features/blogs/view/create_blog.dart';
import 'package:ass_blog_app/features/dashboard/view/dashboard_view.dart';
import 'package:ass_blog_app/features/splash/view/splash_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRouter {
  static List<GetPage<dynamic>> routes = [
    //Splash screen
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    //Splash screen
    GetPage(
      name: AppRoutes.signupScreen,
      page: () => const SignupView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    //Splash screen
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 800),
    ),

    //Create blog screen
    GetPage(
      name: AppRoutes.createBlogScreen,
      page: () => const CreateBlog(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    //Dashboard screen
    GetPage(
      name: AppRoutes.dashboardScreen,
      page: () => DashboardView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 800),
    ),
  ];
}
