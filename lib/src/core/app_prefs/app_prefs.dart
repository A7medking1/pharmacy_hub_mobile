import 'package:shared_preferences/shared_preferences.dart';

const String token = 'token';

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
}
