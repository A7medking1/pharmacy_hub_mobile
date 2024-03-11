import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/widget/custom_text_formField.dart';
import 'package:pharmacy_hub/src/core/widget/phone_form_field.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/widget/login_form_field.dart';

class SignUpFormField extends StatelessWidget {
  const SignUpFormField({
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
            controller: context.read<AuthBloc>().name,
            title: 'name',
            hintText: 'enter your name',
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) {
              if (value!.isEmpty || value.length < 8) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
          20.verticalSpace,
          PhoneFormField(
            controller: context.read<AuthBloc>().phone,
            onChanged: (phone) {
              print(phone.countryCode + phone.number);
            },
          ),
          5.verticalSpace,
          CustomTextFormField(
            controller: context.read<AuthBloc>().email,
            title: 'email',
            hintText: 'enter your email',
            prefixIcon: const Icon(Icons.email_outlined),
            validator: (value) {
              if (!emailValid(value!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          20.verticalSpace,
          CustomTextFormField(
            controller: context.read<AuthBloc>().password,
            title: 'password',
            hintText: 'enter your password',
            prefixIcon: const Icon(Icons.visibility),
            validator: (value) {
              if (value!.isEmpty || value.length < 9) {
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
