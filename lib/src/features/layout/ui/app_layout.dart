import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/home/ui/home.dart';
import 'package:pharmacy_hub/src/features/layout/logic/app_layout_bloc.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';
import 'package:pharmacy_hub/src/features/profile/ui/profile_screen.dart';

class AppLayOut extends StatefulWidget {
  const AppLayOut({super.key});

  @override
  State<AppLayOut> createState() => _AppLayOutState();
}

class _AppLayOutState extends State<AppLayOut> {
  late List<Widget> screens;
  ScrollController nestedScrollController = ScrollController();

  void hideAppBar() => nestedScrollController.animateTo(
      nestedScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn);

  @override
  void initState() {
    // I init the screens in initstate so the BlocProvider it work fine
    screens = [
      const HomeScreen(),
      const Center(child: Text('second')),
      // const Center(child: Text('third')),
      BlocProvider(
        create: (context) => ProfileBloc(),
        child: const ProfileScreen(),
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: nestedScrollController,
        scrollBehavior: ScrollBehavior(),
        headerSliverBuilder: (_, b) {
          return [
            SliverAppBar(
              flexibleSpace: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 90.h,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.black.withOpacity(.2),
                            offset: Offset(3.w, 3.h),
                            blurRadius: 16)
                      ]),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppSvg.appBarIcon,
                        ),
                        10.horizontalSpace,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'PHARMACY HUB',
                              style: GoogleFonts.dosis(
                                fontSize: 18.sp,
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              // color: Colors.red,
                              child: IconButton(
                                onPressed: () {
                                  context.pushNamed(Routes.cart);
                                },
                                icon: Hero(
                                  tag: 'cart',

                                  child: SvgPicture.asset(
                                    AppSvg.cart,
                                    color: Colors.white,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // leading icon
                        Container(
                          alignment: Alignment.center,
                          // color: Colors.red,
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              AppSvg.notification,
                              color: Colors.white,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              backgroundColor: AppColors.transparent,
              surfaceTintColor: AppColors.transparent,
              foregroundColor: AppColors.transparent,
              expandedHeight: kToolbarHeight * 2,
              floating: true,
              snap: true,
            )
          ];
        },
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              items: [
                const HomeScreen(),
                const Center(child: Text('second')),
                BlocProvider(
                  create: (context) => ProfileBloc(),
                  child: const ProfileScreen(),
                ),

              ],
              carouselController:
                  context.read<AppLayoutBloc>().carouselController,
              options: CarouselOptions(
                  height: double.infinity,
                  aspectRatio: 1,
                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged:
                      (int pageIndex, CarouselPageChangedReason reason) {
                    if (pageIndex == screens.length - 1) hideAppBar();
                    context
                        .read<AppLayoutBloc>()
                        .onTapChange(pageIndex, reason);
                  }),
            ),

            /// Bottom navigation
            Container(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              height: AppSize.buttomNavigationHeight,
              width: 0.7.sw,
              margin: EdgeInsets.symmetric(
                  vertical: AppSize.pagePadding.h,
                  horizontal: AppSize.pagePadding.w),
              // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.black.withOpacity(.2),
                        offset: Offset(3.w, 3.h),
                        blurRadius: 16)
                  ]),
              child: BlocBuilder<AppLayoutBloc, AppLayoutState>(
                buildWhen: (previous, current) => (current is TapChangeState),
                builder: (_, state) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: buttomTap(
                            title: 'Home',
                            index: 0,
                            selectedIcon: AppSvg.home,
                            onTap: () {
                              context
                                  .read<AppLayoutBloc>()
                                  .add(AnimatePageTo(0));
                            }),
                      ),
                      Expanded(
                        child: buttomTap(
                            index: 1,
                            title: 'favorites',
                            selectedIcon: AppSvg.fav,
                            onTap: () {
                              context
                                  .read<AppLayoutBloc>()
                                  .add(AnimatePageTo(1));
                            }),
                      ),
                      // Expanded(
                      //   child: buttomTap(
                      //       title: 'Cart',
                      //       index: 2,
                      //       selectedIcon: AppSvg.cart,
                      //       onTap: () {
                      //         context.read<AppLayoutBloc>().add(AnimatePageTo(2));
                      //       }),
                      // ),
                      Expanded(
                        child: buttomTap(
                            title: 'Profile',
                            index: 2,
                            selectedIcon: AppSvg.profile,
                            onTap: () {
                              hideAppBar();
                              context
                                  .read<AppLayoutBloc>()
                                  .add(AnimatePageTo(2));
                            }),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buttomTap({
    required int index,
    required String selectedIcon,
    required String title,
    required void Function()? onTap,
  }) {
    return CustomButton(
        onTap: onTap,
        height: double.infinity,
        splashColor: AppColors.white.withOpacity(.1),
        borderRadius: 0,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              selectedIcon,
              width: 25.sp,
              colorFilter: ColorFilter.mode(
                  context.read<AppLayoutBloc>().currentTap == index
                      ? AppColors.white
                      : AppColors.white.withOpacity(.6),
                  BlendMode.srcIn),
            ),
            context.read<AppLayoutBloc>().currentTap == index
                ? 3.verticalSpace
                : const SizedBox.shrink(),
            context.read<AppLayoutBloc>().currentTap == index
                ? Text(
                    title,
                    style: context.titleSmall.copyWith(
                      color: context.read<AppLayoutBloc>().currentTap == index
                          ? AppColors.white
                          : AppColors.white.withOpacity(.6),
                      fontSize: 12.sp,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }
}

// class DefaultAppBar extends StatelessWidget {
//   const DefaultAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
//       child: AppBar(
//         backgroundColor: AppColors.primaryWithOp,
//         leading: Container(
//           alignment: Alignment.center,
//           // color: Colors.red,
//           child: IconButton(
//             onPressed: () {},
//             icon: SvgPicture.asset(
//               AppSvg.notification,
//               color: Colors.white,
//               fit: BoxFit.scaleDown,
//             ),
//           ),
//         ),
//         actions: [
//           Column(
//             children: [
//               Container(
//                 margin: EdgeInsetsDirectional.only(
//                   top: 9.h,
//                 ),
//                 child: Text(
//                   'PHARMACY HUB',
//                   style: GoogleFonts.dosis(
//                     fontSize: 18.sp,
//                     textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 'Your medicine with one click',
//                 style: context.titleSmall.copyWith(
//                   fontSize: 10.sp,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           10.horizontalSpace,
//           Container(
//             margin: EdgeInsetsDirectional.only(end: 8.w, top: 10.h),
//             child: SvgPicture.asset(
//               AppSvg.appBarIcon,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
