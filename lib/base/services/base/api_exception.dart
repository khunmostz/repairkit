import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';

class DioExceptions implements Exception {
  String? message;
  DioExceptions.fromDioError(DioError diaError) {
    switch (diaError.type) {
      case DioErrorType.cancel:
        message = ErrorTypeDio.CANCEL;
        break;
      case DioErrorType.connectionTimeout:
        message = ErrorTypeDio.CONNECTION_TIMEOUT;
        break;
      case DioErrorType.unknown:
        message = ErrorTypeDio.UNKNOWN;
        break;
      case DioErrorType.receiveTimeout:
        message = ErrorTypeDio.RECEIVE_TIMEOUT;
        break;
      case DioErrorType.badResponse:
        message = _handleError(
            diaError.response?.statusCode, diaError.response?.data);
        break;
      default:
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return StatusCode.BAD_REQUEST;
      case 401:
        return StatusCode.UNAUTHORIZED;
      case 404:
        return StatusCode.NOT_FOUND;
      case 405:
        return StatusCode.METHOD_NOT_ALLOWED;
      case 408:
        return StatusCode.REQUEST_TIMEOUT;
      case 500:
        return StatusCode.INTERNAL_SERVER_ERROR;
      case 502:
        return StatusCode.BAD_GATEWAY;
      case 504:
        return StatusCode.GATEWAY_TIMEOUT;
      default:
        return StatusCode.SOMETING_WENT_WRONG;
    }
  }
}
