import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/rental/controller/rental.controller.dart';
import 'package:get/get.dart';

class EditShop extends StatefulWidget {
  const EditShop({super.key});

  @override
  State<EditShop> createState() => _EditShopState();
}

class _EditShopState extends State<EditShop> {
  var controller = Get.find<RentalController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController rentalNameController = TextEditingController();
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
      titleName: 'ตั้งค่าร้านให้เช่า',
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
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
                      // Expanded(
                      //   child: Container(
                      //     height: 100,
                      //     margin: const EdgeInsets.all(24),
                      //     color: ColorConstants.COLOR_GREEN,
                      //     child: const Center(
                      //       child: Icon(Icons.add),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomTextFormField(
                    label: 'ที่อยู่ในการเข้ารับสินค้า',
                    showBorder: true,
                    controller: rentalAddressController,
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          color: ColorConstants.COLOR_GREY,
                          text: 'ยกเลิก',
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          text: 'ยืนยัน',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              bool? result = await controller.updateRentalShop(
                                rentalAddress: rentalAddressController.text,
                                rentalName: rentalNameController.text,
                                rentalPhone: rentalPhoneController.text,
                              );

                              if (result == true && mounted) return Get.back();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
