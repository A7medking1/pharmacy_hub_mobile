part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfoEvent extends ProfileEvent {}
class UpdateUserInfoEvent extends ProfileEvent {}
class ChangeImageEvent extends ProfileEvent {}
