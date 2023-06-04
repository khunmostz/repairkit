import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/product/model/product.model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //#region variable product
  bool? isLoading = true;
  List<ProductModel>? product = [];
  //#endregion variable product

  //#region variable productDetail
  String? day = '1';
  List<String> dayRent = ['1','2','3','4','5','6','7'];
  //#endregion variable product


  @override
  void onInit() {
    super.onInit();
    getProductCategory();
  }

 //#region logic product
 Future<void> getProductCategory() async {
    try {
      var response = await _firebaseFirestore.collection('/product').get();
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

        debugPrint(product?[0].productName);

        if (product != null) {
          isLoading = false;
        }
      }

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  //#endregion logic product

 //#region logic product detail
 void onChangeDropdownDayRent(String? value){
  day = value;
  update();
 }
 //#endregion logic product detail
}
