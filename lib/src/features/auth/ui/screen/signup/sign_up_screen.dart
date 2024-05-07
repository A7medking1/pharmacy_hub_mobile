import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/login_screen.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/signup/widget/form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state.registerReqState) {
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
                    showError('Something went wrong');
                    break;
                  // TODO: Handle this case.
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Text(
                        'Sign Up',
                        style: context.titleMedium,
                      ),
                    ),
                    40.verticalSpace,
                    const SignUpFormField(),
                    50.verticalSpace,
                    state.registerReqState == ReqState.loading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            onTap: () {
                              if (context
                                  .read<AuthBloc>()
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                context
                                    .read<AuthBloc>()
                                    .add(RegisterUserEvent());
                              }
                            },
                            text: 'Sign up',
                          ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
