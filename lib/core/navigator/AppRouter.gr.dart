// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acuro/pages/Login/OtpVerifyPage.dart' as _i2;
import 'package:acuro/pages/Login/PhoneRegistrationPage.dart' as _i3;
import 'package:acuro/pages/Splash/GetStartedPage.dart' as _i1;
import 'package:acuro/pages/Splash/SplashPage.dart' as _i4;
import 'package:auto_route/auto_route.dart' as _i5;

/// generated route for
/// [_i1.GetStartedPage]
class GetStartedRoute extends _i5.PageRouteInfo<void> {
  const GetStartedRoute({List<_i5.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.GetStartedPage();
    },
  );
}

/// generated route for
/// [_i2.OtpVerifyPage]
class OtpVerifyRoute extends _i5.PageRouteInfo<void> {
  const OtpVerifyRoute({List<_i5.PageRouteInfo>? children})
      : super(
          OtpVerifyRoute.name,
          initialChildren: children,
        );

  static const String name = 'OtpVerifyRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.OtpVerifyPage();
    },
  );
}

/// generated route for
/// [_i3.PhoneRegistrationPage]
class PhoneRegistrationRoute extends _i5.PageRouteInfo<void> {
  const PhoneRegistrationRoute({List<_i5.PageRouteInfo>? children})
      : super(
          PhoneRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRegistrationRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.PhoneRegistrationPage();
    },
  );
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashPage();
    },
  );
}
