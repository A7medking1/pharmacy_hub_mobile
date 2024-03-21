import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  List<ProfileItem> profileItemsGroupPartOne = [
    ProfileItem(Icons.account_circle_outlined, "Account", () => null),
    ProfileItem(Icons.wallet, "Wallet", () => null),
    ProfileItem(Icons.settings, "Settings", () => null),
  ];

  List<ProfileItem> profileItemsGroupPartTwo = [
    ProfileItem(Icons.contact_support, "Contact Us", () => null),
    ProfileItem(Icons.error_outline, "About", () => null),
    ProfileItem(Icons.logout, "Log Out", () => null)
  ];

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetUserInfoEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsetsDirectional.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              // 30.verticalSpace,
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                decoration: BoxDecoration(
                    color: AppColors.palePrimary,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                        buildWhen: (previous, current) {
                      // it will call the builder funcion when do emit ot UserInfoState Just
                      return current is UserInfoState ? true : false;
                    }, builder: (context, state) {
                      if (state is UserInfoState && state.email != null) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CachedNetworkImage(
                              imageUrl: state.imageUrl!,
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(.4),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.black.withOpacity(.3),
                                  size: 35.sp,
                                ),
                              ),
                            ),
                            15.horizontalSpace,
                            SizedBox(
                              width: 0.2.sh,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.name!,
                                          softWrap: false,
                                          style: context.titleMedium.copyWith(
                                            color: AppColors.white,
                                            fontSize: 17.sp,
                                            height: 1,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                        Text(
                                          state.email!,
                                          softWrap: false,
                                          style: context.titleMedium.copyWith(
                                            color:
                                                AppColors.white.withOpacity(.5),
                                            fontSize: 12.sp,
                                            fontWeight:
                                                FontWeightManager.regular,
                                            overflow: TextOverflow.fade,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return Shimmer(
                            gradient: AppColors.shimmerColor,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 80.w,
                                  height: 80.h,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                ),
                                15.horizontalSpace,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 12.h,
                                      width: 75.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white),
                                    ),
                                    5.verticalSpace,
                                    Container(
                                      height: 12.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ));
                      }
                    }),
                    CustomButton(
                      onTap: () {},
                      width: 45.w,
                      height: 45.h,
                      borderRadius: 25.r,
                      padding: EdgeInsets.zero,
                      color: AppColors.transparent,
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: 20.sp,
                      ),
                    )
                  ],
                ),
              ),

              20.verticalSpace,
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "ACCOUNT SETTING",
                        style: context.titleSmall.copyWith(
                            color: AppColors.black.withOpacity(.7),
                            fontSize: 14.sp),
                      )),
                ],
              ),
              10.verticalSpace,
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: double.infinity,
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                decoration: BoxDecoration(
                    color: AppColors.palePrimary,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Column(
                  children: [
                    ...profileItemsGroupPartOne.map((item) {
                      return CustomButton(
                        onTap: item.onTap,
                        height: 60.h,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.h, horizontal: 20.w),
                        color: AppColors.transparent,
                        borderRadius: 0,
                        widget: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  item.icon,
                                  color: AppColors.white,
                                  size: 25.sp,
                                ),
                                10.horizontalSpace,
                                Text(
                                  item.text,
                                  style: context.titleSmall.copyWith(
                                      fontSize: 16.sp,
                                      color: AppColors.white,
                                      height: 0),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next_rounded,
                              color: AppColors.white.withOpacity(.6),
                              size: 25.sp,
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
              20.verticalSpace,
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "PREFERENCES",
                        style: context.titleSmall.copyWith(
                            color: AppColors.black.withOpacity(.7),
                            fontSize: 14.sp),
                      )),
                ],
              ),
              10.verticalSpace,
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: double.infinity,
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                decoration: BoxDecoration(
                    color: AppColors.palePrimary,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Column(
                  children: [
                    ...profileItemsGroupPartTwo.map((item) {
                      return CustomButton(
                        onTap: item.onTap,
                        height: 60.h,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.h, horizontal: 20.w),
                        color: AppColors.transparent,
                        borderRadius: 0,
                        widget: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  item.icon,
                                  color: AppColors.white,
                                  size: 25.sp,
                                ),
                                10.horizontalSpace,
                                Text(
                                  item.text,
                                  style: context.titleSmall.copyWith(
                                      fontSize: 16.sp,
                                      color: AppColors.white,
                                      height: 0),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.navigate_next_rounded,
                              color: AppColors.white.withOpacity(.6),
                              size: 25.sp,
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ProfileItem {
  IconData icon;
  String text;
  Function() onTap;

  ProfileItem(this.icon, this.text, this.onTap);
}
