import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  final Icon? icon;
  final Widget? widget;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? color;
  final Color? fontColor;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final bool isBorderButton;
 
  // you can use Text or Icon or widget 'just One'
  const CustomButton(
      {super.key,
      required this.onTap,
      this.text,
      this.icon,
      this.color = AppColors.primary,
      this.width,
      this.fontColor = Colors.white,
      this.textStyle,
      this.height,
      this.isBorderButton = false,
      this.borderRadius,
      this.padding,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      decoration: isBorderButton
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius == null ? 15.r : borderRadius!),
              border: Border.all(
                color: Colors.black38,
              ))
          : null,
      child: MaterialButton(
        onPressed: onTap,
        elevation: 0.0,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius == null ? 15.r : borderRadius!),
        ),
        color: color,
        child: text != null
            ? Text(
                text!,
                style: textStyle ?? context.titleSmall.copyWith(color: fontColor, fontWeight: FontWeight.w700),
              )
            : icon ?? widget,
      ),
    );
  }
}
