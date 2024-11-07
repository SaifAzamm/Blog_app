import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatefulWidget {
  final String buttonText;
  final Function()? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double? borderRadius;
  final Color? backColor;
  final Color? textColor;
  final bool? onDisableWorks;
  final FontWeight? weight;
  final double? height;
  final double? textSize;

  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.borderRadius,
    this.backColor,
    this.onDisableWorks = false,
    this.textColor,
    this.weight,
    this.height,
    this.textSize,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    bool shouldWorkWhenDisabled = widget.isDisabled && widget.onDisableWorks!;
    final isWeb = MediaQuery.of(context).size.width > 600;

    return ElevatedButton(
      onPressed:
          (widget.isDisabled && !shouldWorkWhenDisabled) || widget.isLoading
              ? null
              : widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isDisabled
            ? Palette.lightGrey // Disabled button color
            : widget.backColor ?? Palette.orange, // Active button color
        minimumSize: Size(double.infinity,
            widget.height ?? (isWeb ? 48 : 48.h)), // Button height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              widget.borderRadius ?? 8.r), // Rounded corners
        ),
        elevation: widget.isDisabled ? 0 : 4, // Dynamic elevation
        padding:
            EdgeInsets.symmetric(vertical: 12.h), // Padding for better spacing
      ),
      child: widget.isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                color: widget.textColor ?? Palette.whiteSmoke,
                strokeWidth: 2,
              ),
            )
          : Text(
              widget.buttonText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: widget.weight ?? FontWeight.w600,
                    fontSize: widget.textSize ?? (isWeb ? 16 : 16.h),
                    color: widget.isDisabled
                        ? Palette.darkGreyText // Disabled text color
                        : widget.textColor ??
                            Palette.whiteSmoke, // Default text color
                  ),
            ),
    );
  }
}
