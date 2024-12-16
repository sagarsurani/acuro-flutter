import 'package:acuro/core/constants/GlobalConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToastUtils {
  static void showToaster(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static String getAuthMessage(String message) {
    AppLocalizations appText =
    AppLocalizations.of(GlobalConstant.currentPageContext)!;

    if (message.contains("firebase_auth")) {
      message = message.replaceAll("[firebase_auth/invalid-credential]", "").trim();
      message = message.replaceAll("[firebase_auth/provider-already-linked]", "").trim();
      message = message.replaceAll("[firebase_auth/network-request-failed]", "").trim();
    }
    switch (message) {
      case "invalid-email":
        return appText.invalid_email;
      case "invalid-credential":
      case "The supplied auth credential is incorrect, malformed or has expired.":
      case "invalid_login_credentials":
      case "INVALID_LOGIN_CREDENTIALS":
        return appText.please_enter_valid_email_address_password;
      case "too-many-requests":
        return appText.too_many_requests;
      case "account-exists-with-different-credential":
        return appText.there_already_account_same_email;
      case "User has already been linked to the given provider.":
        return appText.user_already_linked_with_another_account;
      case "A network error (such as timeout, interrupted connection or unreachable host) has occurred.":
        return appText.network_not_available;
      default:
        if (message.contains("[firebase_auth/invalid-email]")) {
          return appText.invalid_email_address;
        }
        return message;
    }
  }
}


