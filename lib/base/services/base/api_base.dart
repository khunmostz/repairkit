import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/base/services/base/api_exception.dart';

class BaseServiceApi {
  final dio = Dio();

  String baseUrl = 'https://reqres.in/'; // demo url

  static Future<Map<String, dynamic>> _getHeader() async {
    Map<String, dynamic>? headers = {
      //Add or Remove headers from here
      'Content-Type': 'application/json',
      // 'lang': 'en',
      // 'Authorization': 'Bearer '
    };
    // String? accessToken = 'get token from local storage';
    // if (accessToken != null) {
    //   headers["Authorization"] = "Bearer $accessToken";
    // }

    return headers;
  }

  Future<dynamic> getRequest(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response;
      response = await dio.get(
        '$baseUrl$url',
        queryParameters: queryParameters,
        options: Options(
          headers: await _getHeader(),
        ),
      );

      // print(response.data);
      return response.data;
    } on DioError catch (e) {
      DioExceptions.fromDioError(e);
    }
  }

  Future postRequest(String url, {Map<String, dynamic>? data}) async {
    Response response;
    response = await dio.post(
      '$baseUrl$url',
      data: data,
      options: Options(
        headers: await _getHeader(),
      ),
    );
  }

  Future putRequest(String url, {Map<String, dynamic>? data}) async {
    Response response;
    response = await dio.put(
      '$baseUrl$url',
      data: data,
      options: Options(
        headers: await _getHeader(),
      ),
    );
  }

  Future deleteRequest(String url, {Map<String, dynamic>? data}) async {
    Response response;
    response = await dio.delete(
      '$baseUrl$url',
      data: data,
      options: Options(
        headers: await _getHeader(),
      ),
    );
  }
}
