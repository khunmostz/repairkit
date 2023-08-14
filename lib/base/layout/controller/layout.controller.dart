import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/chat/view/chat.dart';
import 'package:flutter_boilerplate/chat/view/chatlist.dart';
import 'package:flutter_boilerplate/home/view/home.dart';
import 'package:flutter_boilerplate/profie/view/profile.dart';
import 'package:flutter_boilerplate/setting/view/setting.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //#region variable layout
  int screenIndex = 0;
  List<Widget> screen = [
    Home(),
    ChatList(),
    Profile(),
    const Setting(),
  ];

  List screenArguments = [
    {
      "icon": const Icon(Icons.home, color: Colors.white),
      "name": "Home",
    },
    {"icon": const Icon(Icons.chat, color: Colors.white), "name": "Chat"},
    {"icon": const Icon(Icons.person, color: Colors.white), "name": "Profile"},
    {
      "icon": const Icon(Icons.settings, color: Colors.white),
      "name": "Setting"
    },
  ];

  //#endregion variable layout

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authState();
  }

  Future authState() async {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('==== Go to Sign in ====');
        Get.toNamed(RouteConstants.signIn);
      } else {
        debugPrint('==== Go to Home ====');
        Get.offNamed(RouteConstants.layout);
      }
    });
  }

  void changeScreen(int index) async {
    screenIndex = index;
    update();
  }
}
