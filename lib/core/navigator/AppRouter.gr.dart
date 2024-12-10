// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acuro/pages/Commodity/SelectCommodityPage.dart' as _i5;
import 'package:acuro/pages/Login/EmailVerificationPage.dart' as _i1;
import 'package:acuro/pages/Login/OtpVerifyPage.dart' as _i3;
import 'package:acuro/pages/Login/PhoneRegistrationPage.dart' as _i4;
import 'package:acuro/pages/Login/SelectRolePage.dart' as _i6;
import 'package:acuro/pages/Login/TakeUserDetailsPage.dart' as _i8;
import 'package:acuro/pages/Splash/GetStartedPage.dart' as _i2;
import 'package:acuro/pages/Splash/SplashPage.dart' as _i7;
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

/// generated route for
/// [_i1.EmailVerificationPage]
class EmailVerificationRoute extends _i9.PageRouteInfo<void> {
  const EmailVerificationRoute({List<_i9.PageRouteInfo>? children})
      : super(
          EmailVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmailVerificationRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.EmailVerificationPage();
    },
  );
}

/// generated route for
/// [_i2.GetStartedPage]
class GetStartedRoute extends _i9.PageRouteInfo<void> {
  const GetStartedRoute({List<_i9.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.GetStartedPage();
    },
  );
}

/// generated route for
/// [_i3.OtpVerifyPage]
class OtpVerifyRoute extends _i9.PageRouteInfo<OtpVerifyRouteArgs> {
  OtpVerifyRoute({
    _i10.Key? key,
    required String phoneNumber,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          OtpVerifyRoute.name,
          args: OtpVerifyRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpVerifyRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpVerifyRouteArgs>();
      return _i3.OtpVerifyPage(
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

  final _i10.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'OtpVerifyRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i4.PhoneRegistrationPage]
class PhoneRegistrationRoute extends _i9.PageRouteInfo<void> {
  const PhoneRegistrationRoute({List<_i9.PageRouteInfo>? children})
      : super(
          PhoneRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRegistrationRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.PhoneRegistrationPage();
    },
  );
}

/// generated route for
/// [_i5.SelectCommodityPage]
class SelectCommodityRoute extends _i9.PageRouteInfo<void> {
  const SelectCommodityRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SelectCommodityRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectCommodityRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.SelectCommodityPage();
    },
  );
}

/// generated route for
/// [_i6.SelectRolePage]
class SelectRoleRoute extends _i9.PageRouteInfo<void> {
  const SelectRoleRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SelectRoleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectRoleRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.SelectRolePage();
    },
  );
}

/// generated route for
/// [_i7.SplashPage]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashPage();
    },
  );
}

/// generated route for
/// [_i8.TakeUserDetailsPage]
class TakeUserDetailsRoute extends _i9.PageRouteInfo<void> {
  const TakeUserDetailsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          TakeUserDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TakeUserDetailsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.TakeUserDetailsPage();
    },
  );
}
