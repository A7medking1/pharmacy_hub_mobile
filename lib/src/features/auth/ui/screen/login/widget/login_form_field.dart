import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/widget/custom_text_formField.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return Form(
      key: bloc.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: bloc.email,
            title: 'email',
            hintText: 'enter your email',
            textInputType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) {
              if (!isEmailValid(value!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          20.verticalSpace,
          CustomTextFormField(
            controller: bloc.password,
            title: 'password',
            hintText: 'enter your password',
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            prefixIcon: const Icon(Icons.visibility),
            validator: (value) {
              if (value!.isEmpty || value.length < 8) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

