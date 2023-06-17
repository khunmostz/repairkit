import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Map<String,dynamic> message = {};
  void setMessage(String sendBy){
    message['sendBy']= sendBy;
  }

  Future<void> sendMessage() async {
    try {
      await _firebaseFirestore
          .collection('room-message')
          .doc(
              '${_firebaseAuth.currentUser?.uid}-${Get.find<ProductController>().rentalModel?.rentalName}')
          .collection('messages')
          .add(message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
