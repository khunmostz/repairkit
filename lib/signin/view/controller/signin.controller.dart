import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/widget/custom_toast.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn(BuildContext context,
      {String? email, String? password}) async {
    try {
      firebaseAuth.signInWithEmailAndPassword(
          email: email ?? '', password: password ?? '');
       showToast(context,toastText: 'login succesfully'.tr,status: ToastStatus.SUCCESS);
      update();
    } catch (e) {
      debugPrint(e.toString());
      showToast(context,toastText: 'login failed'.tr,status: ToastStatus.ERROR);
    }
  }
}
