import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/features/home/ui/home.dart';
import 'package:pharmacy_hub/src/features/profile/ui/profile_screen.dart';

class AppLayOut extends StatefulWidget {
  const AppLayOut({super.key});

  @override
  State<AppLayOut> createState() => _AppLayOutState();
}

class _AppLayOutState extends State<AppLayOut> {
  final List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('second')),
    const Center(child: Text('third')),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 15.h),
        child: const DefaultAppBar(),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight * 1.7,
        decoration: BoxDecoration(
            color: AppColors.primaryWithOp,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            )),
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 30.w, end: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSvgIcon(
                  title: 'Home',
                  index: 0,
                  selectedIcon: AppSvg.home,
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  }),
              buildSvgIcon(
                index: 1,
                title: 'favorites',
                selectedIcon: AppSvg.profile,
                onTap: () {
                  setState(
                    () {
                      currentIndex = 1;
                    },
                  );
                },
              ),
              buildSvgIcon(
                  title: 'Cart',
                  index: 2,
                  selectedIcon: AppSvg.cart,
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  }),
              buildSvgIcon(
                  title: 'Profile',
                  index: 3,
                  selectedIcon: AppSvg.profile,
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSvgIcon({
    required int index,
    required String selectedIcon,
    required String title,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SvgPicture.asset(
              selectedIcon,
              width: 25,
              color: currentIndex == index ? AppColors.white : Colors.black,
              // height: 25,
            ),
            10.verticalSpace,
            Text(
              title,
              style: context.titleSmall.copyWith(
                color: currentIndex == index ? AppColors.white : Colors.black,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
      child: AppBar(
        backgroundColor: AppColors.primaryWithOp,
        leading: const Icon(
          Icons.notifications_none,
          color: Colors.white,
          size: 27,
        ),
        actions: [
          Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(
                  top: 9.h,
                ),
                child: Text(
                  'PHARMACY HUB',
                  style: GoogleFonts.dosis(
                    fontSize: 18.sp,
                    textStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Your medicine with one click',
                style: context.titleSmall.copyWith(
                  fontSize: 10.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          10.horizontalSpace,
          Container(
            margin: EdgeInsetsDirectional.only(
              end: 20.w,
              top: 8.h,
            ),
            child: SvgPicture.asset(
              AppSvg.appBarIcon,
            ),
          )
        ],
      ),
    );
  }
}
