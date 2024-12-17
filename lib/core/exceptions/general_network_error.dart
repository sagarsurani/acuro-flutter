import 'localized_error.dart';

class GeneralError with LocalizedError {
  GeneralError() : super();

  @override
  String getLocalizedKey() => 'Something went wrong';
}
