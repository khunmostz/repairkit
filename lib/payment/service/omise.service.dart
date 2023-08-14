import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/services/base/api_exception.dart';
import 'package:flutter_boilerplate/payment/controller/payment.controller.dart';
import 'package:get/get.dart';

class OmiseService {
  final dio = Dio();
  final String _publicKey =
      latin1.fuse(base64).encode('pkey_test_5w2b5dyr5427zucqfec');
  final String _secretKey =
      latin1.fuse(base64).encode('skey_test_5vzwjxk5028c5mdy886');
  final String _tokenBase = 'https://vault.omise.co/tokens';
  final String _chargesBase = 'https://api.omise.co/charges';
  String token = '';

  Future<dynamic> getToken({
    required String cardName,
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required int cvc,
  }) async {
    try {
      var response = await dio.post(
        _tokenBase,
        data: {
          'card[name]': 'JOHN DOE',
          'card[number]': '4242424242424242',
          'card[expiration_month]': 5,
          'card[expiration_year]': 2025,
          'card[security_code]': 123,
        },
        options: Options(
          validateStatus: (_) => true,
          contentType: "application/x-www-form-urlencoded",
          headers: {HttpHeaders.authorizationHeader: 'Basic $_publicKey'},
        ),
      );
      Get.find<PaymentController>().setOmiseToken(response.data['id']);

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.toString());
      DioExceptions.fromDioError(e);
    }
  }

  Future<dynamic> chargesCard(
      {required String description, required String amount}) async {
    // print(token);
    try {
      var response = await dio.post(
        _chargesBase,
        data: {
          'description': description,
          'amount': '${amount}00',
          'currency': 'thb',
          'card': Get.find<PaymentController>().token,
        },
        options: Options(
          validateStatus: (_) => true,
          contentType: "application/x-www-form-urlencoded",
          headers: {HttpHeaders.authorizationHeader: 'Basic $_secretKey'},
        ),
      );
      // print(response.data);
      return response.data;
    } on DioError catch (e) {
      debugPrint(e.toString());
      DioExceptions.fromDioError(e);
    }
  }
}
