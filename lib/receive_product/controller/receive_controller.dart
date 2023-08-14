import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/product/model/rental.model.dart';
import 'package:flutter_boilerplate/receive_product/model/receive_product_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReceviceController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<ReceiveProductModel>? receiveProductModel = [];

  String? deliveryCompanyInit;
  List<String> deliveryCompany = ["Kerry", "EMS", "Flash"];

  File? imageReciept;
  String? imageRecieptUrl;

  ReceiveProductModel? activeReceiveProduct;
  void setActiveReceiveProduct(ReceiveProductModel? active) {
    activeReceiveProduct = active;
  }

  RentalModel? rentalModel;
  void setRentalModel(RentalModel? res) {
    rentalModel = res;
  }

  String? selectedTab = 'รับสินค้า';
  void setSelectTab(String? value) {
    selectedTab = value;
    update();
  }

  List<String>? tab = ['รับสินค้า', 'ส่งสินค้าคืน'];

  @override
  void onInit() {
    super.onInit();
    
  }

  Future<void> getRentalByName() async {
    try {
      var response = await _firebaseFirestore
          .collection('rental')
          .where(
            'rentalName',
            isEqualTo: activeReceiveProduct?.rentalName,
          )
          .get();

      String data = json.encode(response.docs[0].data());
      setRentalModel(RentalModel.fromJson(json.decode(data)));
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
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

  Future<bool?> addReturnProduct({
    String? docId,
    String? product,
    String? productAmount,
    String? productImage,
    String? rentDay,
    String? rentName,
    String? trackingCompany,
    String? deliveryCompany,
  }) async {
    print(docId);

    try {
      var response =
          await _firebaseFirestore.collection('return-product').doc(docId).set({
        "docId": docId,
        "product": product,
        "productAmount": productAmount,
        "productImage": productImage,
        "rentDay": rentDay,
        "rentName": rentName,
        "imageRecieptUrl": imageRecieptUrl,
        "trackingCompany": trackingCompany,
        "deliveryCompany": deliveryCompany,
        "isReceive": false,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      });

      await deleteReturnProduct(docId);

      return true;
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<bool?> deleteReturnProduct(String? docId) async {
    try {
      var response = await _firebaseFirestore
          .collection('receive-product')
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<bool?> selectImageReceipt({required ImageSource imageSource}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? _pickedImage = await _picker.pickImage(
        source: imageSource,
        imageQuality: 100,
        maxHeight: 250,
        maxWidth: 250,
      );
      if (_pickedImage != null) {
        final Rx<File> _imagePath = File(_pickedImage.path).obs;
        imageReciept = _imagePath.value;
        update();
        uploadReceiptImage(imageReciept!.path);

        return true;
      }

      return false;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<void> uploadReceiptImage(String imagePath) async {
    var firebaseRef = await FirebaseStorage.instance
        .ref()
        .child('receipt-image/${imagePath.split('/').last}');
    var uploadTask = firebaseRef.putFile(imageReciept!);
    var taskSnapshot = await uploadTask.whenComplete(() async {
      debugPrint('upload receipt success');
    }).then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      imageRecieptUrl = imageUrl;
    });
  }
}
