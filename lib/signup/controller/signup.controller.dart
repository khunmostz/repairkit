import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/utils/get_storage.dart';
import 'package:flutter_boilerplate/base/utils/service_locator.dart';
import 'package:flutter_boilerplate/base/widget/custom_toast.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(BuildContext context,
      {String? name,
      String? phone,
      String? email,
      String? password,
      String? address}) async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
     

      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email ?? '', password: password ?? '').then((value) => showToast(context,
            toastText: 'register succesfully'.tr, status: ToastStatus.SUCCESS));

      createUserData({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
        'status': false,
        'imageProfile': null,
        'uid': _firebaseAuth.currentUser?.uid,
        'fcmToken': await messaging.getToken()
      });
      ;
    } catch (e) {
      debugPrint(e.toString());
      showToast(context,
          toastText: 'register failed'.tr, status: ToastStatus.ERROR);
    }
  }

  Future<void> createUserData(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(data['email']).set(data);
        GetStorageService.setFcmToLocal(data['fcmToken'] ?? '');
        getIt<GlobalStateService>()
            .setFcmToken(data['fcmToken'] ?? '');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
