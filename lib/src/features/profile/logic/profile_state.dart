part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final UserModel? user;
  final String errorMessage;

  final ReqState updateProfileReqState;

  final ReqState changePasswordReqState;
  final ReqState deleteAccountReqState;

  const ProfileState({
    this.user,
    this.errorMessage = '',
    this.updateProfileReqState = ReqState.empty,
    this.changePasswordReqState = ReqState.empty,
    this.deleteAccountReqState = ReqState.empty,
  });

  ProfileState copyWith({
    UserModel? user,
    String? errorMessage,
    ReqState? updateProfileReqState,
    ReqState? changePasswordReqState,
    ReqState? deleteAccountReqState,
  }) {
    return ProfileState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      updateProfileReqState:
          updateProfileReqState ?? this.updateProfileReqState,
      changePasswordReqState:
          changePasswordReqState ?? this.changePasswordReqState,
      deleteAccountReqState:
          deleteAccountReqState ?? this.deleteAccountReqState,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        user,
        errorMessage,
        updateProfileReqState,
        changePasswordReqState,
        deleteAccountReqState,
      ];
}
