import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';

class SecondStepAddressWidget extends StatelessWidget {
  const SecondStepAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 15.w,
            end: 15.w,
            top: 10.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppSvg.cartAddress,
                  height: 220,
                  width: 200,
                ),
                40.verticalSpace,
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 70.h,
                  padding: const EdgeInsetsDirectional.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backGroundColor,
                    borderRadius: BorderRadiusDirectional.circular(15.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppSvg.location,
                        height: 32.h,
                        colorFilter: const ColorFilter.mode(
                            AppColors.primary, BlendMode.srcIn),
                      ),
                      15.horizontalSpace,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: context.titleSmall.copyWith(
                              fontSize: 13.sp,
                            ),
                          ),
                          Text(
                            'Please choose your region',
                            style: context.titleSmall.copyWith(
                              fontSize: 13.sp,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(
                            30.r,
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () => context.pushNamed(Routes.map,
                              extra: context.read<CartBloc>()),
                          child: Text(
                            'Add',
                            style: context.titleSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.currentAddress != 'none'
                        ? Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 60.h,
                            padding: const EdgeInsetsDirectional.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.backGroundColor,
                              borderRadius:
                                  BorderRadiusDirectional.circular(15.r),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppSvg.location,
                                  height: 32.h,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                15.horizontalSpace,
                                Flexible(
                                  child: Text(
                                    state.currentAddress,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.titleSmall.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 60.h,
                            padding: const EdgeInsetsDirectional.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.backGroundColor,
                              borderRadius:
                                  BorderRadiusDirectional.circular(15.r),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppSvg.location,
                                  height: 32.h,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                15.horizontalSpace,
                                Flexible(
                                  child: Text(
                                    '${sl<AppPreferences>().getUser().city} ${sl<AppPreferences>().getUser().street}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.titleSmall.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
                /*20.verticalSpace,
                const CustomTextFormField(
                  title: '',
                  hintText: 'Governorate',
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
SvgPicture.asset(
AppSvg.location,
height: 32.h,
colorFilter: const ColorFilter.mode(
AppColors.primary,
BlendMode.srcIn,
),
),*/
