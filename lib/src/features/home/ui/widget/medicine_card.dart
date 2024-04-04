import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/cached_image_network.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/core/widget/list_view_horizontal.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';
import 'package:shimmer/shimmer.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key, required this.product});

  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    double calculatedHeight = MediaQuery.of(context).size.height *
        0.26; // Example: 30% of screen height

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        15.verticalSpace,
        ListViewHorizontal(
          count: product.length,
          onTapViewAll: () {},
          height: calculatedHeight,
          itemBuilder: (context, index) {
            UniqueKey _key = UniqueKey();

            final ProductModel model = product[index];
            return Hero(
              tag: _key.toString(),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.productDetails,
                      extra: ProductDetailsParams(
                          productModel: model, uniqueKey: _key));
                },
                child: MedicineItem(
                  model: model,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MedicineItem extends StatelessWidget {
  const MedicineItem({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 250.h,
      width: 180.w,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.primary.withOpacity(.03),
        border: Border.all(color: AppColors.primary.withOpacity(.1)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: CachedImages(
                    imageUrl: model.pictureUrl,
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),
                10.verticalSpace,
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall.copyWith(
                        height: 1.15, fontSize: 14.sp, color: AppColors.black),
                  ),
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
                      fontSize: 12.sp, fontWeight: FontWeightManager.regular),
                ),
                1.verticalSpace,
                Expanded(
                  child: Wrap(
                    children: model.pharmacies
                        .map((e) => Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 3.w),
                              margin: EdgeInsets.only(right: 2.w, bottom: 5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: AppColors.primary.withOpacity(.03),
                                border: Border.all(
                                    color: AppColors.primary.withOpacity(.1)),
                              ),
                              child: Text(
                                e,
                                style: context.titleSmall.copyWith(
                                    fontSize: 8.sp,
                                    color: AppColors.black.withOpacity(.8)),
                              ),
                            ))
                        .toList(),
                  ),
                ),
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
    );
  }
}

List<String> phramacies = [
  'Egy phar.',
  'One phar.',
  'Egy phar.',
  'Egy phar.',
  'One phar.',
  'Egy phar.',
  'Egy phar.',
  'One phar.',
  'Egy phar.',
  'Egy phar.',
  'One phar.',
  'Egy phar.',
];

class MedicineCardShimmer extends StatelessWidget {
  const MedicineCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 280.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[100]!,
                // Adjust the shimmer base color
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: 30.w,
                  width: 110.h,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color:
                        Colors.white, // Background color for the shimmer effect
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[100]!,
                      // Adjust the shimmer base color
                      highlightColor: Colors.grey[300]!,
                      // Adjust the shimmer highlight color
                      child: Container(
                        height: 200.w,
                        width: 180.h,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors
                              .white, // Background color for the shimmer effect
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
