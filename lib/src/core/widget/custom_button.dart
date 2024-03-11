import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color? color;
  final Color? fontColor;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final bool isBorderButton;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color = AppColors.primary,
    this.width,
    this.fontColor = Colors.white,
    this.textStyle,
    this.height,
    this.isBorderButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      decoration: isBorderButton
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: Colors.black38,
              ))
          : null,
      child: MaterialButton(
        onPressed: onTap,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        color: color,
        child: Text(
          text,
          style: textStyle ??
              context.titleSmall
                  .copyWith(color: fontColor, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
