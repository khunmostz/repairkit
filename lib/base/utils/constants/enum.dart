class ErrorTypeDio {
  static String CANCEL = "Request to API server was cancelled.";
  static String CONNECTION_TIMEOUT = "Connection time out with API server";
  static String UNKNOWN =
      "Connection to API server failled due to internet connection.";
  static String RECEIVE_TIMEOUT =
      "Receive timeout in connection with API server";
}

class StatusCode {
  static String BAD_REQUEST = "Bad Request";
  static String UNAUTHORIZED = "Unauthorized";
  static String PAYMENT_REQUIRED = "Payment Required";
  static String FORBIDDEN = "Forbidden";
  static String NOT_FOUND = "Not Found";
  static String METHOD_NOT_ALLOWED = "Method Not Allowed";
  static String REQUEST_TIMEOUT = "Request Timeout";
  static String INTERNAL_SERVER_ERROR = "Internal Server Error";
  static String BAD_GATEWAY = "Bad Gateway";
  static String GATEWAY_TIMEOUT = "Gateway Timeout";
  static String SOMETING_WENT_WRONG = "Oops something went wrong";
}

class ToastStatus {
  static String SUCCESS ='Success';
  static String ERROR='Error';
}
