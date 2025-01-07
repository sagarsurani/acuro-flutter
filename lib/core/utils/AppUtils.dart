
import 'dart:convert';
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/models/Auth/CountryModel.dart';
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

  static List<TextInputFormatter> onlyDigitsFormatter(List<int> phoneLengthList) {
    int maxLength = phoneLengthList.isNotEmpty ? phoneLengthList.reduce((a, b) => a > b ? a : b) : 10; // Default to 10 if list is empty

    return [
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
      LengthLimitingTextInputFormatter(maxLength),
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

  static Future<List<int>> findMaxNumberOfMobile(String countryCode) async {
    final String response =
    await rootBundle.loadString("assets/cloud/countries.json");

    Map<String, dynamic> jsonData = json.decode(response);

    List<dynamic> countriesList = jsonData['countries'];

    // Map the list of countries to a List of CountryModel objects
    List<CountryModel> countries = countriesList
        .map((data) => CountryModel.fromJson(data))
        .toList();

    // Find the country that matches the provided countryCode
    CountryModel country = countries.firstWhere(
          (c) => c.code == countryCode,
      orElse: () => CountryModel(
        code: 'IN',
        label: 'India',
        phone: '',
        phoneLength: const [10], // Default value
      ),
    );

    // If the country is found with a valid code, return the phoneLength
    if (country.phoneLength is int) {
      return [country.phoneLength as int];
    } else if (country.phoneLength is List<dynamic>) {
      return (country.phoneLength as List<dynamic>).cast<int>();
    } else {
      return [10]; // Default fallback
    }
  }

  static Future<String> generateServiceAccountToken(
      {required String cloudUrl}) async {
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
        return token;
      } else {
        throw Exception('Failed to generate ID token: ${response1.body}');
      }
    } catch (err) {
      return "";
    }
  }
}
