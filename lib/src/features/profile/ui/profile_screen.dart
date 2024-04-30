import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/resources/size_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List<ProfileItem> profileItemsGroupPartOne;
  late List<ProfileItem> profileItemsGroupPartTwo;
  late List<ProfileItem> profileItemsGroupSettings;
  final ScrollController scrollController = ScrollController();

  void logout() {
    //Dialog();
    showDialog(
        context: context,
        barrierColor: AppColors.primary.withOpacity(.12),
        useSafeArea: false,
        builder: (dialogContext) {
          return Center(
            child: AnimatedContainer(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              duration: const Duration(milliseconds: 1000),
              width: 250.w,
              height: 160.h,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.black.withOpacity(.2),
                        offset: Offset(3.w, 3.h),
                        blurRadius: 16)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 25.h),
                    child: Text(
                      'Log out',
                      style: context.titleMedium
                          .copyWith(color: AppColors.white, fontSize: 20.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: Text(
                      'Are you sure ?',
                      style: context.titleMedium.copyWith(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.regular),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () async {
                            dialogContext.pop();
                            // TODO: navigate to login screen

                            await sl<AppPreferences>()
                                .removeUser()
                                .then((value) {
                              context.goNamed(Routes.login);
                            });
                          },
                          text: "Log out",
                          textStyle: context.titleSmall.copyWith(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeightManager.regular),
                          color: AppColors.white.withOpacity(.1),
                          splashColor: AppColors.white.withOpacity(.3),
                          borderRadius: 0,
                          height: 50.h,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () => dialogContext.pop(),
                          text: "Cancle",
                          textStyle: context.titleSmall.copyWith(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeightManager.regular),
                          // color: AppColors.white.withOpacity(.1),
                          splashColor: AppColors.white.withOpacity(.3),
                          borderRadius: 0,
                          height: 50.h,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    profileItemsGroupPartOne = [
      ProfileItem(
          icon: Icons.account_circle_outlined,
          text: "Account",
          onTap: () => context.pushNamed(Routes.account)),
      ProfileItem(
          imageIcon: AppSvg.cart,
          text: "Cart",
          onTap: () => context.pushNamed(Routes.cart)),
      ProfileItem(
        icon: Icons.favorite_outline_rounded,
        text: "Favorite",
        onTap: () => context.pushNamed(Routes.favScreen),
      ),
      // ProfileItem(icon:Icons.wallet, text:"Wallet",onTap:  () => null),
      // ProfileItem(icon:Icons.settings, text:"Settings",onTap:  () => null),
    ];
    profileItemsGroupPartTwo = [
      ProfileItem(
          icon: Icons.contact_support,
          text: "Contact us",
          onTap: () => context.pushNamed(Routes.contactUs)),
      ProfileItem(
          icon: Icons.error_outline,
          text: "About",
          onTap: () => context.pushNamed(Routes.about)),
      ProfileItem(
        icon: Icons.logout,
        text: "Log out",
        onTap: logout,
      )
    ];

    context.read<ProfileBloc>().add(GetUserInfoEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // controller: scrollController,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
      child: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) {
            return current is UserInfoState ? true : false;
          }, builder: (context, state) {
            if (state is UserInfoState && state.email != null) {
              return SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // User image
                    CachedNetworkImage(
                      imageUrl: state.imageUrl!,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(.05),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.person,
                          color: AppColors.black.withOpacity(.3),
                          size: 35.sp,
                        ),
                      ),
                    ),
                    15.verticalSpace,
                    // User name and email
                    Text(
                      state.name!,
                      softWrap: false,
                      style: context.titleMedium.copyWith(
                        color: AppColors.black,
                        fontSize: 18.sp,
                        height: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      state.email!,
                      softWrap: false,
                      style: context.titleMedium.copyWith(
                        color: AppColors.black.withOpacity(.5),
                        fontSize: 12.sp,
                        fontWeight: FontWeightManager.regular,
                        overflow: TextOverflow.fade,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Shimmer(
                  gradient: AppColors.shimmerColor,
                  period: const Duration(seconds: 3),
                  child: SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.2),
                              shape: BoxShape.circle),
                        ),
                        15.verticalSpace,
                        Container(
                          height: 18.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black.withOpacity(.2)),
                        ),
                        5.verticalSpace,
                        Container(
                          height: 12.h,
                          width: 85.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black.withOpacity(.2)),
                        ),
                      ],
                    ),
                  ));
            }
          }),
          // MediaQuery.paddingOf(context).top  ->  get the status bar height it like [SafeArea Widget]
          MediaQuery.paddingOf(context).top.verticalSpace,
          // 20.verticalSpace,
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: AppSize.pagePadding.w),
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
            // padding: EdgeInsets.symmetric(vertical: AppSize.pagePadding.h, horizontal: AppSize.pagePadding.w),
            decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(0.r)),
            child: Column(
              children: [
                ...profileItemsGroupPartOne.map((item) {
                  return CustomButton(
                    onTap: item.onTap,
                    height: 60.h,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.h, horizontal: (AppSize.pagePadding * 2).w),
                    color: AppColors.transparent,
                    borderRadius: 0,
                    widget: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            item.icon != null
                                ? Icon(
                                    item.icon,
                                    color: AppColors.black,
                                    size: 25.w,
                                  )
                                : SvgPicture.asset(
                                    item.imageIcon!,
                                    width: 26.w,
                                    colorFilter: ColorFilter.mode(
                                        AppColors.black, BlendMode.dst),
                                  ),
                            10.horizontalSpace,
                            Text(
                              item.text,
                              style: context.titleSmall.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  height: 0),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.black.withOpacity(.4),
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
                  padding: EdgeInsets.only(left: AppSize.pagePadding.w),
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
            // padding: EdgeInsets.symmetric(vertical: AppSize.pagePadding.h, horizontal: AppSize.pagePadding.w),
            decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(0.r)),
            child: Column(
              children: [
                ...profileItemsGroupPartTwo.map((item) {
                  return CustomButton(
                    onTap: item.onTap,
                    height: 60.h,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.h, horizontal: (AppSize.pagePadding * 2).w),
                    color: AppColors.transparent,
                    borderRadius: 0,
                    widget: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            item.icon != null
                                ? Icon(
                                    item.icon,
                                    color: AppColors.black,
                                    size: 25.w,
                                  )
                                : SvgPicture.asset(
                                    item.imageIcon!,
                                    width: 26.w,
                                    colorFilter: ColorFilter.mode(
                                        AppColors.black, BlendMode.dst),
                                  ),
                            10.horizontalSpace,
                            Text(
                              item.text,
                              style: context.titleSmall.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  height: 0),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.black.withOpacity(.4),
                          size: 25.sp,
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
          (AppSize.buttomNavigationHeight + (20.h * 1)).verticalSpace
        ],
      ),
    );
  }
}

class ProfileItem {
  IconData? icon;
  String? imageIcon;
  String text;
  Function()? onTap;

  ProfileItem({this.icon, this.imageIcon, this.text = "", this.onTap});
}
