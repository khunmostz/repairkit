import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool? theme = false;
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    theme = !theme!;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    update();
  }
}
