import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/cached_image_network.dart';
import 'package:pharmacy_hub/src/core/widget/list_view_horizontal.dart';
import 'package:pharmacy_hub/src/features/home/data/models/category_model.dart';
import 'package:pharmacy_hub/src/features/home/ui/all_product_screen.dart';
import 'package:shimmer/shimmer.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          15.verticalSpace,
          ListViewHorizontal(
            count: categories.length,
            height: 100.h,
            tag: categories.length,
            isHasViewAllWidget: false,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ProductType type = ProductTypeExtension.fromIndex(index);
                  context.pushNamed(Routes.allProduct,
                      extra: AllProductScreenParams(
                          productType: type,
                          categoryId: (index + 1).toString(),
                          tag: 'ProductTypeExtension $type}'));
                },
                child: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag:
                            'ProductTypeExtension ${ProductTypeExtension.fromIndex(index)}}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0.r),
                          child: CachedImages(
                            width: 60.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                            imageUrl: categories[index].pictureUrl,
                          ),
                        ),
                      ),
                      5.verticalSpace,
                      Text(
                        categories[index].name,
                        style: context.titleSmall.copyWith(
                            fontSize: 10.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
