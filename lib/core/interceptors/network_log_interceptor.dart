
import 'package:acuro/core/exceptions/general_error.dart';
import 'package:acuro/core/exceptions/network_error.dart';
import 'package:acuro/core/logging/logging.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'combining_smart_interceptor.dart';

@singleton
class NetworkLogInterceptor extends SimpleInterceptor {
  @override
  Future<Object?> onRequest(RequestOptions options) async {
    logger.logNetworkRequest(options);
    return super.onRequest(options);
  }

  @override
  Future<Object?> onResponse(Response response) async {
    logger.logNetworkResponse(response);
    return super.onResponse(response);
  }

  @override
  Future<Object?> onError(DioException error) async {
    debugPrint('ERROR: $error');

    if (error is NetworkError) {
      debugPrint('NETWORK ERROR: $error');

      logger.logNetworkError(error);
    } else {
      debugPrint('GENERAL N888888ETWORK ERROR: $error');

      logger.logNetworkError(GeneralNetworkError(error));
    }
    return super.onError(error);
  }
}
