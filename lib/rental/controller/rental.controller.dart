import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/product/model/product.model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RentalController extends GetxController {
  bool? haveRental;

  File? imageRental;
  File? imageIdentification;
  File? imageProduct;

  String? imageRentalUrl;
  String? imageIdentificationUrl;
  String? imageProductUrl;

  String? categoryInit = ProductType.DRILL;

  Map<String, dynamic>? userData;

  List<ProductModel>? product = [];

  List<Map<String, String>> categoryList = [
    {
      'name': ProductType.DRILL,
      'image': 'assets/icons/drill.png',
    },
    {
      'name': ProductType.HAMMER,
      'image': 'assets/icons/hammer.png',
    },
    {
      'name': ProductType.SAW,
      'image': 'assets/icons/hand-saw.png',
    },
    {
      'name': ProductType.PLANER,
      'image': 'assets/icons/planer.png',
    },
    {
      'name': ProductType.PLIERS_TOOL,
      'image': 'assets/icons/pliers-tool.png',
    },
    {
      'name': ProductType.SCREWDRIVER,
      'image': 'assets/icons/screwdriver.png',
    },
    {
      'name': ProductType.TAPE,
      'image': 'assets/icons/tape.png',
    },
    {
      'name': ProductType.EQUIPMENT,
      'image': 'assets/icons/equipment.png',
    },
  ];

  @override
  void onInit() async {
    super.onInit();
    clear();
    await getUserData();
  }

  clear() {
    imageRental = null;
    imageIdentification = null;
    imageProduct = null;
    imageRentalUrl = null;
    imageIdentificationUrl = null;
    imageProductUrl = null;
    userData = null;
    // categoryInit = null;
  }

  String? capitalize(String? s) {
    if (s == null) return null;
    if (s.isEmpty) return null;
    if (s.length == 1) return s[0].toUpperCase();
    return s[0].toUpperCase() + s.substring(1);
  }

  onCategoryDropdown(String? value) {
    categoryInit = value;
    update();
  }

  Future<void> getUserData() async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .get();
      if (user.data()?['status'] == false) {
        haveRental = false;
      } else {
        haveRental = true;
        getRentalData();
        getProductRental();
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getRentalData() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('rental')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .get();

      userData = response.data();

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getProductRental() async {
    product?.clear();
    try {
      var response = await FirebaseFirestore.instance
          .collection('product')
          .where(
            "rentalId",
            isEqualTo: FirebaseAuth.instance.currentUser?.uid,
          )
          .get();

      for (var element in response.docs) {
        Map<String, dynamic> data = element.data();
        debugPrint(data['productName']);

        // convert timestamp to date time
        Timestamp timestamp = data['productTime'];
        DateTime date = timestamp.toDate();

        print(data['productImage']);

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
      }

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool?> createRentalShop({
    String? rentalAddress,
    String? rentalName,
    String? rentalPhone,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('rental')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .set({
        "rentalId": FirebaseAuth.instance.currentUser?.uid,
        "rentalAddress": rentalAddress,
        "rentalImage": imageRentalUrl,
        "rentalName": rentalName,
        "rentalPhone": rentalPhone,
        "userId": FirebaseAuth.instance.currentUser?.email,
        "identificationImage": imageIdentificationUrl
      });

      updateStatusUsers(status: true);
      getUserData();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool?> updateRentalShop({
    String? rentalAddress,
    String? rentalName,
    String? rentalPhone,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('rental')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({
        "rentalAddress": rentalAddress,
        "rentalName": rentalName,
        "rentalPhone": rentalPhone,
      });

      getUserData();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool?> createProduct(
      {String? productName,
      String? productInfo,
      int? productAmount,
      String? productPrice}) async {
    try {
      await FirebaseFirestore.instance.collection('product').add({
        "rentalId": userData?["rentalId"],
        "productImage": imageProductUrl,
        "productName": productName,
        "productCategory": categoryInit,
        "productInfo": productInfo,
        "productPrice": int.parse(productPrice ?? '0'),
        "productAmount": productAmount,
        "rating": 5,
        "productTime": DateTime.now(),
      });

      getProductRental();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> updateStatusUsers({bool? status}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({"status": status});
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool?> selectImageProduct({required ImageSource imageSource}) async {
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
        imageProduct = _imagePath.value;
        update();
        uploadProductImage(imageProduct!.path);

        return true;
      }

      return false;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<bool?> selectImageRental({required ImageSource imageSource}) async {
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
        imageRental = _imagePath.value;
        update();
        uploadRentalImage(imageRental!.path);

        return true;
      }

      return false;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<bool?> selectImageIdentification(
      {required ImageSource imageSource}) async {
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
        imageIdentification = _imagePath.value;
        update();
        uploadIdentificationImage(imageIdentification!.path);
        return true;
      }

      return false;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> uploadProductImage(
    String imagePath,
  ) async {
    try {
      var firebaseRef = FirebaseStorage.instance
          .ref()
          .child('product-image/${imagePath.split('/').last}');

      var uploadTask = firebaseRef.putFile(imageProduct!);
      var taskSnapshot = await uploadTask;

      var imageUrl = await taskSnapshot.ref.getDownloadURL();
      imageProductUrl = imageUrl;

      debugPrint('Upload product image success');
    } catch (error) {
      debugPrint('Error uploading product image: $error');
    }
  }

  Future<void> uploadRentalImage(String imagePath) async {
    var firebaseRef = await FirebaseStorage.instance
        .ref()
        .child('rental-image/${imagePath.split('/').last}');
    var uploadTask = firebaseRef.putFile(imageRental!);
    var taskSnapshot = await uploadTask.whenComplete(() async {
      debugPrint('upload rental success');
    }).then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      imageRentalUrl = imageUrl;
    });
  }

  Future<void> uploadIdentificationImage(String imagePath) async {
    var firebaseRef = await FirebaseStorage.instance
        .ref()
        .child('identification-image/${imagePath.split('/').last}');
    var uploadTask = firebaseRef.putFile(imageIdentification!);
    var taskSnapshot = await uploadTask.whenComplete(() async {
      debugPrint('upload identification success');
    }).then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      imageIdentificationUrl = imageUrl;
    });
  }
}
