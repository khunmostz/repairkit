import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn(BuildContext context,
      {String? email, String? password}) async {
    try {
      firebaseAuth.signInWithEmailAndPassword(
          email: email ?? '', password: password ?? '');
     
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
