import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';

class ThirdStepPaymentWidget extends StatelessWidget {
  const ThirdStepPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 13.w, top: 8.h, end: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppSvg.money,
            ),
            30.verticalSpace,
            /* Container(
              padding: EdgeInsetsDirectional.all(8.h) ,
              decoration: BoxDecoration(
              color: AppCOl,
                borderRadius: BorderRadiusDirectional.circular(
                  10.r,
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.paypal,
                    height: 35.h,
                    width: 35.w,
                  ),
                ],
              ),
            )*/
            CustomButton(
              color: AppColors.backGroundColor,
              isBorderButton: true,
              widget: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppSvg.paypal,
                    height: 35.h,
                    width: 35.w,
                  ),
                  15.horizontalSpace,
                  Text(
                    'Continue with Paypal',
                    style: context.titleSmall.copyWith(),
                  ),
                ],
              ),
              onTap: () {},
            ),
            40.verticalSpace,
            CustomButton(
              color: AppColors.backGroundColor,
              isBorderButton: true,
              widget: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppSvg.stripe,
                    height: 35.h,
                    width: 35.w,
                  ),
                  15.horizontalSpace,
                  Text(
                    'Continue with Stripe',
                    style: context.titleSmall.copyWith(),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
