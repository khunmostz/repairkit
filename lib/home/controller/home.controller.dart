import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/service_notification.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> bannerCarousel = [
    'https://www.dewdy.com/img_master/uploads/content/carpenter-using-circular-saw-cutting-.jpg',
    'https://scontent.fbkk12-2.fna.fbcdn.net/v/t1.6435-9/53196640_1066275713557013_1771384472969674752_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=MDmxwwiPi7YAX8gA-uH&_nc_ht=scontent.fbkk12-2.fna&oh=00_AfDBiPJFqBshh5MTXQmNmzLgPfl74kdYs-eAHUIhkPdTkg&oe=64A291B8',
    'https://www.dewdy.com/img_master/uploads/content/carpenter-using-circular-saw-cutting-.jpg',
    'https://scontent.fbkk12-2.fna.fbcdn.net/v/t1.6435-9/53196640_1066275713557013_1771384472969674752_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=MDmxwwiPi7YAX8gA-uH&_nc_ht=scontent.fbkk12-2.fna&oh=00_AfDBiPJFqBshh5MTXQmNmzLgPfl74kdYs-eAHUIhkPdTkg&oe=64A291B8',
  ];

  List<Map<String, String>> categoryList = [
    {
      'name': 'drill',
      'image': 'assets/icons/drill.png',
    },
    {
      'name': 'hammer',
      'image': 'assets/icons/hammer.png',
    },
    {
      'name': 'saw',
      'image': 'assets/icons/hand-saw.png',
    },
    {
      'name': 'planer',
      'image': 'assets/icons/planer.png',
    },
    {
      'name': 'pliers-tool',
      'image': 'assets/icons/pliers-tool.png',
    },
    {
      'name': 'screwdriver',
      'image': 'assets/icons/screwdriver.png',
    },
    {
      'name': 'tape',
      'image': 'assets/icons/tape.png',
    },
    {
      'name': 'equipment',
      'image': 'assets/icons/equipment.png',
    },
  ];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    updateToken();
  }

  String? activeCategory;
  void setActiveCategory(String category) {
    activeCategory = category;
  }

  Future<void> updateToken({String? fcmToken}) async {
    String? fcm = await FirebaseMessaging.instance.getToken();

    if (_firebaseAuth.currentUser?.uid != null) {
      try {
        await _firestore
            .collection('users')
            .doc(_firebaseAuth.currentUser?.email)
            .update({
          'fcmToken': fcm,
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
