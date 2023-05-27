class Success {
  int? code;
  String? message;
  Object? response;
  Success({this.code, this.message, this.response});
  Success copyWith({
    int? code,
    String? message,
    Object? response,
  }) {
    return Success(
      code: code ?? this.code,
      message: message ?? this.message,
      response: response ?? this.response,
    );
  }
}

class Failure {
  int? statusCode;
  String? message;
  String? error;
  int? code;
  String? errResponse;
  Failure({
    this.statusCode,
    this.message,
    this.error,
    this.code,
    this.errResponse,
  });
  Failure copyWith({
    int? statusCode,
    String? message,
    String? error,
    int? code,
    String? errResponse,
  }) {
    return Failure(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      error: error ?? this.error,
      code: code ?? this.code,
      errResponse: errResponse ?? this.errResponse,
    );
  }
}
