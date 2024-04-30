import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/login_user_params.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/register_user_params.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';
import 'package:pharmacy_hub/src/features/auth/data/repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<LogInEvent>(_logIn);
    on<RegisterUserEvent>(_registerUser);
  }

  final AuthRepository _authRepository;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String phoneNumber = '';

  final formKey = GlobalKey<FormState>();

  FutureOr<void> _logIn(LogInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginReqState: ReqState.loading));

    try {
      final UserModel user = await _authRepository.login(
        params: LoginUserParams(
          email: email.text,
          password: password.text,
        ),
      );

      await sl<AppPreferences>().setUser(user);

      emit(state.copyWith(
        loginReqState: ReqState.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        loginReqState: ReqState.error,
      ));
    }
  }

  FutureOr<void> _registerUser(
      RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(registerReqState: ReqState.loading));

    try {
      final UserModel user = await _authRepository.register(
        params: RegisterUserParams(
          name: name.text,
          email: email.text,
          phoneNumber: phoneNumber,
          password: password.text,
          repeatPassword: password.text,
        ),
      );

      await sl<AppPreferences>().setUser(user);

      emit(state.copyWith(
        registerReqState: ReqState.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        registerReqState: ReqState.error,
      ));
    }
  }
}

bool isEmailValid(String password) {
  String emailValid =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  return RegExp(emailValid).hasMatch(password);
}

bool isPasswordValid(String password) {
  String passwordPattern =
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{9,}$';
  return RegExp(passwordPattern).hasMatch(password);
}
