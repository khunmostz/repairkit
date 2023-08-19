import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                  '${FirebaseAuth.instance.currentUser?.uid}${num}${Get.find<CartController>().cartList?[i].productName}')
              .set({
            "uid": FirebaseAuth.instance.currentUser?.uid,
            "docId":
                '${FirebaseAuth.instance.currentUser?.uid}${num}${Get.find<CartController>().cartList?[i].productName}',
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
          _firebaseFirestore
              .collection('order-product')
              .doc(
                  '${FirebaseAuth.instance.currentUser?.uid}${num}${Get.find<CartController>().cartList?[i].productName}')
              .set({
            "uid": FirebaseAuth.instance.currentUser?.uid,
            "docId":
                '${FirebaseAuth.instance.currentUser?.uid}${num}${Get.find<CartController>().cartList?[i].productName}',
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
                  '${FirebaseAuth.instance.currentUser?.uid}${num}${Get.find<CartController>().cartList?[i].productName}')
              .set({
            "uid": FirebaseAuth.instance.currentUser?.uid,
            "docId":
                '${FirebaseAuth.instance.currentUser?.uid}${num}${Get.find<CartController>().cartList?[i].productName}',
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
}
