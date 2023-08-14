import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/rental/controller/rental.controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RequestOrder extends StatefulWidget {
  const RequestOrder({super.key});

  @override
  State<RequestOrder> createState() => _RequestOrderState();
}

class _RequestOrderState extends State<RequestOrder> {
  RentalController controller = Get.find<RentalController>();

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserDataByUid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'คำขอออเดอร์',
      onBackPress: () {
        Get.back();
      },
      body: SizedBox(
        width: size.width,
        child: GetBuilder<RentalController>(builder: (_) {
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
                Container(
                  width: 200,
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.network(
                      controller.activeOrderData?['productImage']),
                ),
                labelRow(
                  title: 'ชื่อ',
                  value: controller.userReceiveData?['name'],
                ),
                labelRow(
                  title: 'ที่อยู่',
                  value: controller.userReceiveData?['address'],
                ),
                labelRow(
                  title: 'โทรศัพท์',
                  value: controller.userReceiveData?['phone'],
                ),
                labelRow(
                  title: 'ชื่อสินค้า',
                  value: controller.activeOrderData?['product'],
                ),
                labelRow(
                  title: 'จำนวนสินค้า',
                  value: controller.activeOrderData?['productAmount'],
                ),
                labelRowTextField(
                    title: 'ขนส่ง', controller: deliveryController),
                labelRowTextField(
                  title: 'กรอกรหัสพัสดุ',
                  controller: codeDeliveryController,
                ),
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
                          onTap: () async {
                            bool? result =
                                await controller.updateTrackingProduct(
                              trackingCompany: codeDeliveryController.text,
                              trackingProduct: deliveryController.text,
                            );

                            if (result == true && mounted) {
                              // controller.getReturnProduct();
                              Get.back();
                            }
                          },
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
