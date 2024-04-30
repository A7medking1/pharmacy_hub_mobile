import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/widget/login_form_field.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/widget/text_logo.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: 40.h,
              bottom: 20.h,
              start: 20.w,
              end: 20.w,
            ),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state.loginReqState) {
                  case ReqState.loading:
                    log('loading');
                    break;
                  case ReqState.empty:
                    log('empty');
                    break;
                  case ReqState.success:
                    context.goNamed(Routes.appLayOut);
                    break;
                  case ReqState.error:
                    showError('please check your email and password');
                    break;
                  // TODO: Handle this case.
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: FadeAnimation(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TextAndLogo(
                          text: 'Welcome back!',
                        ),
                        40.verticalSpace,
                        const LoginFormField(),
                        40.verticalSpace,
                        state.loginReqState == ReqState.loading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                onTap: () {
                                  if (context
                                      .read<AuthBloc>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
/*
                                    print(context.read<AuthBloc>().email.text);
                                    print(
                                        context.read<AuthBloc>().password.text);

*/
                                    context.read<AuthBloc>().add(LogInEvent());

                                    // context.goNamed(Routes.appLayOut);
                                  }
                                },
                                text: 'Log In',
                              ),
                        25.verticalSpace,
                        Hero(
                          tag: 'logo',
                          child: CustomButton(
                            color: Colors.white,
                            textStyle: context.titleSmall.copyWith(),
                            onTap: () {
                              context.pushNamed(Routes.signUp);
                            },
                            text: 'Sign up',
                            isBorderButton: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }


}
void showError(String s) {
  Fluttertoast.showToast(
    msg: s,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.sp,
  );
}