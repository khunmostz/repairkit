import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/receive_product/model/receive_product_model.dart';
import 'package:get/get.dart';

class ReceviceController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<ReceiveProductModel>? receiveProductModel = [];

  String? selectedTab = 'Recevice Product';
  void setSelectTab(String? value){
    selectedTab = value;
    update();
  }

  List<String>?tab = ['Recevice Product','Return Product'];

  @override
  void onInit() {
    super.onInit();
    getReceivceProduct();
  }

  Future<void> getReceivceProduct() async {
    // receiveProductModel = [];
    try {
      var response = await _firebaseFirestore
          .collection('receive-product')
          .where(
            'uid',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid,
          )
          .where(
            "acceptItem",
            isEqualTo: false,
          )
          .get();
      print(response.docs.length);
      receiveProductModel?.clear();
      for (var receiveProduct in response.docs) {
        debugPrint(receiveProduct.data().toString());

        String jsonData = jsonEncode(receiveProduct.data());

        receiveProductModel
            ?.add(ReceiveProductModel.fromJson(json.decode(jsonData)));
      }

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getReturnProduct() async {
    // receiveProductModel = [];
    try {
      var response = await _firebaseFirestore
          .collection('receive-product')
          .where(
            'uid',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid,
          )
          .where(
            "acceptItem",
            isEqualTo: true,
          )
          .get();
      receiveProductModel?.clear();
      for (var receiveProduct in response.docs) {
        debugPrint(receiveProduct.data().toString());

        String jsonData = jsonEncode(receiveProduct.data());

        receiveProductModel
            ?.add(ReceiveProductModel.fromJson(json.decode(jsonData)));
      }

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> accepthItem({int? index}) async {
    // print(receiveProductModel?.docId);
    try {
      // receiveProductModel?.acceptItem?[index ?? 0] = true;
      var response = await _firebaseFirestore
          .collection('receive-product')
          .doc(receiveProductModel?[index ?? 0].docId)
          .update({
        "acceptItem": true,
      });

      getReceivceProduct();
      // getReturnProduct();
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
