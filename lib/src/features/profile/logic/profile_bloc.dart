import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';

import '../../../core/app_prefs/app_prefs.dart';
import '../../../core/services/index.dart';
import '../data/repository/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<GetUserInfoEvent>(_getUserInfo);
    on<UpdateUserInfoEvent>(_updateUserInfo);
    on<ChangeImageEvent>(_changeImage);
  }

  // Of contact us page
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  // Of account page
  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPhoneNumberController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  // User information
  UserModel? _userModle;


  final formKey = GlobalKey<FormState>();

  FutureOr<void> _getUserInfo(
      GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    _userModle = sl<AppPreferences>().getUser();
    emit(UserInfoState(_userModle!.name, _userModle!.email, ""));
  }

  FutureOr<void> _updateUserInfo(
      UpdateUserInfoEvent event, Emitter<ProfileState> emit) async {
    print("start");
    bool checkInformationUpdated = false;
    _userModle = sl<AppPreferences>().getUser();
    if ((newNameController.text.trim() == '' &&
        newEmailController.text.trim() == '' &&
        newPhoneNumberController.text.trim() == '' ) &&
    oldPasswordController.text.trim() == '' && newPasswordController.text.trim() == ''
    ) {
      Fluttertoast.showToast(msg: "No Information To Update");
      return;
    }


    if(newNameController.text.trim() != '' ||
        newEmailController.text.trim() != '' ||
        newPhoneNumberController.text.trim() != '' ){
      bool response = await _profileRepository.updateProfile(
          _userModle!.email,
          newNameController.text.trim() != '' ? newNameController.text : _userModle!.name,
          newEmailController.text.trim() != '' ? newEmailController.text : _userModle!.email,
          newPhoneNumberController.text.trim() != ''
              ? newPhoneNumberController.text
              : _userModle!.phoneNumber);

      if (response){
        _userModle = UserModel(
            id: _userModle!.id,
            name: newNameController.text.trim() != '' ? newNameController.text : _userModle!.name,
            email: newEmailController.text.trim() != '' ? newEmailController.text : _userModle!.email,
            userName: newNameController.text.trim() != '' ? newNameController.text : _userModle!.userName,
            phoneNumber: newPhoneNumberController.text.trim() != '' ? newPhoneNumberController.text : _userModle!.phoneNumber,
            token: _userModle!.token);

        sl<AppPreferences>().setUser(_userModle!);
        emit(UserInfoState(_userModle!.name, _userModle!.email, ""));

        // show toast message
        Fluttertoast.showToast(msg: "Updated Successfully");
        newNameController.clear();
        newEmailController.clear();
        newPhoneNumberController.clear();
        checkInformationUpdated = true;
      }else Fluttertoast.showToast(msg: "Updated Field, Try Again or Check Your The Internet");
    }



    if(oldPasswordController.text.trim() == '') Fluttertoast.showToast(msg: "Field of old password is empty");
    if(newPasswordController.text.trim() == '') Fluttertoast.showToast(msg: "Field of new password is empty");

    if(oldPasswordController.text.trim() == '' || newPasswordController.text.trim() == '') return;
    bool response2 = await _profileRepository.changePassowrd(_userModle!.email, oldPasswordController.text, newPasswordController.text);

    if(response2)
    {
      oldPasswordController.clear();
      newPasswordController.clear();
    }
    if(!checkInformationUpdated && response2) Fluttertoast.showToast(msg: "Password Updated Successfully");
  }

  FutureOr<void> _changeImage(
      ChangeImageEvent event, Emitter<ProfileState> emit) async {}
}
