import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          bottom: 20.h,
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              const GoogleMap(
                compassEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    31.039766446743734,
                    31.380098058259826,
                  ),
                  zoom: 17,
                ),
              ),
              CustomButton(
                onTap: () => context.pop(),
                width: 80.h,
                height: 80.h,
                color: AppColors.transparent,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Platform.isIOS
                      ? Icons.arrow_back_ios_new_rounded
                      : Icons.arrow_back_rounded,
                  color: AppColors.black,
                  size: 30.w,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 10.h,
                    end: 20.w,
                  ),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width - 100.w,
                    padding: const EdgeInsetsDirectional.all(7),
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(1),
                      borderRadius: BorderRadiusDirectional.circular(
                        20.r,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppSvg.location,
                          height: 32.h,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        10.horizontalSpace,
                        Text(
                          '100 st , mansora , dakahlia',
                          style: context.titleSmall.copyWith(
                            fontSize: 17.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.sp,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    bottom: 15.h,
                  ),
                  child: CustomButton(
                    width: 170.w,
                    onTap: () {},
                    text: 'Save Address',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
