import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/home/view/home.dart';
import 'package:flutter_boilerplate/post/view/post.dart';
import 'package:flutter_boilerplate/setting/view/setting.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  int screenIndex = 0;

  List<Widget> screen = [
    const Home(),
    const Post(),
    const Setting(),
  ];

  List screenArguments = [
    {"icon": const Icon(Icons.home, color: Colors.white), "name": "Home"},
    {"icon": const Icon(Icons.padding, color: Colors.white), "name": "Post"},
    {
      "icon": const Icon(Icons.settings, color: Colors.white),
      "name": "Setting"
    },
  ];

  void changeScreen(int index) async {
    screenIndex = index;

    update();
  }
}
