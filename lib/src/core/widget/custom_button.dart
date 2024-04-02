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
  final Color? splashColor;
  final Color? highlightColor;

  // you can use Text or Icon or widget 'just One'
  const CustomButton({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.widget,
    this.color = AppColors.primary,
    this.splashColor,
    this.highlightColor,
    this.width,
    this.fontColor = Colors.white,
    this.textStyle,
    this.height,
    this.isBorderButton = false,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.sizeOf(context).width,
      height: height ?? 50.h,
      decoration: isBorderButton
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(
                  borderRadius == null ? 15.r : borderRadius!),
              border: Border.all(
                color: Colors.black38,
              ))
          : null,
      child: MaterialButton(
        onPressed: onTap,
        elevation: 0.0,
        splashColor: splashColor ?? AppColors.primary.withOpacity(.1),
        highlightColor: highlightColor ?? AppColors.primary.withOpacity(.1),
        highlightElevation: 0,
        // this attribute remove the shadow under the button in 'long press' state
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              borderRadius == null ? 15.r : borderRadius!),
        ),
        color: color,
        child: text != null
            ? Text(
                text!,
                style: textStyle ??
                    context.titleSmall.copyWith(
                        color: fontColor, fontWeight: FontWeight.w700),
              )
            : icon ?? widget,
      ),
    );
  }
}
