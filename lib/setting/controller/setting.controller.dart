import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/languages/languages_code.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  bool? toggle = false;
  void toggleLanguages() {
    toggle = !toggle!;
    if (toggle == false) {
      Get.updateLocale(const Locale(LanguagesCode.JAPANESE_CODE));
    } else {
      Get.updateLocale(const Locale('en'));
    }
  }
}
