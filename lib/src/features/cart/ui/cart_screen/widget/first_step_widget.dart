import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';

class FirstStepCartWidget extends StatelessWidget {
  const FirstStepCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 13.w, top: 8.h, end: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Order',
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            5.verticalSpace,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => Card(
                  color: AppColors.backGroundColor,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppImages.cart1,
                          fit: BoxFit.cover,
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cataflam 50mg',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.titleSmall.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              10.verticalSpace,
                              Text(
                                'x5',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.titleSmall.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        5.horizontalSpace,
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(
                            'EGP 350',
                            style: context.titleSmall.copyWith(
                              fontSize: 13.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => 5.verticalSpace,
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
