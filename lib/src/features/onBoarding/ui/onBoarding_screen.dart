import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/onBoarding/ui/widget/onBoard_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageIndex = 0;
  final CarouselController carouselController = CarouselController();
  PageController pageController = PageController();
  final String _pageTextOne = "With Pharmacy Hub, streamline your pharmacy operations and enhance your user experience.";
  final String _pageTextTwo = "Pharmacy Hub offers a range of powerful features designed to meet your pharmacy's needs.";
  final String _pageTextThree = "Ready to experience the benefits of Pharmacy Hub?";

  late List<Widget> items;

  @override
  void initState() {
    items = [
      onBoardPage(image: AppSvg.onBoardingOne, text: _pageTextOne),
      onBoardPage(image: AppSvg.onBoardingTwo, text: _pageTextTwo),
      onBoardPage(image: AppSvg.onBoardingThree, text: _pageTextThree)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CarouselSlider(
              items: items,
              carouselController: carouselController,
              options: CarouselOptions(
                  height: 1.sh,
                  aspectRatio: 1,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  autoPlay: pageIndex == items.length - 1 ? false : true,
                  onPageChanged: (index, _) {
                    setState(() {
                      pageIndex = index;
                      pageController = PageController(initialPage: index);
                    });
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  20.verticalSpace,

                  SmoothPageIndicator(
                    controller: pageController, // PageController
                    count: items.length,
                    // forcing the indicator to use a specific direction
                    textDirection: TextDirection.ltr,
                    effect: WormEffect(dotColor: AppColors.primary.withOpacity(.3), activeDotColor: AppColors.primary, dotHeight: 6.h, dotWidth: 6.w),
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      pageIndex != items.length - 1
                          ? CustomButton(
                              onTap: () {
                                GoRouter.of(context).replaceNamed(Routes.login);
                              },
                              color: AppColors.white,
                              fontColor: AppColors.primary.withOpacity(.5),
                              text: "Skip",
                              width: 90.w,
                              height: 60.h,
                            )
                          : const SizedBox.shrink(),
                      CustomButton(
                        onTap: () {
                          if (pageIndex != items.length - 1) {
                            carouselController.nextPage();
                          } else {
                            GoRouter.of(context).replaceNamed(Routes.login);
                          }
                        },
                        text: pageIndex == items.length - 1 ? "Go" : "Next",
                        width: 90.w,
                        height: 60.h,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
