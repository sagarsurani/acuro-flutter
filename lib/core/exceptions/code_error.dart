import 'localized_error.dart';

class CodeError with LocalizedError {
  @override
  String getLocalizedKey() {
    return 'Something went wrong';
  }
}
