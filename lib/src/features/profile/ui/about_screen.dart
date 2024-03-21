import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late List<String> statementsGroup = [
    "We are the first online platform for a group of pharmacies.",
    "As a customer, you can research for your requirements (medication, skin & hair care, medical equipments, mon & baby products and vitamins).",
    "So you can find your medications by one click.",
    "If it not found, ask for alternative or similar.",
    "You can order it and we deliver it to you.",
    "You can upload your prescription or your product picture."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: AppSize.pagePadding.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
                child: CustomButton(
                  onTap: () => context.pop(),
                  width: 60.w,
                  height: 60.h,
                  borderRadius: 999,
                  color: AppColors.transparent,
                  icon: Icon(
                    Platform.isIOS
                        ? Icons.arrow_back_ios_new_rounded
                        : Icons.arrow_back_rounded,
                    color: AppColors.primary,
                    size: 23.sp,
                  ),
                ),
              ),
              20.verticalSpace,
              Container(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.pagePadding.h,
                      horizontal: AppSize.pagePadding.w),
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: const [0, .5],
                          colors: [
                        AppColors.primary.withOpacity(.9),
                        AppColors.white,
                      ])),
                  child: Text(
                    "About us",
                    style: context.titleMedium
                        .copyWith(color: AppColors.white, fontSize: 20.sp),
                  )),
              // 20.verticalSpace,
              ...statementsGroup.map((statement) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.pagePadding.h,
                      horizontal: AppSize.pagePadding.w),
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:  AppColors.primary.withOpacity(.1),
                      // gradient: LinearGradient(
                      //     begin: Alignment.centerLeft,
                      //     end: Alignment.centerRight,
                      //     stops: const [0, .8],
                      //     colors: [
                      //   AppColors.primary.withOpacity(.1),
                      //   AppColors.white
                      // ])
                  ),
                  child: Text(
                    statement,
                    textAlign: TextAlign.justify,
                    style: context.titleMedium
                        .copyWith(color: AppColors.black.withOpacity(.7), fontSize: 15.sp),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
