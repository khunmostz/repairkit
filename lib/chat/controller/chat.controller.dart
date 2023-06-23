import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_boilerplate/product/model/rental.model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  RentalModel? myRental;

  String userMode = ChatMode.USER;

  String activeChat = '';

  @override
  void onInit() {
    super.onInit();
    getRental();
  }

  Map<String, dynamic> message = {
    'messageId': '',
    'sendBy': '',
    'sendTo': Get.find<ProductController>().rentalModel?.rentalName,
    'message': '',
    'messageType': MessageType.TEXT,
    'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
  };

  void setMessage(Map<String, dynamic> data) {
    message = {...message, ...data};
    update();
  }

  Stream<QuerySnapshot> getMessage() {
    if (userMode == ChatMode.USER) {
      return _firebaseFirestore
          .collection('room-message')
          .doc(
              '${_firebaseAuth.currentUser?.email}-${Get.find<ProductController>().rentalModel?.rentalName}')
          .collection('messages')
          .orderBy('date', descending: false)
          .snapshots();
    }
    debugPrint('$activeChat-${myRental?.rentalName}');
    return _firebaseFirestore
        .collection('room-message')
        .doc('$activeChat-${myRental?.rentalName}')
        .collection('messages')
        .orderBy('date', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot>? getRoom() {
    getRental();
    // if (myRental?.rentalName != null) {
      return _firebaseFirestore
          .collection('room-message')
          .where(
            'rentalName',
            isEqualTo: myRental?.rentalName,
          )
          .snapshots();
    // }
    // return null;
  }

  Future<void> getRental() async {
    try {
      var response = await _firebaseFirestore
          .collection('rental')
          .doc(_firebaseAuth.currentUser?.email)
          .get();

      var jsonData = json.encode(response.data());
      myRental = RentalModel.fromJson(json.decode(jsonData));
      print(myRental?.rentalName);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> sendMessage() async {
    try {
      if (userMode == ChatMode.USER) {
        await _firebaseFirestore
            .collection('room-message')
            .doc(
                '${_firebaseAuth.currentUser?.email}-${Get.find<ProductController>().rentalModel?.rentalName}')
            .collection('messages')
            .doc()
            .set(message);

        await _firebaseFirestore
            .collection('room-message')
            .doc(
                '${_firebaseAuth.currentUser?.email}-${Get.find<ProductController>().rentalModel?.rentalName}')
            .set({
          'userName': _firebaseAuth.currentUser?.email,
          'rentalName': Get.find<ProductController>().rentalModel?.rentalName,
        });
      } else if (userMode == ChatMode.RENTAL) {
        await _firebaseFirestore
            .collection('room-message')
            .doc('$activeChat-${myRental?.rentalName}')
            .collection('messages')
            .doc()
            .set(message);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
