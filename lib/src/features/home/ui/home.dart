import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_text_formField.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              title: '',
              readOnly: true,
              hintText: 'Search for medicine & wellness products',
              borderColor: AppColors.primary,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(3.0),
                child: SvgPicture.asset(
                  AppSvg.search,
                  width: 10,
                  height: 10,
                ),
              ),
            ),
            18.verticalSpace,
            Image.asset(
              AppImages.slide,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.contain,
            ),
            20.verticalSpace,
            Text(
              'Categories',
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
            12.verticalSpace,
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
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
            Text(
              'Popular medicine',
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
            8.verticalSpace,
            SizedBox(
              height: 260,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const MedicineCard();
                },
              ),
            ),
            20.verticalSpace,
            Text(
              'Popular medicine',
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
            8.verticalSpace,
            SizedBox(
              height: 260,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const MedicineCard();
                },
              ),
            ),
            20.verticalSpace,
            Text(
              'Popular medicine',
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
            8.verticalSpace,
            SizedBox(
              height: 260,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const MedicineCard();
                },
              ),
            ),
            20.verticalSpace,
            Text(
              'Popular medicine',
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
            8.verticalSpace,
            SizedBox(
              height: 260,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const MedicineCard();
                },
              ),
            ),
            (AppSize.buttomNavigationHeight + (20.h * 1)).verticalSpace
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)),
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: 210.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFFD2C9C3),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(20.r),
                          topEnd: Radius.circular(20.r))),
                ),
                Image.asset(
                  AppImages.medicine,
                  fit: BoxFit.cover,
                ),
                PositionedDirectional(
                  top: 2,
                  end: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            print('xx');
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              AppSvg.heart,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        8.verticalSpace,
                        InkWell(
                          onTap: () {
                            print('xx');
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              AppSvg.cartSmall,
                              height: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 210.w,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strepsils Honey & Lemon',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleSmall.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      'EGP 40.00 ',
                      style: context.titleSmall
                          .copyWith(fontSize: 13.sp, color: AppColors.primary),
                    ),
                    5.verticalSpace,
                    Text(
                      'Available in:',
                      style: context.titleSmall.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),
                    Wrap(
                      spacing: 5,
                      // Add some space between the chips, if needed
                      children: phramacies
                          .map((e) => Chip(
                                padding: const EdgeInsets.all(1),
                                // Adjust the overall padding of the chip
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 2),

                                label: Text(
                                  e,
                                  style: context.titleSmall.copyWith(
                                      fontSize: 12.sp, color: Colors.black54),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> phramacies = [
  'Egy phar.',
  'One phar.',
  'Egy phar.',
];

// Popular medicine
// Popular vitamins
// Popular equipment
// Popular equipment
