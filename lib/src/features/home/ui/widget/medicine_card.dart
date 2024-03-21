import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';

Widget MedicineCard(BuildContext context) {
  return Container(
    height: 270,
    width: 180,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.primary.withOpacity(.03),
        border: Border.all(color: AppColors.primary.withOpacity(.1)),
        boxShadow: [
          // BoxShadow(
          //   color: AppColors.black.withOpacity(.05),
          //   blurRadius: 10,
          //   // offset: const Offset(2,2)
          // )
        ]),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Image.asset(
                  AppImages.medicine,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
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
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        PositionedDirectional(
          top: 2,
          end: 3,
          child: Column(
            children: [
              CustomButton(
                onTap: () => null,
                width: 40.w,
                height: 40.h,
                borderRadius: 999,
                padding: EdgeInsets.zero,
                color: AppColors.transparent,
                icon: Icon(
                  Icons.favorite_outline_rounded,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ),
              CustomButton(
                onTap: () => null,
                width: 40.w,
                height: 40.h,
                borderRadius: 999,
                padding: EdgeInsets.zero,
                color: AppColors.transparent,
                icon: Icon(
                  Icons.add_shopping_cart_rounded,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

List<String> phramacies = [
  'Egy phar.',
  'One phar.',
  'Egy phar.',
];