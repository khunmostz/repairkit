import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/theme/theme.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    update();
  }
}
