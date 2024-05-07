import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/core/widget/custom_text_formField.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    rePasswordController.dispose();
    currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: currentPasswordController,
                    title: 'current password',
                    hintText: 'Enter current password',
                    prefixIcon: const Icon(Icons.remove_red_eye_outlined),
                  ),
                  20.verticalSpace,
                  CustomTextFormField(
                    controller: passwordController,
                    title: 'new password',
                    hintText: 'Enter new password',
                    prefixIcon: const Icon(Icons.remove_red_eye_outlined),
                    validator: (value) {
                      if (!isPasswordValid(value!)) {
                        return 'Password too weak';
                      }
                      return null;
                    },
                  ),
                  20.verticalSpace,
                  CustomTextFormField(
                    controller: rePasswordController,
                    title: 'new repeat password',
                    hintText: 'Enter new repeat password',
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'passwords do not match';
                      }
                      return null;
                    },
                    prefixIcon: const Icon(Icons.remove_red_eye_outlined),
                  ),
                  50.verticalSpace,
                  state.changePasswordReqState == ReqState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          onTap: () {
                            context
                                .read<ProfileBloc>()
                                .add(ChangeUserPasswordEvent(
                                  oldPassword: currentPasswordController.text,
                                  newPassword: passwordController.text,
                                ));
                          },
                          text: 'change password',
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
