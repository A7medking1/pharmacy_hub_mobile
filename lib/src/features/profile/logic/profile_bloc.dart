import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/error/exceptions.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';
import 'package:pharmacy_hub/src/features/profile/data/models/update_profile_params.dart';

import '../../../core/app_prefs/app_prefs.dart';
import '../../../core/services/index.dart';
import '../data/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(const ProfileState()) {
    on<GetUserInfoEvent>(_getUserInfo);
    on<UpdateProfileEvent>(_updateUserInfo);
    // on<ChangeImageEvent>(_changeImage);
    //  on<LogoutEvent>(_logout);
    on<ChangeUserPasswordEvent>(_changeUserPassword);
    on<DeleteAccountEvent>(_deleteAccount);
  }


  FutureOr<void> _getUserInfo(
      GetUserInfoEvent event, Emitter<ProfileState> emit) async {
    UserModel userModel = sl<AppPreferences>().getUser();
    emit(
      state.copyWith(
        user: userModel,
      ),
    );
  }

  FutureOr<void> _updateUserInfo(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(updateProfileReqState: ReqState.loading));

    try {
      final UserModel response = await _profileRepository.updateProfile(
        params: event.params,
      );

      await sl<AppPreferences>().setUser(response);
      showToastProfile('Profile updated successfully');

      emit(
        state.copyWith(
          user: response,
          updateProfileReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      showToastProfile('There is a problem, try again');
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          updateProfileReqState: ReqState.error,
        ),
      );
    }
  }

  FutureOr<void> _changeUserPassword(
      ChangeUserPasswordEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(changePasswordReqState: ReqState.loading));
    try {
      await _profileRepository.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );
      showToastProfile('Password changed successfully');
      emit(
        state.copyWith(
          changePasswordReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      showToastProfile('There is a problem, try again');
      emit(
        state.copyWith(
          errorMessage: e.errorMessageModel!.statusMessage,
          changePasswordReqState: ReqState.error,
        ),
      );
    }
  }

  FutureOr<void> _deleteAccount(
      DeleteAccountEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(deleteAccountReqState: ReqState.loading));
    try {
      await _profileRepository.deleteAccount();
      emit(
        state.copyWith(
          deleteAccountReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      showToastProfile('There is a problem, try again');
      state.copyWith(
        deleteAccountReqState: ReqState.error,
      );
    }
  }
}

void showToastProfile(String s) {
  Fluttertoast.showToast(
    msg: s,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.primary,
    textColor: Colors.white,
  );
}
