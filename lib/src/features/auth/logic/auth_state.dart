part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String errorMessage;

  final ReqState loginReqState;

  final ReqState registerReqState;

  const AuthState({
    this.errorMessage = '',
    this.loginReqState = ReqState.empty,
    this.registerReqState = ReqState.empty,
  });

  AuthState copyWith({
    String? errorMessage,
    ReqState? loginReqState,
    ReqState? registerReqState,
  }) {
    return AuthState(
      errorMessage: errorMessage ?? this.errorMessage,
      loginReqState: loginReqState ?? this.loginReqState,
      registerReqState: registerReqState ?? this.registerReqState,
    );
  }

  @override
  List<Object> get props => [
        errorMessage,
        loginReqState,
        registerReqState,
      ];
}
