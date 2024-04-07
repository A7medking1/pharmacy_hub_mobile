import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/size_manager.dart';
import '../../../core/widget/custom_button.dart';
import '../../../core/widget/custom_text_formField.dart';
import '../../../core/widget/phone_form_field.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSize.pagePadding.h, horizontal: AppSize.pagePadding.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomButton(
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
              20.verticalSpace,
              CustomButton(
                color: AppColors.primary.withOpacity(.8),
                padding: EdgeInsets.zero,
                width: 170.w,
                height: 40.h,
                borderRadius: 7,
                splashColor: AppColors.white.withOpacity(.4),
                text: "Change image",
                textStyle: context.titleSmall.copyWith(fontWeight: FontWeight.normal, color: AppColors.white, fontSize: 14.sp),
                onTap: ()=> context.read<ProfileBloc>().add(ChangeImage()),
              ),
              20.verticalSpace,
              CustomTextFormField(
                controller: context.read<ProfileBloc>().newNameController,
                title: "",
                hintText: "Name",
                textInputType: TextInputType.emailAddress,
              ),
              10.verticalSpace,
              CustomTextFormField(
                controller: context.read<ProfileBloc>().newEmailController,
                title: "",
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
              ),
              10.verticalSpace,
              PhoneFormField(
                controller: context.read<ProfileBloc>().newPhoneNumberController,
                title: '',
                hintText: "Mobile number",
              ),
              10.verticalSpace,
              CustomTextFormField(
                controller: context.read<ProfileBloc>().newPasswordController,
                title: "",
                hintText: "Passowrd",
                textInputType: TextInputType.emailAddress,
              ),
              const Spacer(),
              CustomButton(
                color: AppColors.primary,
                padding: EdgeInsets.zero,
                height: 50.h,
                borderRadius: 7,
                splashColor: AppColors.white.withOpacity(.4),
                text: "Save changes",
                textStyle: context.titleSmall.copyWith(fontWeight: FontWeight.normal, color: AppColors.white, fontSize: 14.sp),
                onTap: () => null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
