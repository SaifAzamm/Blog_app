import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:ass_blog_app/core/error/validator.dart';
import 'package:ass_blog_app/core/resources/images.dart';
import 'package:ass_blog_app/core/routes/router.dart';
import 'package:ass_blog_app/core/widgets/primary_button.dart';
import 'package:ass_blog_app/core/widgets/text_f.dart';
import 'package:ass_blog_app/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(() => AuthController());
    }

    final AuthController controller = Get.find<AuthController>();
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: isWeb
              ? const BoxConstraints(maxWidth: 600)
              : const BoxConstraints(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: isWeb ? 32 : 24.w),
            child: Form(
              key: controller.loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  SizedBox(height: isWeb ? 10 : 8.h),
                  Text(
                    'Please login to your account',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Palette.greyText,
                          fontSize: isWeb ? 16 : null,
                        ),
                  ),
                  SizedBox(height: isWeb ? 30 : 40.h),
                  TextF(
                    labelText: "Email",
                    controller: controller.loginEmailController,
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: Palette.greyText),
                    validator: (v) => Validators.validateEmail(v),
                  ),
                  SizedBox(height: isWeb ? 16 : 20.h),
                  TextF(
                    labelText: "Password",
                    controller: controller.loginPasswordController,
                    hintText: "Enter your password",
                    obscureText: true,
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Palette.greyText),
                    validator: (v) => Validators.validatePassword(v),
                  ),
                  SizedBox(height: isWeb ? 24 : 30.h),
                  Obx(() {
                    return controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            buttonText: "Login",
                            onPressed: () => controller.login(),
                          );
                  }),
                  SizedBox(height: 16.h),
                  Obx(() {
                    return controller.isLoading1.value
                        ? const Center(child: CircularProgressIndicator())
                        : _buildGoogleSignInButton(controller, isWeb);
                  }),
                  SizedBox(height: isWeb ? 20 : 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don’t have an account?'),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.signupScreen),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Palette.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(AuthController controller, bool isWeb) {
    return ElevatedButton.icon(
      onPressed: () => controller.signInWithGoogle(),
      icon: Padding(
        padding: EdgeInsets.only(left: isWeb ? 8 : 0),
        child: Image.asset(
          Images.googleLogo,
          height: isWeb ? 24 : 20.h,
          width: isWeb ? 24 : 20.w,
        ),
      ),
      label: Text(
        'Sign In with Google',
        style: TextStyle(
          fontSize: isWeb ? 16 : 16.sp,
          color: Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Palette.blue,
        backgroundColor: Colors.white,
        minimumSize: Size(double.infinity, isWeb ? 48 : 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        side: const BorderSide(color: Palette.lightGrey),
        padding: EdgeInsets.symmetric(
          vertical: isWeb ? 16 : 12.h,
        ),
      ),
    );
  }
}
