import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/widget/custom_toast.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => showToast(context,
              toastText: 'login succesfully'.tr, status: ToastStatus.SUCCESS));

      // getUserData(email: email);

      update();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      switch (e.code) {
        case 'invalid-email':
          showToast(context, toastText: e.code, status: ToastStatus.ERROR);
          break;
        case 'wrong-password':
          showToast(context, toastText: e.code, status: ToastStatus.ERROR);
          break;
        case 'user-not-found':
          showToast(context, toastText: e.code, status: ToastStatus.ERROR);
          break;
        case 'user-disabled':
          showToast(context, toastText: e.code, status: ToastStatus.ERROR);
          break;
      }
    }
  }

  Future<bool?> forgotPass(BuildContext context,
      {required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).then((value) =>
          showToast(context,
              toastText: 'Please check your email'.tr,
              status: ToastStatus.SUCCESS));

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
