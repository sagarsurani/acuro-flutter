
import 'package:dio/dio.dart';

import 'localized_error.dart';
import 'network_error.dart';

class NoInternetError extends NetworkError with LocalizedError {
  NoInternetError(DioError dioError) : super(dioError);

  @override
  String getLocalizedKey() => 'No internet connection available';

  @override
  String? get getErrorCode => null;
}

class NoNetworkError extends Error {}
