import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  List<Map<String, dynamic>> historyData = [];

  Future<void> getHistory() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('history')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      for (var element in response.docs) {
        historyData.add(element.data());
      }
      update();
    } catch (e) {
      debugPrint('$e');
    }
  }
}
