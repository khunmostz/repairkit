import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/get_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Map<String, dynamic> dataProfile = {};

  File? imageProfile;
  String? imageProfileUrl;

  List<Map<String, dynamic>> itemColumnProfile = [
    {
      'name': 'history_rent',
      'title': 'ของที่ต้องได้รับ',
      'icon': const Icon(Icons.card_giftcard),
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

  Future<void> getProfile() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .get();
      dataProfile = response.data() ?? {};

      update();
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<bool?> updateProfile(
      {String? name, String? address, String? phone}) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({
        "name": name,
        "address": address,
        "phone": phone,
      });

      update();
      return true;
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }

    Future<bool?> selectImageProfile({required ImageSource imageSource}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? _pickedImage = await _picker.pickImage(
        source: imageSource,
        imageQuality: 100,
        maxHeight: 250,
        maxWidth: 250,
      );
      if (_pickedImage != null) {
        final Rx<File> _imagePath = File(_pickedImage.path).obs;
        imageProfile = _imagePath.value;
        update();
        uploadProfileImage(imageProfile!.path);

        return true;
      }

      return false;
    } catch (e) {
      print(e);
    }

    return null;
  }

  

    Future<bool?> updateImageProfileFirebase(
      {String? imageProfileUrl}) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({
        "imageProfile": imageProfileUrl,
      });

      update();
      return true;
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }

  Future<void> uploadProfileImage(String imagePath) async {
    var firebaseRef = await FirebaseStorage.instance
        .ref()
        .child('rental-image/${imagePath.split('/').last}');
    var uploadTask = firebaseRef.putFile(imageProfile!);
    var taskSnapshot = await uploadTask.whenComplete(() async {
      debugPrint('upload rental success');
    }).then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      imageProfileUrl = imageUrl;
    });

    updateImageProfileFirebase(imageProfileUrl:imageProfileUrl);
    getProfile();
  }

  Future<void> logout() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    GetStorageService.clearFcmToLocal();
    messaging.deleteToken();
    Get.offAllNamed(RouteConstants.signIn);
    await _firebaseAuth.signOut();
  }
}
