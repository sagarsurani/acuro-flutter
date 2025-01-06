import 'dart:convert';
import 'dart:developer';

import 'package:acuro/core/constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

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

  static void pageScrollUp(
      {required double height, required ScrollController controller}) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (controller.hasClients) {
        controller.animateTo(height,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    });
  }

  static Future<String> generateServiceAccountToken({required String cloudUrl}) async {
    try {
      final String response =
          await rootBundle.loadString("assets/cloud/acuro_service.json");
      Map<String, dynamic> serviceAccount = await json.decode(response);

      List<String> scopes = [
        'https://www.googleapis.com/auth/iam',
        'https://www.googleapis.com/auth/cloud-platform',
        'https://www.googleapis.com/auth/firebase.database',
        'https://www.googleapis.com/auth/userinfo.email',
      ];

      final accountCredentials =
          ServiceAccountCredentials.fromJson(serviceAccount);
      AuthClient client =
          await clientViaServiceAccount(accountCredentials, scopes);
      String accessToken = client.credentials.accessToken.data;
      final body = jsonEncode({
        'audience': cloudUrl,
        'includeEmail': true,
      });

      final response1 = await client.post(
        Uri.parse(generateServiceTokenUrl),
        headers: {
          AUTHORIZATION: '$BEARER $accessToken',
          CONTENT_TYPE: APPLICATION_JSON,
        },
        body: body,
      );

      if (response1.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response1.body);
        String token = responseData['token'] ?? '';
        log(token);
        return token;
      } else {
        throw Exception('Failed to generate ID token: ${response1.body}');
      }
    } catch (err) {
      return "";
    }
  }
}
