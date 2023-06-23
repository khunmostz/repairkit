import 'package:flutter_boilerplate/base/layout/controller/layout.controller.dart';
import 'package:flutter_boilerplate/base/theme/controller/theme.controller.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:flutter_boilerplate/chat/controller/chat.controller.dart';
import 'package:flutter_boilerplate/home/controller/home.controller.dart';
import 'package:flutter_boilerplate/payment/controller/payment.controller.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_boilerplate/profie/controller/profile.controller.dart';
import 'package:flutter_boilerplate/setting/controller/setting.controller.dart';
import 'package:flutter_boilerplate/signin/view/controller/signin.controller.dart';
import 'package:flutter_boilerplate/signup/controller/signup.controller.dart';
import 'package:get/get.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LayoutController>(() => LayoutController(), fenix: true);
    Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
    Get.lazyPut<SignInController>(() => SignInController(), fenix: true);
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
     Get.lazyPut<ChatController>(() => ChatController(), fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<PaymentController>(() => PaymentController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
   
  }
}
