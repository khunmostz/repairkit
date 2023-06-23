import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<Map<String, dynamic>> itemColumnProfile = [
    {
      'name': 'history_rent',
      'title': 'ของที่ต้องได้รับ',
      'icon': const Icon(Icons.card_giftcard),
    },
    {
      'name': 'rating',
      'title': 'คะแนน',
      'icon': const Icon(Icons.star),
    },
    {
      'name': 'history_rent',
      'title': 'เช็คสถาณะเช่ายืม',
      'icon': const Icon(Icons.history),
    },
  ];

  List<Map<String, dynamic>> itemRowProfile = [
    {
      'iconLeading': Icon(
        Icons.history,
        color: ColorConstants.COLOR_WHITE,
      ),
      'name': 'history_rent',
      'title': 'ประวัติการสั่งเช่าสินค้า',
      'iconAction':
          Icon(Icons.arrow_forward_ios, color: ColorConstants.COLOR_WHITE),
    },
    {
      'iconLeading': Icon(Icons.badge, color: ColorConstants.COLOR_WHITE),
      'name': 'rent_store',
      'title': 'ร้านเช่ายืม',
      'iconAction':
          Icon(Icons.arrow_forward_ios, color: ColorConstants.COLOR_WHITE),
    },
    {
      'iconLeading': Icon(Icons.settings, color: ColorConstants.COLOR_WHITE),
      'name': 'profile_setting',
      'title': 'การตั่งค่าบัญชี',
      'iconAction':
          Icon(Icons.arrow_forward_ios, color: ColorConstants.COLOR_WHITE),
    },
  ];

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
