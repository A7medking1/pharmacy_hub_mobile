part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ChangeImageEvent extends ProfileEvent {}

/// Update user information
class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileParams params;

  const UpdateProfileEvent({
    required this.params,
  });
}

class GetUserInfoEvent extends ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

class ChangeUserPasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ChangeUserPasswordEvent({
    required this.oldPassword,
    required this.newPassword,
  });
}

class DeleteAccountEvent extends ProfileEvent {}

