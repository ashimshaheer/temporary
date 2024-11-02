import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const _userToken = "accessToken";
  static const _isSignedIn = 'isSignedIn';

  static const String _fcmToken = 'fcmToken';

  static late SharedPreferences _preference;

  //FCM Token
  static String get fcmToken => _preference.getString(_fcmToken) ?? "";

  static set fcmToken(String value) => _preference.setString(_fcmToken, value);
  // Flicks Downloadable

  //User Is SignedIn or not
  static bool get isSignedIn => _preference.getBool(_isSignedIn) ?? false;

  static set isSignedIn(bool value) => _preference.setBool(_isSignedIn, value);
  //User Token _userProfileId
  static String get userToken => _preference.getString(_userToken) ?? "";
  static set userToken(String value) => _preference.setString(_userToken, value);
  Future<void> clear() async {
    await _preference.clear();
  }

  void reloadPreference() async {
    await _preference.reload();
  }

  static Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }
}
