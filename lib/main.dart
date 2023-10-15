import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/languages/languages.dart';
import 'package:flutter_boilerplate/base/layout/controller/layout.binding.dart';
import 'package:flutter_boilerplate/base/theme/controller/theme.controller.dart';
import 'package:flutter_boilerplate/base/theme/theme.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/get_storage.dart';
import 'package:flutter_boilerplate/base/utils/service_locator.dart';
import 'package:flutter_boilerplate/base/utils/service_notification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
  await NotificationService().initNotification();
  // await NotificationService().initializeFirebaseMessaging();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  await NotificationService().initNotification();
  await NotificationService().initializeFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupTimezone();
  setupGetIt();
  getTokenFcmFromLocal();
  runApp(const MyApp());
}

void getTokenFcmFromLocal() {
  if (GetStorageService.getFcmToLocal() != '' &&
      GetStorageService.getFcmToLocal() != null) {
    String? fcmToken = GetStorageService.getFcmToLocal();
    getIt<GlobalStateService>().setFcmToken(fcmToken);
    debugPrint('==== fcmToken: ${getIt<GlobalStateService>().fcmToken} ====');
  } else {
    debugPrint('==== fcmToken: Not found!! ====');
  }
}

Future<void> setupTimezone() async {
  tz.initializeTimeZones();
  var detroit = tz.getLocation('Asia/Bangkok');
  tz.setLocalLocation(detroit);
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
            navigatorKey: Get.key,
            debugShowCheckedModeBanner: false,
            title: 'Rent a repaire kit',
            theme: lightTheme,
            darkTheme: darkTheme,
            initialBinding: LayoutBinding(),
            themeMode: themeController.themeMode,
            translations: Languages(),
            defaultTransition: Transition.fade,
            fallbackLocale: const Locale('en', 'US'),
            locale: Get.deviceLocale,
            initialRoute: RouteConstants.layout,
            getPages: RouteConstants.page,
          );
        });
      },
    );
  }
}
