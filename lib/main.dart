import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/languages/languages.dart';
import 'package:flutter_boilerplate/base/layout/controller/layout.binding.dart';
import 'package:flutter_boilerplate/base/theme/controller/theme.controller.dart';
import 'package:flutter_boilerplate/base/theme/theme.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/service_notification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  await NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return ScreenUtilInit(
      designSize:
          const Size(430.0, 932.0), // set width and height on your emulator,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<ThemeController>(builder: (_) {
          return GetMaterialApp(
            title: 'Flutter BoilerPlate',
            theme: lightTheme,
            darkTheme: darkTheme,
            initialBinding: LayoutBinding(),
            themeMode: themeController.themeMode,
            translations: Languages(),
            defaultTransition: Transition.fade,
            fallbackLocale: const Locale('en', 'US'),
            locale: Get.deviceLocale,
            initialRoute: RouteConstants.home,
            getPages: RouteConstants.page,
          );
        });
      },
    );
  }
}
