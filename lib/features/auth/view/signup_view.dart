import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:ass_blog_app/core/error/validator.dart';
import 'package:ass_blog_app/core/widgets/primary_button.dart';
import 'package:ass_blog_app/core/widgets/text_f.dart';
import 'package:ass_blog_app/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

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
              key: controller.signUPKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create an Account!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  SizedBox(height: isWeb ? 10 : 8.h),
                  Text(
                    'Sign up to get started',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Palette.greyText,
                          fontSize: isWeb ? 16 : null,
                        ),
                  ),
                  SizedBox(height: isWeb ? 30 : 40.h),
                  TextF(
                    labelText: "Email",
                    controller: controller.signUpemailController,
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: Palette.greyText),
                    validator: (v) => Validators.validateEmail(v),
                  ),
                  SizedBox(height: isWeb ? 16 : 20.h),
                  TextF(
                    labelText: "Password",
                    controller: controller.signUppasswordController,
                    hintText: "Enter your password",
                    obscureText: true,
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Palette.greyText),
                    validator: (v) => Validators.validatePassword(v),
                  ),
                  SizedBox(height: isWeb ? 16 : 20.h),
                  TextF(
                    labelText: "Confirm Password",
                    controller: controller.signUpconfirmPasswordController,
                    hintText: "Confirm your password",
                    obscureText: true,
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Palette.greyText),
                    validator: (v) => Validators.validateConfirmPassword(
                        v, controller.signUppasswordController.text),
                  ),
                  SizedBox(height: isWeb ? 24 : 30.h),
                  Obx(() {
                    return controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            buttonText: "Sign Up",
                            onPressed: () => controller.signUp(),
                          );
                  }),
                  SizedBox(height: isWeb ? 20 : 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Login',
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
}
