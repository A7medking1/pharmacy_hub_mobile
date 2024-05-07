import 'dart:convert';

import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String token = 'token';
const String userPrefs = 'user';
const String prefsOnBoarding = 'onBoarding';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  /// user
  /*Future<void> setUserToken(String userToken) async {
    await _sharedPreferences.setString(token, userToken);
  }*/

  /*String getUserToken() {
    return _sharedPreferences.getString(token) ?? '';
  }*/

  UserModel getUser() {
    String? userPref = _sharedPreferences.getString(userPrefs);

    if (userPref == null) {
      return UserModel.fromMap(noneUser);
    }

    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    return UserModel.fromMap(userMap);
  }

  Future<void> setUser(UserModel model) async {
    await _sharedPreferences.setString(userPrefs, jsonEncode(model.toJson()));
  }

  Future<void> removeUser() async {
    await _sharedPreferences.remove(userPrefs);
  }

  Future<void> setOnBoarding() async {
    await _sharedPreferences.setBool(prefsOnBoarding, true);
  }

  bool isOnBoardingInPrefs() {
    return _sharedPreferences.getBool(prefsOnBoarding) ?? false;
  }

  Future<bool> removeOnBoarding() async {
    return await _sharedPreferences.remove(prefsOnBoarding);
  }
}

Map<String, dynamic> noneUser = {
  'id': '0',
  'name': 'None',
  'email': 'None',
  'userName': 'None',
  'phoneNumber': 'None',
  'token': 'None',
  'street': 'None',
  'city': 'None',
};
