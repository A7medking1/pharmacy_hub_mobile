part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String errorMessage;

  final ReqState reqState;

  const AuthState({
    this.errorMessage = '',
    this.reqState = ReqState.empty,
  });

  AuthState copyWith({
    String? errorMessage,
    ReqState? reqState,
  }) {
    return AuthState(
      errorMessage: errorMessage ?? this.errorMessage,
      reqState: reqState ?? this.reqState,
    );
  }

  @override
  List<Object> get props => [errorMessage, reqState];
}
