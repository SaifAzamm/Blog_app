// ignore_for_file: deprecated_member_use

import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Palette.backGround,
    fontFamily: 'Poppins',
    iconTheme: const IconThemeData(color: Palette.blackText),
    dividerTheme: const DividerThemeData(color: Palette.divider),
    appBarTheme: AppBarTheme(
      backgroundColor: Palette.backGround,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Palette.blackText,
        size: _isWeb() ? 20 : 20.sp,
      ),
      actionsIconTheme: IconThemeData(
        color: Palette.blackText,
        size: _isWeb() ? 22 : 22.sp,
      ),
      titleTextStyle: TextStyle(
        fontSize: _isWeb() ? 20 : 20.sp,
        color: Palette.blackText,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.orange,
      foregroundColor: Colors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Palette.orange),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(Palette.orange),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.hovered)) {
          return Palette.orange.withOpacity(0.04);
        }
        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.pressed)) {
          return Palette.orange.withOpacity(0.12);
        }
        return null;
      }),
    ),
    dividerColor: Palette.divider,
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: _isWeb() ? 26 : 26.sp,
        color: Palette.blackText,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
      ),
      titleMedium: TextStyle(
        fontSize: _isWeb() ? 22 : 22.sp,
        color: Palette.blackText,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
      ),
      titleSmall: TextStyle(
        fontSize: _isWeb() ? 20 : 20.sp,
        color: Palette.blackText,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins",
      ),
      headlineLarge: TextStyle(
        fontSize: _isWeb() ? 18 : 18.sp,
        color: Palette.blackText,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
      ),
      headlineSmall: TextStyle(
        fontSize: _isWeb() ? 16 : 16.sp,
        color: Palette.blackText,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins",
      ),
      bodyLarge: TextStyle(
        fontSize: _isWeb() ? 16 : 16.sp,
        color: Palette.greyText,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins",
      ),
      bodyMedium: TextStyle(
        fontSize: _isWeb() ? 14 : 14.sp,
        color: Palette.darkGreyText,
        fontWeight: FontWeight.w400,
        fontFamily: "Poppins",
      ),
      bodySmall: TextStyle(
        fontSize: _isWeb() ? 12 : 12.sp,
        color: Palette.darkGreyText,
        fontWeight: FontWeight.w400,
        fontFamily: "Poppins",
      ),
    ),
  );

  static bool _isWeb() {
    return MediaQueryData.fromView(WidgetsBinding.instance.window).size.width >
        600;
  }
}
