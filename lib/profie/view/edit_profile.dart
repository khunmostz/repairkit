import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/profie/controller/profile.controller.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var controller = Get.find<ProfileController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = controller.dataProfile['name'];
    addressController.text = controller.dataProfile['address'];
    phoneController.text = controller.dataProfile['phone'];
    emailController.text = FirebaseAuth.instance.currentUser?.email ?? "";
    return BaseScaffold(
      showCart: false,
      onBackPress: () {
        Get.back();
      },
      titleName: 'ตั้งค่าบัญชี',
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
                  child: CustomTextFormField(
                    label: 'ชื่อ',
                    showBorder: true,
                    controller: nameController,
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
                    label: 'ที่อยู่',
                    showBorder: true,
                    controller: addressController,
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
                    readOnly: true,
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
                    controller: phoneController,
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
                              bool? result = await controller.updateProfile(
                                  name: nameController.text,
                                  address: addressController.text,
                                  phone: phoneController.text);

                              if (result == true && mounted) {
                                controller.getProfile();
                                Get.back();
                              }
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
