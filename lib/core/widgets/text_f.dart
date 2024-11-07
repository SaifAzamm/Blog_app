import 'package:ass_blog_app/core/config/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextF extends StatefulWidget {
  const TextF({
    super.key,
    this.title,
    this.curFocusNode,
    this.nextFocusNode,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.suffixIcon,
    this.controller,
    this.onTap,
    this.textAlign,
    this.enable,
    this.inputFormatter,
    this.minLine,
    this.maxLine,
    this.prefixIcon,
    this.isHintVisible = true,
    this.prefixText,
    this.hintText,
    this.autofillHints,
    this.semantic,
    this.labelText,
    this.focusBorderColor,
    this.radius,
    this.height,
    this.readOnly,
    this.showCursor,
    this.textStyle,
    this.contentHorizontalPadding,
    this.contentVerticalPadding,
    this.maxLength,
    this.autofocus,
    this.textCapitalization,
  });

  final String? title;
  final FocusNode? curFocusNode;
  final FocusNode? nextFocusNode;
  final String? labelText;
  final Function(String?)? validator;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? obscureText;
  final int? minLine;
  final int? maxLine;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatter;
  final bool isHintVisible;
  final Widget? prefixIcon;
  final String? prefixText;
  final String? hintText;
  final Iterable<String>? autofillHints;
  final String? semantic;
  final Color? focusBorderColor;
  final double? radius;
  final double? height;
  final bool? showCursor;
  final bool? readOnly;
  final bool? autofocus;
  final TextStyle? textStyle;
  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;
  final int? maxLength;
  final TextCapitalization? textCapitalization;

  @override
  TextFState createState() => TextFState();
}

class TextFState extends State<TextF> {
  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: EdgeInsets.only(bottom: isWeb ? 8 : 8.h),
            child: Text(
              widget.title!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: isWeb ? 16 : 14.sp,
                    color: Palette.blackText,
                  ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: Palette.whiteSmoke,
            borderRadius:
                BorderRadius.circular(widget.radius ?? (isWeb ? 8 : 12.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            autofocus: widget.autofocus ?? false,
            readOnly: widget.readOnly ?? false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofillHints: widget.autofillHints,
            enabled: widget.enable,
            obscureText: widget.obscureText ?? false,
            focusNode: widget.curFocusNode,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            textAlign: widget.textAlign ?? TextAlign.start,
            minLines: widget.minLine ?? 1,
            maxLines: widget.maxLine ?? 1,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatter,
            style: widget.textStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Palette.blackText,
                      fontSize: isWeb ? 14 : 14.sp,
                    ),
            cursorColor: Palette.primary,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            decoration: InputDecoration(
              filled: true,
              fillColor: Palette.backGround,
              focusColor: Colors.white,
              prefixText: widget.prefixText,
              alignLabelWithHint: true,
              isDense: true,
              hintText: widget.hintText,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                fontSize: isWeb ? 14 : 14.sp,
                fontWeight: FontWeight.w500,
                color: Palette.blackText,
              ),
              hintStyle: TextStyle(
                fontSize: isWeb ? 14 : 14.sp,
                fontWeight: FontWeight.w400,
                color: Palette.hintText.withOpacity(0.7),
              ),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.contentVerticalPadding ?? (isWeb ? 14 : 16.h),
                horizontal:
                    widget.contentHorizontalPadding ?? (isWeb ? 18 : 20.w),
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.radius ?? (isWeb ? 8 : 12.r)),
                borderSide:
                    const BorderSide(color: Palette.lightGrey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.radius ?? (isWeb ? 8 : 12.r)),
                borderSide:
                    const BorderSide(color: Palette.lightGrey, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.radius ?? (isWeb ? 8 : 12.r)),
                borderSide: const BorderSide(color: Palette.lightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.radius ?? (isWeb ? 8 : 12.r)),
                borderSide: const BorderSide(color: Palette.blue, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.radius ?? (isWeb ? 8 : 12.r)),
                borderSide: const BorderSide(color: Palette.darkRed, width: 1),
              ),
            ),
            validator: widget.validator as String? Function(String?)?,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
          ),
        ),
      ],
    );
  }
}
