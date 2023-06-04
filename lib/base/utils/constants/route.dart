import 'package:flutter_boilerplate/base/layout/layout.dart';
import 'package:flutter_boilerplate/cart/view/cart.dart';
import 'package:flutter_boilerplate/home/view/home.dart';
import 'package:flutter_boilerplate/product/view/product.dart';
import 'package:flutter_boilerplate/product/view/product_detail.dart';
import 'package:flutter_boilerplate/setting/view/setting.dart';
import 'package:flutter_boilerplate/signin/view/sigin.dart';
import 'package:flutter_boilerplate/signup/view/signup.dart';
import 'package:get/get.dart';

class RouteConstants {
  static String layout = '/layout';
  static String home = '/home';
  static String signIn = '/signIn';
  static String signUp = '/signUp';
  static String setting = '/setting';
  static String product = '/product';
  static String productDetail = '/product/detail';
  static String cart = '/cart';

  static List<GetPage> page = [
    GetPage(name: layout, page: () => const Layout()),
    GetPage(name: home, page: () => Home()),
    GetPage(name: setting, page: () => const Setting()),
    GetPage(name: signIn, page: () => SignIn()),
    GetPage(name: signUp, page: () => SignUp()),
    GetPage(name: product, page: () => const Product()),
    GetPage(name: productDetail, page: () => const ProductDetail()),
    GetPage(name: cart, page: () => const Cart()),
  ];
}
