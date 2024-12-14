// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acuro/models/Model.dart' as _i18;
import 'package:acuro/pages/Commodity/CommodityConfirmationPage.dart' as _i1;
import 'package:acuro/pages/Commodity/SelectCommodityPage.dart' as _i12;
import 'package:acuro/pages/Login/CreatePasswordPage.dart' as _i2;
import 'package:acuro/pages/Login/EmailVerificationPage.dart' as _i3;
import 'package:acuro/pages/Login/ForgotOtpPage.dart' as _i4;
import 'package:acuro/pages/Login/ForgotPasswordPage.dart' as _i5;
import 'package:acuro/pages/Login/LoginPage.dart' as _i7;
import 'package:acuro/pages/Login/OtpVerifyPage.dart' as _i9;
import 'package:acuro/pages/Login/PhoneRegistrationPage.dart' as _i10;
import 'package:acuro/pages/Login/ResetPasswordPage.dart' as _i11;
import 'package:acuro/pages/Login/SelectRolePage.dart' as _i13;
import 'package:acuro/pages/Login/TakeUserDetailsPage.dart' as _i15;
import 'package:acuro/pages/Main/MainPage.dart' as _i8;
import 'package:acuro/pages/Splash/GetStartedPage.dart' as _i6;
import 'package:acuro/pages/Splash/SplashPage.dart' as _i14;
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;

/// generated route for
/// [_i1.CommodityConfirmationPage]
class CommodityConfirmationRoute
    extends _i16.PageRouteInfo<CommodityConfirmationRouteArgs> {
  CommodityConfirmationRoute({
    _i17.Key? key,
    required List<_i18.CommodityModel> selectedCommodityList,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          CommodityConfirmationRoute.name,
          args: CommodityConfirmationRouteArgs(
            key: key,
            selectedCommodityList: selectedCommodityList,
          ),
          initialChildren: children,
        );

  static const String name = 'CommodityConfirmationRoute';

  static _i16.PageInfo page = _i16.PageInfo(
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

  final _i17.Key? key;

  final List<_i18.CommodityModel> selectedCommodityList;

  @override
  String toString() {
    return 'CommodityConfirmationRouteArgs{key: $key, selectedCommodityList: $selectedCommodityList}';
  }
}

/// generated route for
/// [_i2.CreatePasswordPage]
class CreatePasswordRoute extends _i16.PageRouteInfo<CreatePasswordRouteArgs> {
  CreatePasswordRoute({
    _i17.Key? key,
    required String firstName,
    required String lastName,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          CreatePasswordRoute.name,
          args: CreatePasswordRouteArgs(
            key: key,
            firstName: firstName,
            lastName: lastName,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatePasswordRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatePasswordRouteArgs>();
      return _i2.CreatePasswordPage(
        key: args.key,
        firstName: args.firstName,
        lastName: args.lastName,
      );
    },
  );
}

class CreatePasswordRouteArgs {
  const CreatePasswordRouteArgs({
    this.key,
    required this.firstName,
    required this.lastName,
  });

  final _i17.Key? key;

  final String firstName;

  final String lastName;

  @override
  String toString() {
    return 'CreatePasswordRouteArgs{key: $key, firstName: $firstName, lastName: $lastName}';
  }
}

/// generated route for
/// [_i3.EmailVerificationPage]
class EmailVerificationRoute extends _i16.PageRouteInfo<void> {
  const EmailVerificationRoute({List<_i16.PageRouteInfo>? children})
      : super(
          EmailVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmailVerificationRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i3.EmailVerificationPage();
    },
  );
}

/// generated route for
/// [_i4.ForgotOtpPage]
class ForgotOtpRoute extends _i16.PageRouteInfo<ForgotOtpRouteArgs> {
  ForgotOtpRoute({
    _i17.Key? key,
    required bool isEmail,
    required String detailsValue,
    required String verificationId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          ForgotOtpRoute.name,
          args: ForgotOtpRouteArgs(
            key: key,
            isEmail: isEmail,
            detailsValue: detailsValue,
            verificationId: verificationId,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgotOtpRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotOtpRouteArgs>();
      return _i4.ForgotOtpPage(
        key: args.key,
        isEmail: args.isEmail,
        detailsValue: args.detailsValue,
        verificationId: args.verificationId,
      );
    },
  );
}

class ForgotOtpRouteArgs {
  const ForgotOtpRouteArgs({
    this.key,
    required this.isEmail,
    required this.detailsValue,
    required this.verificationId,
  });

  final _i17.Key? key;

  final bool isEmail;

  final String detailsValue;

  final String verificationId;

  @override
  String toString() {
    return 'ForgotOtpRouteArgs{key: $key, isEmail: $isEmail, detailsValue: $detailsValue, verificationId: $verificationId}';
  }
}

/// generated route for
/// [_i5.ForgotPasswordPage]
class ForgotPasswordRoute extends _i16.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i5.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i6.GetStartedPage]
class GetStartedRoute extends _i16.PageRouteInfo<void> {
  const GetStartedRoute({List<_i16.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i6.GetStartedPage();
    },
  );
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i7.LoginPage();
    },
  );
}

/// generated route for
/// [_i8.MainPage]
class MainRoute extends _i16.PageRouteInfo<void> {
  const MainRoute({List<_i16.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i8.MainPage();
    },
  );
}

/// generated route for
/// [_i9.OtpVerifyPage]
class OtpVerifyRoute extends _i16.PageRouteInfo<OtpVerifyRouteArgs> {
  OtpVerifyRoute({
    _i17.Key? key,
    required String phoneNumber,
    required String verificationId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          OtpVerifyRoute.name,
          args: OtpVerifyRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
            verificationId: verificationId,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpVerifyRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpVerifyRouteArgs>();
      return _i9.OtpVerifyPage(
        key: args.key,
        phoneNumber: args.phoneNumber,
        verificationId: args.verificationId,
      );
    },
  );
}

class OtpVerifyRouteArgs {
  const OtpVerifyRouteArgs({
    this.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  final _i17.Key? key;

  final String phoneNumber;

  final String verificationId;

  @override
  String toString() {
    return 'OtpVerifyRouteArgs{key: $key, phoneNumber: $phoneNumber, verificationId: $verificationId}';
  }
}

/// generated route for
/// [_i10.PhoneRegistrationPage]
class PhoneRegistrationRoute extends _i16.PageRouteInfo<void> {
  const PhoneRegistrationRoute({List<_i16.PageRouteInfo>? children})
      : super(
          PhoneRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRegistrationRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i10.PhoneRegistrationPage();
    },
  );
}

/// generated route for
/// [_i11.ResetPasswordPage]
class ResetPasswordRoute extends _i16.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i11.ResetPasswordPage();
    },
  );
}

/// generated route for
/// [_i12.SelectCommodityPage]
class SelectCommodityRoute extends _i16.PageRouteInfo<void> {
  const SelectCommodityRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SelectCommodityRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectCommodityRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i12.SelectCommodityPage();
    },
  );
}

/// generated route for
/// [_i13.SelectRolePage]
class SelectRoleRoute extends _i16.PageRouteInfo<void> {
  const SelectRoleRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SelectRoleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectRoleRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i13.SelectRolePage();
    },
  );
}

/// generated route for
/// [_i14.SplashPage]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashPage();
    },
  );
}

/// generated route for
/// [_i15.TakeUserDetailsPage]
class TakeUserDetailsRoute extends _i16.PageRouteInfo<void> {
  const TakeUserDetailsRoute({List<_i16.PageRouteInfo>? children})
      : super(
          TakeUserDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TakeUserDetailsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.TakeUserDetailsPage();
    },
  );
}
