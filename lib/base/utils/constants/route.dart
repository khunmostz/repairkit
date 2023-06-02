import 'package:flutter_boilerplate/base/layout/controller/layout.binding.dart';
import 'package:flutter_boilerplate/base/layout/layout.dart';
import 'package:flutter_boilerplate/home/view/home.dart';
import 'package:flutter_boilerplate/post/view/post.dart';
import 'package:flutter_boilerplate/setting/view/setting.dart';
import 'package:flutter_boilerplate/signin/view/sigin.dart';
import 'package:get/get.dart';

class RouteConstants {
  static String layout = '/layout';
  static String home = '/home';
  static String signIn = '/signIn';

  static List<GetPage> page = [
    GetPage(name: layout, page: () => const Layout()),
    GetPage(name: home, page: () => const Home()),
    GetPage(name: '/post', page: () => const Post()),
    GetPage(name: '/setting', page: () => const Setting()),
    GetPage(name: signIn, page: () =>  SignIn()),
  ];
}
