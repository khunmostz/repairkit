import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentalController extends GetxController {
  bool? haveRental;

  @override
  void onInit()async {
    super.onInit();
   await getUserData();
  }

  Future<void> getUserData() async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .get();
      if (user.data()?['status'] == false) {
        haveRental = false;
      } else {
        haveRental = true;
      }
      print(haveRental);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
