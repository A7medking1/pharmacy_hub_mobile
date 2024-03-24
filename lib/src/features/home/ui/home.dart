import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_text_formField.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/medicine_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: AppSize.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.primary.withOpacity(.05),
                    border: Border.all(color: AppColors.primary.withOpacity(.1)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppSvg.search,
                        width: 25.w,
                        color: AppColors.palePrimary,
                      ),
                      5.horizontalSpace,
                      Text("Search for medicine & wellness products", style: context.titleMedium.copyWith(fontSize: 12.sp, color: AppColors.palePrimary, height: .7, letterSpacing: .6))
                    ],
                  ),
                ),
                // CustomTextFormField(
                //   title: '',
                //   readOnly: true,
                //   hintText: 'Search for medicine & wellness products',
                //   borderColor: AppColors.primary,
                //   prefixIcon: Padding(
                //     padding: const EdgeInsets.all(3.0),
                //     child: SvgPicture.asset(
                //       AppSvg.search,
                //       width: 10,
                //       height: 10,
                //     ),
                //   ),
                // ),
                18.verticalSpace,
                Image.asset(
                  AppImages.slide,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            child: Text(
              'Categories',
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
          ),
          12.verticalSpace,
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.cat2,
                      ),
                      5.verticalSpace,
                      Text(
                        'Medicine',
                        style: context.titleSmall.copyWith(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, index) => 10.horizontalSpace,
            ),
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            child: Text(
              'Popular medicine',
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
          ),
          8.verticalSpace,

          /// AppBar Problem From Here
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              MedicineCard(),
              10.horizontalSpace,
              MedicineCard(),
              10.horizontalSpace,
              MedicineCard(),
              10.horizontalSpace,
              MedicineCard()
            ]),
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            child: Text(
              'Popular medicine',
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
          ),
          8.verticalSpace,
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              MedicineCard(),
              10.horizontalSpace,
              MedicineCard(),
              10.horizontalSpace,
              MedicineCard(),
              10.horizontalSpace,
              MedicineCard()
            ]),
          ),
          (AppSize.buttomNavigationHeight + (20.h * 1)).verticalSpace
        ],
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}

// Popular medicine
// Popular vitamins
// Popular equipment
// Popular equipment
