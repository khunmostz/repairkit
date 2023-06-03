import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/widget/custom_toast.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(BuildContext context,{String? name,String? phone, String? email, String? password,String? address}) async {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
          email: email ?? '', password: password ?? '');

          createUserData({
            'name': name,
            'email': email,
            'password': password,
            'phone': phone,
            'address': address,
            'status': false,
          });

          showToast(context,toastText: 'register succesfully'.tr,status: ToastStatus.SUCCESS);
    } catch (e) {
      debugPrint(e.toString());
       showToast(context,toastText: 'register failed'.tr,status: ToastStatus.ERROR);
    }
  }

  Future<void> createUserData(Map<String,dynamic> data)async{
    try {
      await _firestore.collection('users').doc(data['email']).set(data);
    } catch (e) {
       debugPrint(e.toString());
    }
  }
}
