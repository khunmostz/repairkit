import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/get_storage.dart';
import 'package:flutter_boilerplate/base/utils/service_locator.dart';
import 'package:flutter_boilerplate/chat/view/chatlist.dart';
import 'package:flutter_boilerplate/home/view/home.dart';
import 'package:flutter_boilerplate/profie/view/profile.dart';
import 'package:flutter_boilerplate/rental_check/view/rental_check.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //#region variable layout
  int screenIndex = 0;
  List<Widget> screen = [
    const Home(),
    const ChatList(),
    const RentalCheck(),
    const Profile(),
  ];

  List screenArguments = [
    {
      "icon": const Icon(Icons.home, color: Colors.white),
      "name": "Home",
    },
    {"icon": const Icon(Icons.chat, color: Colors.white), "name": "Chat"},
    {
      "icon": const Icon(Icons.access_time_filled, color: Colors.white),
      "name": "RentalCheck"
    },
    {"icon": const Icon(Icons.person, color: Colors.white), "name": "Profile"},
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

  Future<void> updateUserFcm() async {
    try {
      var fcmToken = await FirebaseMessaging.instance.getToken();

      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({
        "fcmToken": fcmToken,
      });
      GetStorageService.setFcmToLocal(fcmToken ?? '');
      getIt<GlobalStateService>().setFcmToken(fcmToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeScreen(int index) async {
    screenIndex = index;
    update();
  }
}
