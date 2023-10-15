import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/utils/get_storage.dart';
import 'package:flutter_boilerplate/base/utils/service_locator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> bannerCarousel = [
    "https://firebasestorage.googleapis.com/v0/b/rent-a-repaire-kit.appspot.com/o/banner-upload%2F60939384ca6f2-80009018-Mobile-AXS-%E0%B8%A2%E0%B8%B9%E0%B9%80%E0%B8%99%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B8%99%E0%B8%97%E0%B8%A3%E0%B8%B1%E0%B8%84%E0%B9%81%E0%B8%AD%E0%B8%99%E0%B8%94%E0%B9%8C%E0%B8%97%E0%B8%B9%E0%B8%A5%E0%B8%AA%E0%B9%8C-%E0%B9%83%E0%B8%AB%E0%B9%89%E0%B9%80%E0%B8%8A%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%84%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%A1%E0%B8%B7%E0%B8%AD%E0%B8%81%E0%B9%88%E0%B8%AD%E0%B8%AA%E0%B8%A3%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B8%9B%E0%B8%97%E0%B8%B8%E0%B8%A1%E0%B8%98%E0%B8%B2%E0%B8%99%E0%B8%B5.jpg?alt=media&token=5c3fc531-2804-483e-92d5-381e3ac314e4",
    "https://firebasestorage.googleapis.com/v0/b/rent-a-repaire-kit.appspot.com/o/banner-upload%2Ftimeline_25600301_223138.jpg?alt=media&token=eb455f9e-ac83-490d-ac57-db9c329383cb",
    "https://firebasestorage.googleapis.com/v0/b/rent-a-repaire-kit.appspot.com/o/banner-upload%2Facohdcbknwqz.jpg?alt=media&token=81f36c88-c8b9-4e7e-8ef0-2e8440dc787e",
    "https://firebasestorage.googleapis.com/v0/b/rent-a-repaire-kit.appspot.com/o/banner-upload%2Fslide01.jpg?alt=media&token=6b08e8fe-6146-46c4-ac90-bc6076f47015",
  ];

  List<Map<String, String>> categoryList = [
    {
      'name': ProductType.DRILL,
      'image': 'assets/icons/drill.png',
    },
    {
      'name': ProductType.HAMMER,
      'image': 'assets/icons/hammer.png',
    },
    {
      'name': ProductType.SAW,
      'image': 'assets/icons/hand-saw.png',
    },
    {
      'name': ProductType.PLANER,
      'image': 'assets/icons/planer.png',
    },
    {
      'name': ProductType.PLIERS_TOOL,
      'image': 'assets/icons/pliers-tool.png',
    },
    {
      'name': ProductType.SCREWDRIVER,
      'image': 'assets/icons/screwdriver.png',
    },
    {
      'name': ProductType.TAPE,
      'image': 'assets/icons/tape.png',
    },
    {
      'name': ProductType.EQUIPMENT,
      'image': 'assets/icons/equipment.png',
    },
  ];

  @override
  void onInit() {
    // TODO: implement onReady
    super.onInit();
    getUserData();
    updateToken();
  }

  String? activeCategory = ProductType.DRILL;
  void setActiveCategory(String category) {
    activeCategory = category;
  }

  Future<void> updateToken() async {
    if (_firebaseAuth.currentUser?.uid != null) {
      try {
        await _firestore
            .collection('users')
            .doc(_firebaseAuth.currentUser?.email)
            .update({
          'fcmToken': getIt<GlobalStateService>().fcmToken,
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> getUserData() async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .get();
      GetStorageService.clearFcmToLocal();
      GetStorageService.setFcmToLocal(user.data()?['fcmToken']);
      getIt<GlobalStateService>().setFcmToken(user.data()?['fcmToken']);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
