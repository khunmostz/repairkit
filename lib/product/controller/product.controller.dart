import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/home/controller/home.controller.dart';
import 'package:flutter_boilerplate/product/model/product.model.dart';
import 'package:flutter_boilerplate/product/model/rental.model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //#region variable product
  bool? isLoading = true;
  List<ProductModel>? product = [];
  dynamic rentalActive = 0;
  void setRentalActive(dynamic id) {
    rentalActive = id;
  }

  RentalModel? rentalModel;
  //#endregion variable product

  //#region variable productDetail
  String? day = '1';
  List<String> dayRent = ['1', '2', '3', '4', '5', '6', '7'];
  int? amount = 1;
  List<int> amountRent = [];
  void setAmountRent(int amountLength) {
    amountRent.clear();
    for (var i = 1; i < amountLength; i++) {
      amountRent.add(i);
    }
  }

  int? totalPrice = 0;
  void setTotalPrice(int price) {
    totalPrice = price;
  }
  //#endregion variable product

  @override
  void onInit() {
    super.onInit();
    getProductCategory();
  }

  //#region logic product
  Future<void> getProductCategory() async {
    if (Get.find<HomeController>().activeCategory != null) {
      try {
        var response = await _firebaseFirestore
            .collection('/product')
            .where('productCategory',
                isEqualTo: Get.find<HomeController>().activeCategory)
            .get();

        for (var element in response.docs) {
          Map<String, dynamic> data = element.data();
          debugPrint(data['productName']);

          // convert timestamp to date time
          Timestamp timestamp = data['productTime'];
          DateTime date = timestamp.toDate();
          product?.add(ProductModel(
            rentalId: data['rentalId'],
            productCategory: data['productCategory'],
            productName: data['productName'],
            productPrice: data['productPrice'],
            productAmount: data['productAmount'],
            productInfo: data['productInfo'],
            productDate: date,
            productImage: data['productImage'],
            rating: data['rating'],
          ));

          if (product != null) {
            isLoading = false;
          }
        }

        update();
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint('==== activeCategory has null ====');
    }
  }

  Future<void> getRentalById() async {
    try {
      var response = await _firebaseFirestore
          .collection('rental')
          .where('rentalId', isEqualTo: rentalActive)
          .get();
      for (var rental in response.docs) {
        var jsonData = json.encode(rental.data());
        rentalModel = RentalModel.fromJson(json.decode(jsonData));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //#endregion logic product

  //#region logic product detail
  void onChangeDropdownDayRent(String? value) {
    day = value;
    update();
  }

  void onChangeDropdownAmount(int? value) {
    amount = value;
    update();
  }

  void setDefaultAmount() {
    day = '1';
    amount = 1;
  }

  void calculateTotalPrice(int? price) {
    totalPrice = price;
    var totalDay = (totalPrice ?? 0) * int.parse(day ?? '0');
    // print(totalDay);
    totalPrice = totalDay * (amount ?? 0);
    update();
  }

  void searchProduct(String value) {
    if (value != "") {
      List<ProductModel> filter =
          product?.where((e) => e.productName!.startsWith(value)).toList() ??
              product ??
              [];
      product = filter;
      update();
    } else {
      product?.clear();
      getProductCategory();
    }
  }

  //#endregion logic product detail
}
