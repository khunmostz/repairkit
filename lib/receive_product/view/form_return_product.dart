import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/receive_product/controller/receive_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FormReturnProduct extends StatefulWidget {
  const FormReturnProduct({super.key});

  @override
  State<FormReturnProduct> createState() => _FormReturnProductState();
}

class _FormReturnProductState extends State<FormReturnProduct> {
  ReceviceController controller = Get.find<ReceviceController>();

  var deliveryController = TextEditingController();
  var codeDeliveryController = TextEditingController();

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
  @override
  void initState() {
    super.initState();
    controller.imageReciept = null;
    controller.imageRecieptUrl = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getRentalByName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'ส่งสินค้าคืน',
      onBackPress: () {
        Get.back();
      },
      body: SizedBox(
        width: size.width,
        child: GetBuilder<ReceviceController>(builder: (_) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'ข้อมุลผู้รับสินค้า',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                labelRow(
                    title: 'ร้าน',
                    value: controller.activeReceiveProduct?.rentalName),
                labelRow(
                    title: 'ที่อยู่',
                    value: controller.rentalModel?.rentalAddress),
                labelRow(
                    title: 'โทรศัพท์',
                    value: controller.rentalModel?.rentalPhone),
                labelRowTextField(
                    title: 'ขนส่ง', controller: deliveryController),
                labelRowTextField(
                    title: 'กรอกรหัสพัสดุ', controller: codeDeliveryController),
                InkWell(
                  onTap: () {
                    openModalCamera(context);
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.all(24),
                    color: Colors.green,
                    child: controller.imageReciept == null
                        ? const Center(
                            child: Icon(Icons.add),
                          )
                        : Image.file(
                            controller.imageReciept ??
                                File(
                                  '',
                                ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const Text('อัพโหลดสลิปการส่งพัสดุ'),
                Padding(
                  padding: const EdgeInsets.all(24),
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
                          onTap: () async {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<dynamic> openModalCamera(BuildContext context) {
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
                            bool? result = await controller.selectImageReceipt(
                                imageSource: ImageSource.camera);
                            if (result == true && mounted) Get.back();
                            break;
                          case 'gallery':
                            bool? result = await controller.selectImageReceipt(
                                imageSource: ImageSource.gallery);
                            if (result == true && mounted) Get.back();
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

  Widget labelRow({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 12),
            child: Text(title ?? ''),
          ),
          Expanded(child: Text(value ?? '')),
        ],
      ),
    );
  }

  Widget labelRowTextField({String? title, TextEditingController? controller}) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 12, bottom: 24),
            child: Text(title ?? ''),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: CustomTextFormField(
              showBorder: true,
              isDense: true,
              controller: controller,
            ),
          ),
        ),
      ],
    );
  }
}
