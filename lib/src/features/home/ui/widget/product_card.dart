import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/cached_image_network.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/core/widget/list_view_horizontal.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.title,
    this.listViewHeight = 250,
    this.onTapViewAll,
    required this.tag,
    required this.productType,
    required this.similar,
  });

  final List<ProductModel> product;
  final List<ProductModel> similar;
  final String title;
  final double listViewHeight;
  final void Function()? onTapViewAll;
  final Object tag;
  final ProductType productType;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            child: Text(
              title,
              style: context.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 20.sp,
              ),
            ),
          ),
          15.verticalSpace,
          ListViewHorizontal(
            count: product.length,
            height: listViewHeight.h,
            onTapViewAll: onTapViewAll,
            tag: tag,
            itemBuilder: (context, index) {
              UniqueKey _key = UniqueKey();
              final ProductModel model = product[index];
              return Hero(
                tag: _key.toString(),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.productDetails,
                        extra: ProductDetailsParams(
                          productType: productType,
                          productModel: model,
                          uniqueKey: _key,
                          similar: similar,
                        ));
                  },
                  child: ProductItemWidget(model: model),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: 160.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.primary.withOpacity(.03),
          border: Border.all(color: AppColors.primary.withOpacity(.1)),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall
                        .copyWith(fontSize: 12.sp, color: AppColors.black),
                  ),
                  5.verticalSpace,
                  Text(
                    'EGP ${model.price}',
                    style: context.titleSmall.copyWith(
                        fontSize: 12.sp,
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
                  Wrap(
                    children: model.pharmacies
                        .map((e) => Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 3.w),
                              margin: EdgeInsets.only(right: 2.w, bottom: 2.h),
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
                  )
                ],
              ),
            ),
            Column(
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
          ],
        ),
      ),
    );
  }
}
