import 'package:dio/dio.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';
import 'package:pharmacy_hub/src/features/profile/data/models/update_profile_params.dart';

class ProfileRepository {
  final ApiConsumer _apiConsumer;

  ProfileRepository(this._apiConsumer);

  Future<UserModel> updateProfile({required UpdateProfileParams params}) async {
    Response response =
        await _apiConsumer.put(ApiConstant.account, body: params.toMap());

    return UserModel.fromMap(response.data);
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await _apiConsumer.post(ApiConstant.changePassword, body: {
      "newPassword": newPassword,
      "currentPassword": oldPassword,
    });
  }

  Future<void> deleteAccount() async {
    await _apiConsumer.delete(ApiConstant.account);
  }
}
