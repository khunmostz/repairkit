import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/services/base/api_constant.dart';
import 'package:flutter_boilerplate/base/services/base/api_endpoint.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String token = '';
  void setOmiseToken(String value) {
    token = value;
  }

  Future<bool> buyProduct() async {
    Random random = Random();

    try {
      if (Get.find<CartController>().cartList != null) {
        for (var i = 0; i < Get.find<CartController>().cartList!.length; i++) {
          var num = random.nextInt(9999);
          _firebaseFirestore
              .collection('receive-product')
              .doc(
                  '${FirebaseAuth.instance.currentUser?.uid}$num${Get.find<CartController>().cartList?[i].productName}')
              .set({
            "uid": FirebaseAuth.instance.currentUser?.uid,
            "docId":
                '${FirebaseAuth.instance.currentUser?.uid}$num${Get.find<CartController>().cartList?[i].productName}',
            "product": Get.find<CartController>().cartList?[i].productName,
            "productImage":
                Get.find<CartController>().cartList?[i].productImage,
            "rentDay": Get.find<CartController>().cartList?[i].dayOfRent,
            "productAmount":
                Get.find<CartController>().cartList?[i].productAmout,
            "trackingProduct":
                Get.find<CartController>().cartList?[i].trackingProduct,
            "trackingCompany":
                Get.find<CartController>().cartList?[i].trackingCompany,
            "acceptItem": Get.find<CartController>().cartList?[i].acceptItem,
            "rentalName": Get.find<CartController>().cartList?[i].rentalName,
            "eachPrice": Get.find<CartController>().cartList?[i].productPrice,
            "createdAt": DateTime.now().millisecondsSinceEpoch,
          });

          await sendNotificationFcm(
              isEqualTo: Get.find<CartController>().cartList?[i].rentalName);
          _firebaseFirestore
              .collection('order-product')
              .doc(
                  '${FirebaseAuth.instance.currentUser?.uid}$num${Get.find<CartController>().cartList?[i].productName}')
              .set({
            "uid": FirebaseAuth.instance.currentUser?.uid,
            "docId":
                '${FirebaseAuth.instance.currentUser?.uid}$num${Get.find<CartController>().cartList?[i].productName}',
            "product": Get.find<CartController>().cartList?[i].productName,
            "productImage":
                Get.find<CartController>().cartList?[i].productImage,
            "rentDay": Get.find<CartController>().cartList?[i].dayOfRent,
            "productAmount":
                Get.find<CartController>().cartList?[i].productAmout,
            "eachPrice": Get.find<CartController>().cartList?[i].productPrice,
            "trackingProduct":
                Get.find<CartController>().cartList?[i].trackingProduct,
            "trackingCompany":
                Get.find<CartController>().cartList?[i].trackingCompany,
            "acceptItem": Get.find<CartController>().cartList?[i].acceptItem,
            "rentalName": Get.find<CartController>().cartList?[i].rentalName,
            "createdAt": DateTime.now().millisecondsSinceEpoch,
          });
          _firebaseFirestore
              .collection('history')
              .doc(
                  '${FirebaseAuth.instance.currentUser?.uid}$num${Get.find<CartController>().cartList?[i].productName}')
              .set({
            "uid": FirebaseAuth.instance.currentUser?.uid,
            "docId":
                '${FirebaseAuth.instance.currentUser?.uid}$num${Get.find<CartController>().cartList?[i].productName}',
            "product": Get.find<CartController>().cartList?[i].productName,
            "productImage":
                Get.find<CartController>().cartList?[i].productImage,
            "rentDay": Get.find<CartController>().cartList?[i].dayOfRent,
            "productAmount":
                Get.find<CartController>().cartList?[i].productAmout,
            "trackingProduct":
                Get.find<CartController>().cartList?[i].trackingProduct,
            "eachPrice": Get.find<CartController>().cartList?[i].productPrice,
            "trackingCompany":
                Get.find<CartController>().cartList?[i].trackingCompany,
            "acceptItem": Get.find<CartController>().cartList?[i].acceptItem,
            "rentalName": Get.find<CartController>().cartList?[i].rentalName,
            "createdAt": DateTime.now().millisecondsSinceEpoch,
          });
        }
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<Map<String, dynamic>?> getRental({String? isEqualTo}) async {
    try {
      var response = await _firebaseFirestore
          .collection('rental')
          .where("rentalName", isEqualTo: isEqualTo)
          .get();

      // var jsonData = json.encode(response);
      // RentalModel? res = RentalModel.fromJson(json.decode(jsonData));

      debugPrint('${response.docs[0].data()}');

      return response.docs[0].data();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> sendNotificationFcm({String? message, String? isEqualTo}) async {
    final dio = Dio();

    Map<String, dynamic>? rental = await getRental(isEqualTo: isEqualTo);

    var responseUsers = await _firebaseFirestore
        .collection('users')
        .doc(rental?['userId'])
        .get();
    Map<String, dynamic> data = {
      "to": responseUsers["fcmToken"],
      // "to": "d5YVOGEPTHau45kH7qyZao:APA91bFobp8Xz0LV-thmE0DbbijipRZLKPfrqWW0iKPJwN310OdlCRZBRJPYqok6fJyXVODc6U9ADjFAkXwsktAHiDRI2jCxBDTAIRWRNvcTF-Db-4HOJ1GTJ7BhDKZ7nWjPpee0vP2N",
      "notification": {
        "title": "แจ้งเตือนออเดอร์",
        "body": "มีคนสั่งออเดอร์เข้ามา",
      }
    };
    var response = await dio.post(
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
    debugPrint(response.toString());
  }
}
