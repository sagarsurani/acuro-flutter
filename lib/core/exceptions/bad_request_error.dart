
import 'dart:io';
import 'package:dio/dio.dart';
import 'localized_error.dart';
import 'network_error.dart';

class BadRequestError extends NetworkError with LocalizedError {
  static const statusCode = HttpStatus.badRequest;

  BadRequestError(super.dioError, {String? statusCode})
      : super(statusCodeValue: statusCode);

  @override
  String getLocalizedKey() => 'Bad request';

  @override
  String? get getErrorCode {
    if (statusCodeValue == null) return '$statusCode';
    return '$statusCode [$statusCodeValue]';
  }

  static NetworkError parseError(DioError err) {
    final dynamic data = err.response?.data;
    if (data == null || data == '') return BadRequestError(err);
    final code = data['code'] as String; // ignore: avoid_as
    switch (code) {
      default:
        return BadRequestError(err);
    }
  }
}
