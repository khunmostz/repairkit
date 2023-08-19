import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/receive_product/model/receive_product_model.dart';
import 'package:get/get.dart';

class RentalCheckController extends GetxController {
  List<ReceiveProductModel>? receiveProductModel = [];
  String? day = '1';
  List<String> dayRent = ['1', '2', '3', '4', '5', '6', '7'];

  int? totalPrice = 0;
  void setTotalPrice(int price) {
    totalPrice = price;
  }

  //#region logic product detail
  void onChangeDropdownDayRent(String? value) {
    day = value;
    update();
  }

  void setDefaultAmount() {
    day = '1';
  }

  void calculateTotalPrice(int? price) {
    totalPrice = price;
    var totalDay = (totalPrice ?? 0) * int.parse(day ?? '0');
    // print(totalDay);
    totalPrice = totalDay;
    update();
  }

  Future<void> getReturnProduct() async {
    // receiveProductModel = [];
    try {
      var response = await FirebaseFirestore.instance
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

  Future<bool?> updateDayProduct({String? docId,String? date}) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('receive-product')
          .doc(docId)
          .update({"rentDay": date});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
