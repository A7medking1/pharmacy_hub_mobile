import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          200.verticalSpace,
          SvgPicture.asset(
            AppSvg.cart,
            height: 100.h,
          ),
          15.verticalSpace,
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Your cart is empty. Let\'s add some products!',
              style: context.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
