import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/widget/login_form_field.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/widget/text_logo.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: 40.h,
              bottom: 20.h,
              start: 20.w,
              end: 20.w,
            ),
            child: SizedBox(
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
                    CustomButton(
                      onTap: () {
                        if (context
                            .read<AuthBloc>()
                            .formKey
                            .currentState!
                            .validate()) {

                          print(context.read<AuthBloc>().email.text);
                          print(context.read<AuthBloc>().password.text);

                          context.goNamed(Routes.home);
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
            ),
          ),
        ),
      ),
    );
  }
}
