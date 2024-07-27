class AppException implements Exception {

  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }

}

// if response is not getting in specific time
class FetchDataExceptions extends AppException {

  FetchDataExceptions([String? message]) : super(message, 'Error during communication');
}

// wrong url
class BadRequestExceptions extends AppException {

  BadRequestExceptions([String? message]) : super(message, 'Invalid  request');
}

// if token is not generated
class UnauthorisedException extends AppException {

  UnauthorisedException([String? message]) : super(message, 'Unauthorised  request');
}

// if input are incorrect
class InvalidException extends AppException {

  InvalidException([String? message]) : super(message, 'Invalid input');
}