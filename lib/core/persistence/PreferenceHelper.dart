import 'dart:convert';
import 'package:acuro/models/Auth/OtpLimitationModel.dart';
import 'Preferences.dart';

class PreferenceHelper {
  static const otpValidation = "otp_validation";
  static const userEmail = "user_email";
  static const accessToken = "access_token";

  static setAccessToken(String token) async {
    await Preferences.setString(accessToken, json.encode(token));
  }

  static getAccessToken() async {
    String? data = await Preferences.getString(accessToken, null);
    return data;
  }

  static Future<void> setUserEmail(String email) async {
    await Preferences.setString(userEmail, email);
  }

  static Future<String?> getUserEmail() async {
    return await Preferences.getString(userEmail, null);
  }

  static setOtpLimitation(
      {required List<OTPLimitationModel> otpUserList}) async {
    await Preferences.setString(otpValidation, json.encode(otpUserList));
  }

  static getOtpLimitation() async {
    List<OTPLimitationModel> userList = [];
    String? data = await Preferences.getString(otpValidation, null);
    if (data != null && data.isNotEmpty) {
      var test = jsonDecode(data) as List<dynamic>;
      for (var v in test) {
        userList.add(OTPLimitationModel.fromJson(v));
      }
    }
    return userList;
  }

  static clearOtpLimitation() async {
    await Preferences.remove(otpValidation);
  }
}
