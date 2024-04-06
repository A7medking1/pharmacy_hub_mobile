import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';

class TextAndLogo extends StatelessWidget {
  const TextAndLogo({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.logo,
          height: 170.h,
          width: 170.w,
        ),
        15.verticalSpace,
        Text(
          text,
          style: context.titleMedium.copyWith(),
        ),
      ],
    );
  }
}
