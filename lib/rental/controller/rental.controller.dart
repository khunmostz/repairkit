import 'dart:io';
import 'dart:math';

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

  File? imageReciept;
  String? imageRecieptUrl;

  String? categoryInit = ProductType.DRILL;

  String? selectedTab = 'ที่ต้องได้รับ';
  List<String>? tab = ['ที่ต้องได้รับ', 'จัดส่งแล้ว'];

  Map<String, dynamic>? userData;

  List<Map<String, dynamic>>? returnProductData = [];
  List<Map<String, dynamic>>? orderData = [];

  Map<String, dynamic>? userReceiveData;
  void setActiveUserReceiveData(Map<String, dynamic>? active) {
    userReceiveData = active;
  }

  Map<String, dynamic>? activeOrderData = {};
  void setActiveOrderData(Map<String, dynamic>? active) {
    activeOrderData = active;
  }

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

  void setSelectTab(String? value) {
    selectedTab = value;
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
            // isEqualTo: 1,
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
    Random random = Random();
    var num = random.nextInt(9999);

    try {
      await FirebaseFirestore.instance.collection('product').doc("$num").set({
        "docId": num,
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
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: imageSource,
        imageQuality: 100,
        maxHeight: 250,
        maxWidth: 250,
      );
      if (pickedImage != null) {
        final Rx<File> imagePath = File(pickedImage.path).obs;
        imageProduct = imagePath.value;
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
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: imageSource,
        imageQuality: 100,
        maxHeight: 250,
        maxWidth: 250,
      );
      if (pickedImage != null) {
        final Rx<File> imagePath = File(pickedImage.path).obs;
        imageRental = imagePath.value;
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
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: imageSource,
        imageQuality: 100,
        maxHeight: 250,
        maxWidth: 250,
      );
      if (pickedImage != null) {
        final Rx<File> imagePath = File(pickedImage.path).obs;
        imageIdentification = imagePath.value;
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
    var firebaseRef = FirebaseStorage.instance
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
    var firebaseRef = FirebaseStorage.instance
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

  Future<void> getHistory({bool? isReceive}) async {
    returnProductData = [];
    try {
      var response = await FirebaseFirestore.instance
          .collection('history')
          .where(
            'rentalName',
            isEqualTo: userData?['rentalName'],
          )
          // .where('isReceive', isEqualTo: isReceive)
          .get();

      for (var element in response.docs) {
        print(element.data());
        returnProductData?.add(element.data());
      }

      update();

      print(returnProductData);
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> getReturnProduct({bool? isReceive}) async {
    returnProductData = [];
    try {
      var response = await FirebaseFirestore.instance
          .collection('return-product')
          .where(
            'rentName',
            isEqualTo: userData?['rentalName'],
          )
          .where('isReceive', isEqualTo: false)
          .get();

      for (var element in response.docs) {
        print(element.data());
        returnProductData?.add(element.data());
      }

      update();

      print(returnProductData);
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> getOrderRental() async {
    orderData = [];

    try {
      var response = await FirebaseFirestore.instance
          .collection('order-product')
          .where(
            'rentalName',
            isEqualTo: userData?['rentalName'],
          )
          .get();

      for (var element in response.docs) {
        // var uuid = const Uuid();
        Map<String, dynamic> data = {...element.data()};
        orderData?.add(data);
      }

      print(orderData);
      update();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> accepthItem({String? docId}) async {
    // print(receiveProductModel?.docId);
    try {
      // receiveProductModel?.acceptItem?[index ?? 0] = true;
      var response = await FirebaseFirestore.instance
          .collection('return-product')
          .doc(docId)
          .update({
        "isReceive": true,
      });

      getReturnProduct(isReceive: false);
      // getReturnProduct();
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteReturnProduct({String? docId}) async {
    // print(receiveProductModel?.docId);
    try {
      // receiveProductModel?.acceptItem?[index ?? 0] = true;
      var response = await FirebaseFirestore.instance
          .collection('return-product')
          .doc(docId)
          .delete();

      getReturnProduct(isReceive: true);
      // getReturnProduct();
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool?> selectImageReceipt({required ImageSource imageSource}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(
        source: imageSource,
        imageQuality: 100,
        maxHeight: 250,
        maxWidth: 250,
      );
      if (pickedImage != null) {
        final Rx<File> imagePath = File(pickedImage.path).obs;
        imageReciept = imagePath.value;
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
    var firebaseRef = FirebaseStorage.instance
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

  Future<void> getUserDataByUid() async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: activeOrderData?['uid'])
          .get();
      setActiveUserReceiveData(user.docs[0].data());
      print(userReceiveData);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool?> updateTrackingProduct(
      {String? trackingCompany, String? trackingProduct}) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('receive-product')
          .doc(activeOrderData?['docId'])
          .update({
        "trackingCompany": trackingCompany,
        "trackingProduct": trackingProduct
      });

      var responseHistory = await FirebaseFirestore.instance
          .collection('history')
          .doc(activeOrderData?['docId'])
          .update({
        "trackingCompany": trackingCompany,
        "trackingProduct": trackingProduct
      });

      update();

      deleteOrderById();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> deleteOrderById() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('order-product')
          .doc(activeOrderData?['docId'])
          .delete();

      getOrderRental();
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
