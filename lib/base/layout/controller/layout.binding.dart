import 'package:flutter_boilerplate/base/layout/controller/layout.controller.dart';
import 'package:flutter_boilerplate/base/theme/controller/theme.controller.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:flutter_boilerplate/home/controller/home.controller.dart';
import 'package:flutter_boilerplate/payment/controller/payment.controller.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_boilerplate/setting/controller/setting.controller.dart';
import 'package:flutter_boilerplate/signin/view/controller/signin.controller.dart';
import 'package:flutter_boilerplate/signup/controller/signup.controller.dart';
import 'package:get/get.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LayoutController>(() => LayoutController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<SignInController>(() => SignInController(), fenix: true);
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<PaymentController>(() => PaymentController(), fenix: true);
  }
}
