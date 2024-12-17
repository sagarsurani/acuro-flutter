
import 'package:dio/dio.dart';

import 'localized_error.dart';
import 'network_error.dart';

class GeneralNetworkError extends NetworkError with LocalizedError {
  GeneralNetworkError(DioError dioError) : super(dioError);

  @override
  String getLocalizedKey() => 'Something went wrong';

  @override
  String? get getErrorCode => null;
}
