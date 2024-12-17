
import 'package:acuro/core/logging/logging.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import '../exceptions/bad_request_error.dart';
import '../exceptions/code_error.dart';
import '../exceptions/forbidden_error.dart';
import '../exceptions/general_error.dart';
import '../exceptions/internal_server_error.dart';
import '../exceptions/no_internet_error.dart';
import '../exceptions/un_authorized_error.dart';
import 'combining_smart_interceptor.dart';

@singleton
class NetworkErrorInterceptor extends SimpleInterceptor {

  @override
  Future<Object?> onError(DioException? error) async {
    try {
      if (error == null) return CodeError();
      if (error.error is NoNetworkError) {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0,
        );
        return NoInternetError(error);
      }
      if (error.error is NoNetworkError) return NoInternetError(error);
      if (error.response == null) return CodeError();
      final statusCode = error.response?.statusCode;
      switch (statusCode) {
        case UnAuthorizedError.statusCode:
          return UnAuthorizedError(error);
        case BadRequestError.statusCode:
          return BadRequestError.parseError(error);
        case ForbiddenError.statusCode:
          return ForbiddenError.parseError(error);
        case InternalServerError.statusCode:
          return InternalServerError(error);
        default:
          return GeneralNetworkError(error);
      }
    } catch (e, stack) {
      logger.error('Failed to get correct error', error: e, trace: stack);
      return CodeError();
    }
  }
}
