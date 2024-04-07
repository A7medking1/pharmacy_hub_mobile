import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/signup/widget/form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
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
                CustomButton(
                  onTap: () {
                    if (context
                        .read<AuthBloc>()
                        .formKey
                        .currentState!
                        .validate()) {
                      print('object');
                      print(context.read<AuthBloc>().phone.text);
                      context.goNamed(Routes.appLayOut);
                    }
                  },
                  text: 'Sign up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
