// ignore_for_file: deprecated_member_use

import 'package:acuro/core/constants/Constants.dart';
import 'package:acuro/core/logging/logging.dart';
import 'package:acuro/core/persistence/PreferenceHelper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../exceptions/un_authorized_error.dart';
import 'combining_smart_interceptor.dart';

@singleton
class NetworkRefreshInterceptor extends SimpleInterceptor {
  bool isReload = false;

  final _excludedPaths = [];

  NetworkRefreshInterceptor();

  @override
  Future<Object?> onResponse(Response response) async {
    if (response.statusCode == 401) {
      String? newToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (newToken != null) {
        await PreferenceHelper.setAccessToken(newToken);
        RequestOptions requestOptions = response.requestOptions;
        requestOptions.headers[HEADER_AUTHORIZATION] =
            '$HEADER_PROTECTED_AUTHENTICATION_PREFIX ${newToken.replaceAll('"', '')}';
        return GetIt.instance.get<Dio>().fetch<dynamic>(requestOptions);
      }
    }
    return super.onResponse(response);
  }

  @override
  Future<Object?> onError(DioError error) async {
    final request = error.requestOptions;
    if (_excludedPaths.contains(request.path)) {
      logger.debug('Network refresh interceptor should not intercept');
      return super.onError(error);
    }

    if (error is! UnAuthorizedError) {
      return super.onError(error);
    }
    logger.debug('Refreshing');

    return GetIt.instance.get<Dio>().fetch<dynamic>(request);
  }
}
