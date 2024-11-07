import 'dart:async';
import 'package:ass_blog_app/core/dependency_injection.dart';
import 'package:ass_blog_app/core/resources/app_theme.dart';
import 'package:ass_blog_app/core/routes/router.dart';
import 'package:ass_blog_app/core/routes/routes.dart';
import 'package:ass_blog_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DependencyInjection.init();
  Timer(const Duration(seconds: 2), () {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, __) {
        return GetMaterialApp(
          title: 'Blog App',
          theme: ApplicationTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          getPages: AppRouter.routes,
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}
