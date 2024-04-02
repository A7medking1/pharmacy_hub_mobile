import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/core/widget/phone_form_field.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';

import '../../../core/widget/custom_text_formField.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final int _hotLine = 19110;
  final String _pharmacyEmail = 'Pharmacieshup@gmail.com';
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
                    Platform.isIOS ? Icons.arrow_back_ios_new_rounded : Icons.arrow_back_rounded,
                    color: AppColors.black,
                    size: 23.sp,
                  ),
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
                child: Text(
                  "Contact us",
                  style: context.titleMedium.copyWith(
                    fontSize: 20.sp,
                  ),
                ),
              ),
              10.verticalSpace,
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _hotLine.toString()));
                  Fluttertoast.showToast(msg: "Hotline copied");
                },
                splashColor: AppColors.transparent,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: AppSize.pagePadding.w),
                    margin: EdgeInsets.only(bottom: 10.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, stops: const [
                      .3,
                      1
                    ], colors: [
                      AppColors.primary.withOpacity(.9),
                      AppColors.white,
                    ])),
                    child: Text(
                      "Hot line: $_hotLine",
                      style: context.titleMedium.copyWith(color: AppColors.white, fontSize: 14.sp),
                    )),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _pharmacyEmail.toString()));
                  Fluttertoast.showToast(msg: "Email copied");
                },
                splashColor: AppColors.transparent,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: AppSize.pagePadding.w),
                    margin: EdgeInsets.only(bottom: 10.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, stops: const [
                      .3,
                      1
                    ], colors: [
                      AppColors.primary.withOpacity(.9),
                      AppColors.white,
                    ])),
                    child: Text(
                      "Email: $_pharmacyEmail",
                      style: context.titleMedium.copyWith(color: AppColors.white, fontSize: 14.sp),
                    )),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(
                      controller: context.read<ProfileBloc>().nameController,
                      title: "",
                      hintText: "Name",
                    ),
                    10.verticalSpace,
                    CustomTextFormField(
                      controller: context.read<ProfileBloc>().emailController,
                      title: "",
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    10.verticalSpace,
                    PhoneFormField(
                      controller: context.read<ProfileBloc>().phoneNumberController,
                      title: '',
                      hintText: "Mobile number",
                      onChanged: (phone) {
                        print(phone.countryCode + phone.number);
                      },
                    ),
                    10.verticalSpace,
                    CustomTextFormField(
                      controller: context.read<ProfileBloc>().noteController,
                      title: "",
                      hintText: "Your note",
                      maxLines: 5,
                    ),
                    10.verticalSpace,
                    CustomButton(
                      onTap: () => null,
                      text: "Send",
                      color: AppColors.primary,
                      textStyle: context.titleSmall.copyWith(fontSize: 14.sp, color: AppColors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
