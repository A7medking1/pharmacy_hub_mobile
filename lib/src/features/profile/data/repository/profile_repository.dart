import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';

import '../../../../core/api/api_consumer.dart';

class ProfileRepository {
  final ApiConsumer _apiConsumer;

  ProfileRepository(this._apiConsumer);

  Future<bool> updateProfile(
    String oldEmail,
    String newUserName,
    String newEmail,
    String newPhoneNumber,
  ) async {
    Response response = await _apiConsumer.put(ApiConstant.editAccount,
        body: {
      "name": newUserName,
      "email": newEmail,
      "phoneNumber": newPhoneNumber
    }, queryParameters: {
      "email": oldEmail
    });
    if((response != null || response.statusCode == 200)) return true;
    else {
      Fluttertoast.showToast(msg: response.statusMessage ?? "There is a problem, try again");
      return false;
    }
  }

  Future<bool> changePassowrd(
      String email,
      String oldPassword,
      String newPassword,
      ) async {
    Response response = await _apiConsumer.put(ApiConstant.changePassword,
        body: {
          "newPassword": newPassword,
          "currentPassword": oldPassword
        }, queryParameters: {
          "email": email
        });

    if((response != null || response.statusCode == 200)) return true;
    else {
      Fluttertoast.showToast(msg: response.statusMessage ?? "There is a problem, try again");
     return false;
    }
  }


}
