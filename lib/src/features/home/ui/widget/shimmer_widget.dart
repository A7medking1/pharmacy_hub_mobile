import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MedicineCardShimmer extends StatelessWidget {
  const MedicineCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 220.h,
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
                        width: 150.h,
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

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150.h,
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
