import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.w,
      width: 180.h,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.primary.withOpacity(.03),
          border: Border.all(color: AppColors.primary.withOpacity(.1)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Center(
                    child: Image.asset(
                      AppImages.medicine,
                      fit:BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Strepsils Honey & Lemon',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.titleSmall.copyWith(
                      height: 1.15,
                      fontSize: 14.sp,
                      color: AppColors.black),
                ),
                // 5.verticalSpace,
                Text(
                  'EGP 40.00 ',
                  style: context.titleSmall.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeightManager.regular),
                ),
                3.verticalSpace,
                Text(
                  'Available in',
                  style: context.titleSmall.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeightManager.regular),
                ),
                1.verticalSpace,
                Wrap(
                  children: phramacies
                      .map((e) => Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 5.h, horizontal: 10.w),
                    margin: EdgeInsets.only(
                        right: 5.w, bottom: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: AppColors.primary.withOpacity(.03),
                      border: Border.all(
                          color: AppColors.primary
                              .withOpacity(.1)),
                    ),
                    child: Text(
                      e,
                      style: context.titleSmall.copyWith(
                          fontSize: 10.sp,
                          color:
                          AppColors.black.withOpacity(.8)),
                    ),
                  ))
                      .toList(),
                )
              ],
            ),
          ),
          PositionedDirectional(
            top: 2,
            end: 3,
            child: Column(
              children: [
                CustomButton(
                  onTap: () => null,
                  width: 40.h,
                  height: 40.h,
                  borderRadius: 999,
                  padding: EdgeInsets.zero,
                  color: AppColors.transparent,
                  icon: Icon(
                    Icons.favorite_outline_rounded,
                    color: AppColors.primary,
                    size: 20.h,
                  ),
                ),
                CustomButton(
                  onTap: () => null,
                  width: 40.h,
                  height: 40.h,
                  borderRadius: 999,
                  padding: EdgeInsets.zero,
                  color: AppColors.transparent,
                  icon: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: AppColors.primary,
                    size: 20.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<String> phramacies = [
  'Egy phar.',
  'One phar.',
  'Egy phar.',
];