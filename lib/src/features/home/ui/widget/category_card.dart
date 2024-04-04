import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/cached_image_network.dart';
import 'package:pharmacy_hub/src/core/widget/list_view_horizontal.dart';
import 'package:pharmacy_hub/src/features/home/data/models/category_model.dart';
import 'package:shimmer/shimmer.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 100,
          isHasViewAllWidget: false,
          itemBuilder: (context, index) {
            return FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0.r),
                    child: CachedImages(
                      width: 60.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                      imageUrl: categories[index].pictureUrl,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    categories[index].name,
                    style: context.titleSmall
                        .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 160.h,
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
                        height: 80.w,
                        width: 100.h,
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
