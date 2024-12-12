
import 'package:flutter/material.dart';
import 'AppColors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      primaryColor: ColorConstants.white1,
      focusColor: ColorConstants.black1,
      shadowColor: ColorConstants.splashGradient1,
      splashColor: ColorConstants.splashGradient1,
      highlightColor: ColorConstants.splashGradient2,
      cardColor: ColorConstants.blueDark,
      canvasColor: ColorConstants.grey1,
      hintColor: ColorConstants.grey2,
      secondaryHeaderColor: ColorConstants.countryBackground,
      dividerColor: ColorConstants.border,
      tabBarTheme: const TabBarTheme(
          indicatorColor: ColorConstants.white1,
          unselectedLabelColor: ColorConstants.lightBlue)
      );

  static final darkTheme = ThemeData(
      primaryColor: ColorConstants.black1,
      focusColor: ColorConstants.white1,
      shadowColor: ColorConstants.black1,
      splashColor: ColorConstants.splashDarkGradient1,
      highlightColor: ColorConstants.splashDarkGradient2,
      cardColor: ColorConstants.white1,
      canvasColor: ColorConstants.greyLight,
      hintColor: ColorConstants.grey1Light,
      secondaryHeaderColor: ColorConstants.blackLight,
      dividerColor: ColorConstants.borderDark,
      tabBarTheme: const TabBarTheme(
          indicatorColor: ColorConstants.tabBarLightDark,
          unselectedLabelColor: ColorConstants.tabBarDark)
      );
}
