import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/services/base/api_constant.dart';
import 'package:flutter_boilerplate/base/services/base/api_endpoint.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_boilerplate/product/model/rental.model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  RentalModel? myRental;

  String userMode = ChatMode.USER;

  String activeChat = '';

  String? sendFcm = '';
  String? roomId = '';
  void setRoomId(String? value) {
    roomId = value;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getRental();
    // getFcmFromChatRoom();
  }

  Map<String, dynamic> message = {
    'messageId': '',
    'sendBy': '',
    'message': '',
    'messageType': MessageType.TEXT,
    'createdAt': FieldValue.serverTimestamp(),
  };

  void setMessage(Map<String, dynamic> data) {
    message = {...message, ...data};
    update();
  }

  Future<void> sendNotificationFcm({String? message}) async {
    debugPrint(sendFcm);

    final dio = Dio();
    Map<String, dynamic> data = {
      "to": sendFcm,
      "notification": {
        "title": userMode == ChatMode.USER
            ? _firebaseAuth.currentUser?.email
            : myRental?.rentalName,
        "body": message,
      }
    };
    dynamic response;
    response = await dio.post(
      '${ApiConstants.fcmSend}${ApiEndPoints.postFcm}',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAAkT7Ikc:APA91bHESZ56FEiG0bbKiniUXTWuZ3EDRyfWWmO64Kp-It0PBw2Pya9T1ND5R-192wMOOoP2RNyau4tb4rcKObXdmQZyWHE1tKbJWTvh0oQ87_K8Pbq_kocQ4mWv26JGRPRbd82ifsYQ'
        },
      ),
    );
    debugPrint(response);
  }

  Stream<QuerySnapshot> getMessage() {
    if (userMode == ChatMode.USER) {
      // debugPrint(Get.find<ProductController>().rentalModel?.rentalName);
      getFcmFromChatRoom();
      return _firebaseFirestore
          .collection('room-message')
          .doc(
              '${_firebaseAuth.currentUser?.email}-${Get.find<ProductController>().rentalModel?.rentalName}')
          .collection('messages')
          .orderBy('createdAt', descending: false)
          .snapshots();
    }
    // debugPrint('$activeChat-${myRental?.rentalName}');
    getFcmFromChatRoom();
    return _firebaseFirestore
        .collection('room-message')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot>? getRoom() {
    //  await getRental();
    if (myRental?.rentalName != null) {
      debugPrint('con 1');
      update();
      return _firebaseFirestore
          .collection('room-message')
          .where(
            'rentalName',
            isEqualTo: myRental?.rentalName,
          )
          .snapshots();
    } else if (FirebaseAuth.instance.currentUser?.email != null) {
      debugPrint('con 2');
      update();
      return _firebaseFirestore
          .collection('room-message')
          .where(
            'userName',
            isEqualTo: FirebaseAuth.instance.currentUser?.email,
          )
          .snapshots();
    }
    debugPrint('not con');
    update();
    return null;
  }

  Future<void> getRental() async {
    try {
      var response = await _firebaseFirestore
          .collection('rental')
          .doc(_firebaseAuth.currentUser?.email)
          .get();

      var jsonData = json.encode(response.data());
      myRental = RentalModel.fromJson(json.decode(jsonData));
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getFcmFromChatRoom() async {
    try {
      // debugPrint(Get.find<ProductController>().rentalModel?.rentalName);
      if (userMode == ChatMode.USER) {
        var response = await _firebaseFirestore
            .collection('room-message')
            .doc(
                '${_firebaseAuth.currentUser?.email}-${Get.find<ProductController>().rentalModel?.rentalName}')
            .get();

        sendFcm = response.data()?['fcmRental'];
        roomId = response.data()?['roomId'];
      } else {
        var response = await _firebaseFirestore
            .collection('room-message')
            .doc('$activeChat-${myRental?.rentalName}')
            .get();

        sendFcm = response.data()?['fcmUser'];
        roomId = response.data()?['roomId'];
      }
      // debugPrint('sendFcm: $sendFcm');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> sendMessage({String? roomId}) async {
    try {
      if (userMode == ChatMode.USER) {
        if (sendFcm != '' && sendFcm != null) {
          sendNotificationFcm(message: message['message']);
        }

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
          'roomId':
              '${_firebaseAuth.currentUser?.email}-${Get.find<ProductController>().rentalModel?.rentalName}',
          'userName': _firebaseAuth.currentUser?.email,
          'fcmUser': await FirebaseMessaging.instance.getToken(),
          'rentalName': Get.find<ProductController>().rentalModel?.rentalName,
          'shopName':
              '${Get.find<ProductController>().rentalModel?.rentalName} (${_firebaseAuth.currentUser?.email})',
          'fcmRental': sendFcm != '' && sendFcm != null ? sendFcm : '',
        });
      } else if (userMode == ChatMode.RENTAL) {
        if (sendFcm != '' && sendFcm != null) {
          sendNotificationFcm(message: message['message']);
        }

        await _firebaseFirestore
            .collection('room-message')
            .doc(roomId)
            .collection('messages')
            .doc()
            .set(message);
        await _firebaseFirestore.collection('room-message').doc(roomId).update({
          'fcmRental': await FirebaseMessaging.instance.getToken(),
        });
      }

      print(sendFcm);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
