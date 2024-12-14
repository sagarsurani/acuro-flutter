import 'dart:convert';
import 'Preferences.dart';

class PreferenceHelper {
  static const userEmail = "user_email";
  static const accessToken = "access_token";
  static const isLogin = "is_login";

  static setAccessToken(String token) async {
    await Preferences.setString(accessToken, json.encode(token));
  }

  static getAccessToken() async {
    String? data = await Preferences.getString(accessToken, null);
    return data;
  }

  static getIsLogin() async {
    return await Preferences.getBool(isLogin, false);
  }   

  static setIsLogin(bool value) async {
    await Preferences.setBool(isLogin, value);
  }

  static Future<void> setUserEmail(String email) async {
    await Preferences.setString(userEmail, email);
  }

  static Future<String?> getUserEmail() async {
    return await Preferences.getString(userEmail, null);
  }
}
