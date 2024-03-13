import 'package:shared_preferences/shared_preferences.dart';

const String token = 'token';
const String prefsOnBoarding = 'onBoarding';


class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  /// user
  Future<void> setUserToken(String userToken) async {
    await _sharedPreferences.setString(token, userToken);
  }

  String getUserToken() {
    return _sharedPreferences.getString(token) ?? '';
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
