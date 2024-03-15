part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class UserInfoState extends ProfileState{
  String? name;
  String? email;
  String? imageUrl;
  UserInfoState(this.name, this.email, this.imageUrl);
}
