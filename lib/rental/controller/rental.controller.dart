import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RentalController extends GetxController {
  bool? haveRental;

  File? imageRental;
  File? imageIdentification;

  String? imageRentalUrl;
  String? imageIdentificationUrl;

  @override
  void onInit() async {
    super.onInit();
    clear();
    await getUserData();
  }

  clear() {
    imageRental = null;
    imageIdentification = null;
    imageRentalUrl = null;
    imageIdentificationUrl = null;
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
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> createRentalShop({
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
        "rentalImage": '',
        "rentalName": rentalName,
        "rentalPhone": rentalPhone,
        "userId": FirebaseAuth.instance.currentUser?.email
      });

      // updateStatusUsers(status: true);
      // getUserData();
    } catch (e) {
      debugPrint(e.toString());
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
        return true;
      }

      return false;

      // uploadProfile(image!.path.toString());
    } catch (e) {
      print(e);
    }
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
        return true;
      }

      return false;

      // uploadProfile(image!.path.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadProfile(String imagePath, File image) async {
    var firebaseRef = await FirebaseStorage.instance
        .ref()
        .child('rental-image/${imagePath.split('/').last}');
    var uploadTask = firebaseRef.putFile(image);
    var taskSnapshot = await uploadTask.whenComplete(() async {
      print('upload profile success');
      // Get.snackbar('แ
      //จ้งเตือน', 'เปลี่ยนรูปภาพสำเร็จ');
    }).then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      // print(';djlksjfsalkfjklsdf: ${imageUrl.toString()}');
      // user['image'] = imageUrl;
    });
  }
}
