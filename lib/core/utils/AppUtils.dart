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

  static closeTheKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static List<TextInputFormatter> onlyDigitsFormatter() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
    ];
  }
}
