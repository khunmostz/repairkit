import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/languages/languages_code.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool? toggleLang = true;

  void toggleLanguages() {
    toggleLang = !toggleLang!;
    // debugPrint(toggleLang.toString());
    if (toggleLang == false) {
      Get.updateLocale(const Locale(LanguagesCode.THAI_CODE));
    } else {
      Get.updateLocale(const Locale(LanguagesCode.ENGLISH_CODE));
    }
    update();
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
