import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_hub/src/core/enums.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LogInEvent>(_logIn);
  }

  FutureOr<void> _logIn(LogInEvent event, Emitter<AuthState> emit) {}
}
