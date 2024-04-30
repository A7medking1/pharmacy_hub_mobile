import 'package:dio/dio.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/core/api/status_code.dart';
import 'package:pharmacy_hub/src/core/error/exceptions.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/login_user_params.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/register_user_params.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';

class AuthRepository {
  final ApiConsumer _apiConsumer;

  const AuthRepository(this._apiConsumer);

  Future<UserModel> login({
    required LoginUserParams params,
  }) async {
    final Response response = await _apiConsumer.post(
      ApiConstant.login,
      body: params.toMap(),
    );

    if(response.statusCode != StatusCode.ok) {
      throw const ServerException();
    }
    return UserModel.fromMap(response.data);
  }

  Future<UserModel> register({
    required RegisterUserParams params,
  }) async {
    final Response response = await _apiConsumer.post(
      ApiConstant.register,
      body: params.toMap(),
    );
    return UserModel.fromMap(response.data);
  }
}
