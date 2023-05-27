import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/languages/languages_code.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  bool? toggleLang = false;

  void toggleLanguages() {
    toggleLang = !toggleLang!;
    if (toggleLang == false) {
      Get.updateLocale(const Locale(LanguagesCode.JAPANESE_CODE));
    } else {
      Get.updateLocale(const Locale(LanguagesCode.ENGLISH_CODE));
    }
  }
}
