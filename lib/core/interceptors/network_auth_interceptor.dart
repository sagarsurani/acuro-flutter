
import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'combining_smart_interceptor.dart';

@singleton
class NetworkAuthInterceptor extends SimpleInterceptor {
  final _excludedPaths = [];

  NetworkAuthInterceptor();

  @override
  Future<Object?> onRequest(RequestOptions options) async {
    if (_excludedPaths.contains(options.path)) {
      return super.onRequest(options);
    }

    String? accessToken = await PreferenceHelper.getAccessToken();

    if (accessToken == null) {
      options.headers.remove(HEADER_AUTHORIZATION);
    } else {
      options.headers[HEADER_AUTHORIZATION] =
          "$HEADER_PROTECTED_AUTHENTICATION_PREFIX ${accessToken.replaceAll('"', '')}";
    }
    return options;
  }
}
