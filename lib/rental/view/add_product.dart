import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/rental/controller/rental.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var controller = Get.find<RentalController>();

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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productAmountController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'Add Product',
      onBackPress: () {
        Navigator.pop(context);
      },
      body: SingleChildScrollView(
        child: GetBuilder<RentalController>(builder: (_) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    openModalCamera(context);
                  },
                  child: Container(
                    width: size.width,
                    height: 300.h,
                    margin: const EdgeInsets.all(24),
                    color: ColorConstants.COLOR_GREEN,
                    child: controller.imageProduct == null
                        ? const Center(
                            child: Icon(Icons.add),
                          )
                        : Image.file(
                            controller.imageProduct ?? File(''),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                      DropdownButton(
                        value: controller.categoryInit,
                        hint: const Text('Type'),
                        items: controller.categoryList
                            .map(
                              (e) => DropdownMenuItem(
                                value: e['name'],
                                child: Text(e['name'] ?? ''),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          controller.onCategoryDropdown(value ?? '');
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomTextFormField(
                    label: 'Product name',
                    showBorder: true,
                    controller: productNameController,
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
                    label: 'Product amount',
                    showBorder: true,
                    controller: productAmountController,
                    keyboardType: TextInputType.number,
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
                    label: 'Product price',
                    showBorder: true,
                    controller: productPriceController,
                    keyboardType: TextInputType.number,
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
                    label: 'Product description',
                    showBorder: true,
                    controller: productDescriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field is required".tr;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: CustomButton(
                    text: 'Create',
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        bool? result = await controller.createProduct(
                          productName: productNameController.text,
                          productInfo: productDescriptionController.text,
                          productAmount:
                              int.parse(productAmountController.text),
                          productPrice: productPriceController.text,
                        );

                        if (result == true && mounted) return Get.back();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }),
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
                        switch (e['name']) {
                          case 'camera':
                            bool? result = await controller.selectImageProduct(
                                imageSource: ImageSource.camera);
                            if (result == true && mounted) Get.back();
                            break;
                          case 'gallery':
                            controller.selectImageProduct(
                                imageSource: ImageSource.gallery);
                            break;
                          default:
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
