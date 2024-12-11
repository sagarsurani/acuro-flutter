// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acuro/models/Model.dart' as _i16;
import 'package:acuro/pages/Commodity/CommodityConfirmationPage.dart' as _i1;
import 'package:acuro/pages/Commodity/SelectCommodityPage.dart' as _i10;
import 'package:acuro/pages/Login/EmailVerificationPage.dart' as _i2;
import 'package:acuro/pages/Login/ForgotOtpPage.dart' as _i3;
import 'package:acuro/pages/Login/ForgotPasswordPage.dart' as _i4;
import 'package:acuro/pages/Login/LoginPage.dart' as _i6;
import 'package:acuro/pages/Login/OtpVerifyPage.dart' as _i7;
import 'package:acuro/pages/Login/PhoneRegistrationPage.dart' as _i8;
import 'package:acuro/pages/Login/ResetPasswordPage.dart' as _i9;
import 'package:acuro/pages/Login/SelectRolePage.dart' as _i11;
import 'package:acuro/pages/Login/TakeUserDetailsPage.dart' as _i13;
import 'package:acuro/pages/Splash/GetStartedPage.dart' as _i5;
import 'package:acuro/pages/Splash/SplashPage.dart' as _i12;
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

/// generated route for
/// [_i1.CommodityConfirmationPage]
class CommodityConfirmationRoute
    extends _i14.PageRouteInfo<CommodityConfirmationRouteArgs> {
  CommodityConfirmationRoute({
    _i15.Key? key,
    required List<_i16.CommodityModel> selectedCommodityList,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          CommodityConfirmationRoute.name,
          args: CommodityConfirmationRouteArgs(
            key: key,
            selectedCommodityList: selectedCommodityList,
          ),
          initialChildren: children,
        );

  static const String name = 'CommodityConfirmationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommodityConfirmationRouteArgs>();
      return _i1.CommodityConfirmationPage(
        key: args.key,
        selectedCommodityList: args.selectedCommodityList,
      );
    },
  );
}

class CommodityConfirmationRouteArgs {
  const CommodityConfirmationRouteArgs({
    this.key,
    required this.selectedCommodityList,
  });

  final _i15.Key? key;

  final List<_i16.CommodityModel> selectedCommodityList;

  @override
  String toString() {
    return 'CommodityConfirmationRouteArgs{key: $key, selectedCommodityList: $selectedCommodityList}';
  }
}

/// generated route for
/// [_i2.EmailVerificationPage]
class EmailVerificationRoute extends _i14.PageRouteInfo<void> {
  const EmailVerificationRoute({List<_i14.PageRouteInfo>? children})
      : super(
          EmailVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmailVerificationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i2.EmailVerificationPage();
    },
  );
}

/// generated route for
/// [_i3.ForgotOtpPage]
class ForgotOtpRoute extends _i14.PageRouteInfo<ForgotOtpRouteArgs> {
  ForgotOtpRoute({
    _i15.Key? key,
    required bool isEmail,
    required String detailsValue,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ForgotOtpRoute.name,
          args: ForgotOtpRouteArgs(
            key: key,
            isEmail: isEmail,
            detailsValue: detailsValue,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgotOtpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotOtpRouteArgs>();
      return _i3.ForgotOtpPage(
        key: args.key,
        isEmail: args.isEmail,
        detailsValue: args.detailsValue,
      );
    },
  );
}

class ForgotOtpRouteArgs {
  const ForgotOtpRouteArgs({
    this.key,
    required this.isEmail,
    required this.detailsValue,
  });

  final _i15.Key? key;

  final bool isEmail;

  final String detailsValue;

  @override
  String toString() {
    return 'ForgotOtpRouteArgs{key: $key, isEmail: $isEmail, detailsValue: $detailsValue}';
  }
}

/// generated route for
/// [_i4.ForgotPasswordPage]
class ForgotPasswordRoute extends _i14.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i14.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i5.GetStartedPage]
class GetStartedRoute extends _i14.PageRouteInfo<void> {
  const GetStartedRoute({List<_i14.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.GetStartedPage();
    },
  );
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginPage();
    },
  );
}

/// generated route for
/// [_i7.OtpVerifyPage]
class OtpVerifyRoute extends _i14.PageRouteInfo<OtpVerifyRouteArgs> {
  OtpVerifyRoute({
    _i15.Key? key,
    required String phoneNumber,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          OtpVerifyRoute.name,
          args: OtpVerifyRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpVerifyRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpVerifyRouteArgs>();
      return _i7.OtpVerifyPage(
        key: args.key,
        phoneNumber: args.phoneNumber,
      );
    },
  );
}

class OtpVerifyRouteArgs {
  const OtpVerifyRouteArgs({
    this.key,
    required this.phoneNumber,
  });

  final _i15.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'OtpVerifyRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i8.PhoneRegistrationPage]
class PhoneRegistrationRoute extends _i14.PageRouteInfo<void> {
  const PhoneRegistrationRoute({List<_i14.PageRouteInfo>? children})
      : super(
          PhoneRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRegistrationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.PhoneRegistrationPage();
    },
  );
}

/// generated route for
/// [_i9.ResetPasswordPage]
class ResetPasswordRoute extends _i14.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i14.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.ResetPasswordPage();
    },
  );
}

/// generated route for
/// [_i10.SelectCommodityPage]
class SelectCommodityRoute extends _i14.PageRouteInfo<void> {
  const SelectCommodityRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SelectCommodityRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectCommodityRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.SelectCommodityPage();
    },
  );
}

/// generated route for
/// [_i11.SelectRolePage]
class SelectRoleRoute extends _i14.PageRouteInfo<void> {
  const SelectRoleRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SelectRoleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectRoleRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.SelectRolePage();
    },
  );
}

/// generated route for
/// [_i12.SplashPage]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.SplashPage();
    },
  );
}

/// generated route for
/// [_i13.TakeUserDetailsPage]
class TakeUserDetailsRoute extends _i14.PageRouteInfo<void> {
  const TakeUserDetailsRoute({List<_i14.PageRouteInfo>? children})
      : super(
          TakeUserDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TakeUserDetailsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.TakeUserDetailsPage();
    },
  );
}
