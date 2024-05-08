import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/core/widget/custom_text_formField.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';

import '../data/models/update_profile_params.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final UserModel user = sl<AppPreferences>().getUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumberController = TextEditingController(text: user.phoneNumber);
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    streetController = TextEditingController(text: user.street);
    cityController = TextEditingController(text: user.city);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    streetController.dispose();
    cityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.pagePadding.h,
              horizontal: AppSize.pagePadding.w,
            ),
            child: SafeArea(
              child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
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
                        color: AppColors.black,
                        size: 23.sp,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  CustomTextFormField(
                    controller: nameController,
                    title: 'Name',
                    prefixIcon: const Icon(Icons.person),
                    hintText: state.user?.name ?? "",
                    textInputType: TextInputType.emailAddress,
                  ),
                  20.verticalSpace,
                  CustomTextFormField(
                    controller: emailController,
                    title: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    hintText: state.user?.email ?? "",
                    textInputType: TextInputType.emailAddress,
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: cityController,
                          title: 'city',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: state.user?.city ?? "",
                        ),
                      ),
                      15.horizontalSpace,
                      Expanded(
                        child: CustomTextFormField(
                          controller: streetController,
                          title: 'street',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: state.user?.street ?? "",
                        ),
                      ),
                    ],
                  ),
                  50.verticalSpace,
                  state.updateProfileReqState == ReqState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          color: AppColors.primary,
                          padding: EdgeInsets.zero,
                          height: 50.h,
                          borderRadius: 7,
                          splashColor: AppColors.white.withOpacity(.4),
                          text: "Save changes",
                          textStyle: context.titleSmall.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                          onTap: () {
                            context.read<ProfileBloc>().add(
                                  UpdateProfileEvent(
                                    params: UpdateProfileParams(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      phoneNumber:
                                          phoneNumberController.text.trim(),
                                      street: streetController.text.trim(),
                                      city: cityController.text.trim(),
                                    ),
                                  ),
                                );
                          },
                        ),
                  50.verticalSpace,
                  CustomButton(
                    onTap: () {
                      context.pushNamed(Routes.changePassword);
                    },
                    color: AppColors.white,
                    isBorderButton: true,
                    textStyle: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.black,
                      fontSize: 14.sp,
                    ),
                    text: 'change password',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
