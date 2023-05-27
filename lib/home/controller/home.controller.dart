import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/services/base/api_base.dart';
import 'package:flutter_boilerplate/base/services/base/api_endpoint.dart';
import 'package:flutter_boilerplate/home/model/user_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<UsersModel>? userModel;

  bool? loading = false;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), getUser);
  }

  Future<List<UsersModel>?> getUser() async {
    try {
      var response = BaseServiceApi();
      var data = await response.getRequest(ApiEndPoints.getUsers);
      userModel = parseUserModelToJson(data);
      loading = true;
      update();
      return userModel;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
