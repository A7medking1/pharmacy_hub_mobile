import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmerWidget extends StatelessWidget {
  const CartShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[100]!,
                      // Adjust the shimmer base color
                      highlightColor: Colors.grey[300]!,
                      child: const CircleAvatar(),
                    ),
                  ),
                  const DotWidget(),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[100]!,
                      // Adjust the shimmer base color
                      highlightColor: Colors.grey[300]!,
                      child: const CircleAvatar(),
                    ),
                  ),
                  const DotWidget(),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[100]!,
                      // Adjust the shimmer base color
                      highlightColor: Colors.grey[300]!,
                      child: const CircleAvatar(),
                    ),
                  ),
                ],
              ),
            ),
            50.verticalSpace,
            Shimmer.fromColors(
              baseColor: Colors.grey[100]!,
              // Adjust the shimmer base color
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: 30.w,
                width: 80.h,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color:
                      Colors.white, // Background color for the shimmer effect
                ),
              ),
            ),
            10.verticalSpace,
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 0.w, vertical: 10.h),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[100]!,
                    // Adjust the shimmer base color
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      height: 100.w,
                      //     width: 100.h,
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
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 20.h),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[100]!,
                // Adjust the shimmer base color
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: 80.w,
                  //     width: 100.h,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color:
                        Colors.white, // Background color for the shimmer effect
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  const DotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(7, (index) {
        return Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Container(height: 1, width: 5, color: Colors.grey.shade500),
        );
      }),
    );
  }
}
