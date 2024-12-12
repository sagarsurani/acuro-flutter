import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppUtils {
  static bool isEmailValid(String value) {
    if (value.isNotEmpty) {
      return value.contains(
          RegExp(r"^[a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9-]+\.[a-z]+$"));
    } else {
      return false;
    }
  }

  static bool isDarkTheme(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  static bool isPasswordValid(String value) {
    if (value.isNotEmpty) {
      return value.contains(RegExp(
          r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|:"<>?~-]).{8,}$'));
    } else {
      return false;
    }
  }

  static closeTheKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static List<TextInputFormatter> onlyDigitsFormatter(int? maxDigits) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
      if (maxDigits != 0) ...[
        LengthLimitingTextInputFormatter(maxDigits),
      ]
    ];
  }

  static List<TextInputFormatter> onlyTextFormatter() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]*$')),
    ];
  }
}
