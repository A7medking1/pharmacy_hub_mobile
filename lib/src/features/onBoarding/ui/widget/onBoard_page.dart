import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';

class onBoardPage extends StatelessWidget {
  String image;
  String text;
  onBoardPage({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
              top: 20.h,
              bottom: 20.h,
              start: 20.w,
              end: 20.w,
            ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: .22.sh,),

            SvgPicture.asset(
              image,
              width: 300.w,
            ),
            
            20.verticalSpace,
            
            Text(
              text,
              style: context.titleSmall.copyWith(fontSize: 18.sp, height: 1.3),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
