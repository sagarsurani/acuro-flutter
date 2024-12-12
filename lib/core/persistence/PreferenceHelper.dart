import 'dart:convert';
import 'package:acuro/models/Auth/OtpLimitationModel.dart';
import 'Preferences.dart';

class PreferenceHelper {
  static const otpValidation = "otp_validation";

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
