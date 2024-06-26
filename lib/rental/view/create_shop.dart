import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/rental/controller/rental.controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateShop extends StatefulWidget {
  const CreateShop({super.key});

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  List<Map<String, dynamic>> cameraList = [
    {
      'name': "camera",
      'title': "กล้อง",
      'icon': const Icon(Icons.camera),
    },
    {
      'name': "gallery",
      'title': "แกลลอรี่",
      'icon': const Icon(Icons.image),
    },
  ];

  var controller = Get.find<RentalController>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController rentalNameController = TextEditingController();
  TextEditingController identificationController = TextEditingController();
  TextEditingController rentalAddressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController rentalPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      onBackPress: () {
        Get.back();
      },
      titleName: 'สร้างร้านให้เช่า',
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: GetBuilder<RentalController>(builder: (_) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            label: 'ชื่อร้านค้า',
                            showBorder: true,
                            controller: rentalNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "this field is required".tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              openModalCamera(context);
                            },
                            child: Container(
                              height: 100,
                              margin: const EdgeInsets.all(24),
                              color: ColorConstants.COLOR_GREEN,
                              child: controller.imageRental == null
                                  ? const Center(
                                      child: Icon(Icons.add),
                                    )
                                  : Image.file(
                                      controller.imageRental ?? File(''),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        const Expanded(
                          child: CustomTextFormField(
                            label: 'เพิ่มรูปถ่าย บัตรประจำตัวประชาชน',
                            showBorder: true,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              openModalCamera(context, isIdentification: true);
                            },
                            child: Container(
                              height: 100,
                              margin: const EdgeInsets.all(24),
                              color: ColorConstants.COLOR_GREEN,
                              child: controller.imageIdentification == null
                                  ? const Center(
                                      child: Icon(Icons.add),
                                    )
                                  : Image.file(
                                      controller.imageIdentification ??
                                          File(''),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomTextFormField(
                      label: 'ที่อยู่ในการเข้ารับสินค้า',
                      showBorder: true,
                      controller: rentalAddressController,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomTextFormField(
                      label: 'อีเมลล์',
                      showBorder: true,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomTextFormField(
                      label: 'หมายเลขโทรศัพท์',
                      showBorder: true,
                      controller: rentalPhoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                color: Colors.grey,
                onTap: () {
                  Get.back();
                },
                text: 'ยกเลิก',
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomButton(
                text: 'ยืนยัน',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    bool? result = await controller.createRentalShop(
                      rentalAddress: rentalAddressController.text,
                      rentalName: rentalNameController.text,
                      rentalPhone: rentalPhoneController.text,
                    );

                    if (result != false && mounted) {
                      Get.back();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> openModalCamera(BuildContext context,
      {bool? isIdentification}) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: cameraList
                .map((e) => InkWell(
                      onTap: () async {
                        if (isIdentification == true) {
                          switch (e['name']) {
                            case 'camera':
                              bool? result =
                                  await controller.selectImageIdentification(
                                      imageSource: ImageSource.camera);
                              if (result == true && mounted) Get.back();
                              break;
                            case 'gallery':
                              controller.selectImageIdentification(
                                  imageSource: ImageSource.gallery);
                              break;
                            default:
                          }
                        } else {
                          switch (e['name']) {
                            case 'camera':
                              bool? result = await controller.selectImageRental(
                                  imageSource: ImageSource.camera);
                              if (result == true && mounted) Get.back();
                              break;
                            case 'gallery':
                              bool? result = await controller.selectImageRental(
                                  imageSource: ImageSource.gallery);
                              if (result == true && mounted) Get.back();
                              break;
                            default:
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            e['icon'],
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(e['title']),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
