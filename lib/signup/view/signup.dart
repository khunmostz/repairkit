import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/signup/controller/signup.controller.dart';
import 'package:get/get.dart';

class SignUp extends GetView<SignUpController> {
  SignUp({super.key});
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _conpasswordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: size.height,
        color: ColorConstants.COLOR_BLUE_1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'signup'.tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.COLOR_ORANGE,
                        ),
                      ),
                    ),
                    CustomTextFormField(
                      label: 'name'.tr,
                      controller: _nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                      },
                    ),
                    CustomTextFormField(
                      label: 'phoneNum'.tr,
                      controller: _phoneController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                      },
                    ),
                    CustomTextFormField(
                      label: 'email'.tr,
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                      },
                    ),
                    CustomTextFormField(
                      label: 'password'.tr,
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                      },
                    ),
                    CustomTextFormField(
                      label: 'conPassword'.tr,
                      controller: _conpasswordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                        if (value != _passwordController.text) {
                          return "Passwords do not match".tr;
                        }
                      },
                    ),

                      CustomTextFormField(
                      label: 'address'.tr,
                      controller: _addressController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                       
                      },
                    ),
                    Center(
                      child: CustomButton(
                        text: 'signup'.tr.toUpperCase(),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.signUp(
                              context,
                              name: _nameController.text,
                              phone: _phoneController.text,
                              address: _addressController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Center(
                        child: Text(
                          'By pressing signup you agree to our terms and conditions'
                              .tr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding:const  EdgeInsets.only(top: 24,bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            'Already have an account? '.tr,
                          ),
                          InkWell(
                            onTap: (){
                              Get.offNamed('/signIn');
                            },
                            child: Text(
                              'signin'.tr.toUpperCase(),
                              style: TextStyle(
                                fontSize: 13,
                                color: ColorConstants.COLOR_ORANGE,
                                fontWeight: FontWeight.w700,
                              ),
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
        ),
      ),
    );
  }
}
