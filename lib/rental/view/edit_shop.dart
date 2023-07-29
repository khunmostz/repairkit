import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      onBackPress: () {
        Get.back();
      },
      titleName: 'สร้างร้านให้เช่า',
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                  children: [
                    const Expanded(
                      child: CustomTextFormField(
                        label: 'ชื่อร้านค้า',
                        showBorder: true,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.all(24),
                        color: ColorConstants.COLOR_GREEN,
                        child: const Center(
                          child: Icon(Icons.add),
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
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.all(24),
                        color: ColorConstants.COLOR_GREEN,
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextFormField(
                  label: 'ที่อยู่ในการเข้ารับสินค้า',
                  showBorder: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextFormField(
                  label: 'อีเมลล์',
                  showBorder: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextFormField(
                  label: 'หมายเลขโทรศัพท์',
                  showBorder: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: const [
                    Expanded(
                      child: CustomButton(
                        text: 'ยกเลิก',
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        text: 'ยืนยัน',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}