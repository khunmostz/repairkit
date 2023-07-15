import 'package:flutter_boilerplate/base/layout/layout.dart';
import 'package:flutter_boilerplate/cart/view/cart.dart';
import 'package:flutter_boilerplate/chat/controller/chat.controller.dart';
import 'package:flutter_boilerplate/chat/view/chat.dart';
import 'package:flutter_boilerplate/chat/view/chatlist.dart';
import 'package:flutter_boilerplate/home/view/home.dart';
import 'package:flutter_boilerplate/payment/view/payment.dart';
import 'package:flutter_boilerplate/payment/view/payment_successful.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_boilerplate/product/view/product.dart';
import 'package:flutter_boilerplate/product/view/product_detail.dart';
import 'package:flutter_boilerplate/receive_product/view/receive_product.dart';
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
  static String payment = '/payment';
  static String paymentSuccessful = '/payment/successful';
  static String chat = '/chat';
  static String chatList = '/chatList';
  static String receiveProduct = '/receive/product';

  static List<GetPage> page = [
    GetPage(name: layout, page: () => const Layout()),
    GetPage(name: home, page: () => Home()),
    GetPage(name: setting, page: () => const Setting()),
    GetPage(name: signIn, page: () => SignIn()),
    GetPage(name: signUp, page: () => SignUp()),
    GetPage(
        name: product,
        page: () => const Product(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProductController());
        })),
    GetPage(name: productDetail, page: () => const ProductDetail()),
    GetPage(name: cart, page: () => const Cart()),
    GetPage(name: payment, page: () => Payment()),
    GetPage(name: paymentSuccessful, page: () => const PaymentSuccessful()),
    GetPage(name: chat, page: () => ChatView()),
    GetPage(
        name: chatList,
        page: () => const ChatList(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ChatController());
        })),
    GetPage(name: receiveProduct, page: () => ReceiveProduct()),    
  ];
}
