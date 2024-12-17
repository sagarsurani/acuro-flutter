import 'dart:io';

import 'package:dio/dio.dart';

import 'localized_error.dart';
import 'network_error.dart';

class InternalServerError extends NetworkError with LocalizedError {
  static const statusCode = HttpStatus.internalServerError;

  InternalServerError(DioError dioError, {String? statusCode})
      : super(dioError, statusCodeValue: statusCode);

  @override
  String getLocalizedKey() => 'Internal Server error';

  @override
  String? get getErrorCode {
    if (statusCodeValue == null) return '$statusCode';
    return '$statusCode [$statusCodeValue]';
  }
}
