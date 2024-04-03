import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/cached_image_network.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';

class VitaminsCard extends StatelessWidget {
  const VitaminsCard({super.key, required this.product});

  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
          child: Text(
            'Popular vitamins',
            style: context.titleMedium.copyWith(
              color: AppColors.primary,
              fontSize: 20.sp,
            ),
          ),
        ),
        15.verticalSpace,
        SizedBox(
          height: 270.h,
          child: ListView.separated(
            itemCount: product.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            separatorBuilder: (context, index) => 15.horizontalSpace,

            itemBuilder: (context, index) {
              final ProductModel model = product[index];
              return FittedBox(
                child: Container(
                  height: 240.h,
                  width: 160.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.primary.withOpacity(.03),
                    border:
                        Border.all(color: AppColors.primary.withOpacity(.1)),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: CachedImages(
                                imageUrl: model.pictureUrl,
                                width: 100.w,
                                height: 100.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                            10.verticalSpace,
                            Text(
                              model.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleSmall.copyWith(
                                  height: 1.15,
                                  fontSize: 14.sp,
                                  color: AppColors.black),
                            ),
                            5.verticalSpace,
                            Text(
                              'EGP ${model.price}',
                              style: context.titleSmall.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeightManager.regular),
                            ),
                            5.verticalSpace,
                            Text(
                              'Available in',
                              style: context.titleSmall.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeightManager.regular),
                            ),
                            1.verticalSpace,
                            Wrap(
                              children: model.pharmacies
                                  .map((e) => Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.h, horizontal: 3.w),
                                        margin: EdgeInsets.only(
                                            right: 2.w, bottom: 2.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          color: AppColors.primary
                                              .withOpacity(.03),
                                          border: Border.all(
                                              color: AppColors.primary
                                                  .withOpacity(.1)),
                                        ),
                                        child: Text(
                                          e,
                                          style: context.titleSmall.copyWith(
                                              fontSize: 8.sp,
                                              color: AppColors.black
                                                  .withOpacity(.8)),
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
                              onTap: () {},
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
                              onTap: () {},
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
