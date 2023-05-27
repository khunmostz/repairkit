import 'package:flutter_boilerplate/base/layout/controller/layout.controller.dart';
import 'package:flutter_boilerplate/base/theme/controller/theme.controller.dart';
import 'package:flutter_boilerplate/home/controller/home.controller.dart';
import 'package:flutter_boilerplate/post/controller/post.controller.dart';
import 'package:flutter_boilerplate/setting/controller/setting.controller.dart';
import 'package:get/get.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LayoutController>(() => LayoutController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
