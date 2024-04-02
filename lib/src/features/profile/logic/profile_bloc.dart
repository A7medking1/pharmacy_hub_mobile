import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUserInfoEvent>(_getUserInfo);
    on<UpdateUserInfo>(_updateUserInfo);
    on<ChangeImage>(_changeImage);
  }

  // Of contact us page
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  // Of account page
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPhoneNumberController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  // User information
  String? name;
  String? email;
  String? imageUrl;
  String? mobileNumber;
  String? password;

  FutureOr<void> _getUserInfo(GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    // Get User Information
    name = "Ahmed Jihad Attia";
    email = "ahmedjihad@gmail.com";
    imageUrl = "https:\\www.image.com";
    emit(UserInfoState(
      name,
      email,
      imageUrl
    ));
    // emit(UserInfoState(null, null, null));
  }

    FutureOr<void> _updateUserInfo(UpdateUserInfo event, Emitter<ProfileState> emit) async {}
    FutureOr<void> _changeImage(ChangeImage event, Emitter<ProfileState> emit) async {}

}
