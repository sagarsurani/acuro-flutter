import 'package:acuro/core/constants/GlobalConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToastUtils {
  static void showToaster(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void showAuthToaster(String message) {
    String messageText = "";
    AppLocalizations appText =
        AppLocalizations.of(GlobalConstant.currentPageContext)!;
    if (message.contains("Exception:")) {
      message = message.replaceAll("Exception:", "");
    }
    if (message == "invalid-email") {
      messageText = appText.invalid_email;
    } else if (message == "invalid-credential") {
      messageText = appText.please_enter_valid_email_address_password;
    } else if (message == "too-many-requests") {
      messageText = appText.too_many_requests;
    } else if (message == "account-exists-with-different-credential") {
      messageText = appText.there_already_account_same_email;
    } else if (message ==
        "The supplied auth credential is incorrect, malformed or has expired.") {
      messageText = appText.please_enter_valid_email_address_password;
    } else if (message.contains("[firebase_auth/invalid-email]")) {
      messageText = appText.invalid_email_address;
    } else if (message == "invalid_login_credentials" ||
        message == "INVALID_LOGIN_CREDENTIALS") {
      messageText = appText.please_enter_valid_email_address_password;
    } else {
      messageText = appText.somethings_went_wrong;
    }
    Fluttertoast.showToast(msg: message);
  }

  static String getAuthMessage(String message) {
    AppLocalizations appText =
    AppLocalizations.of(GlobalConstant.currentPageContext)!;

    if (message.contains("Exception:")) {
      message = message.replaceAll("Exception:", "").trim();
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
      default:
        if (message.contains("[firebase_auth/invalid-email]")) {
          return appText.invalid_email_address;
        }
        return appText.somethings_went_wrong;
    }
  }
}


