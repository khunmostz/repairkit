import "package:flash/flash.dart";
import "package:flash/flash_helper.dart";
import "package:flutter/material.dart";
import "package:flutter_boilerplate/base/utils/constants/color.dart";
import "package:flutter_boilerplate/base/utils/constants/enum.dart";
import "package:flutter_boilerplate/base/utils/constants/size.dart";
import "package:flutter_boilerplate/base/widget/custom_button.dart";
import "package:flutter_boilerplate/base/widget/custom_textformfield.dart";
import "package:flutter_boilerplate/signin/view/controller/signin.controller.dart";
import "package:get/get.dart";

class SignIn extends GetView<SignInController> {
  SignIn({super.key});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: size.height,
        color: ColorConstants.COLOR_BLUE_1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Container(
                      width: 188,
                      height: 188,
                      margin: const EdgeInsets.only(bottom: 40, top: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/logo/rent-a-repair-kit.png'),
                          )),
                    ),
                    CustomTextFormField(
                      label: 'email'.tr,
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                        if (!GetUtils.isEmail(value)) {
                          return "Email is not valid";
                        }
                      },
                    ),
                    CustomTextFormField(
                      label: 'password'.tr,
                      controller: _passwordController,
                      maxLines: 1,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required".tr;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('forGotPassword'.tr),
                      ),
                    ),
                    // 'login'.tr.toUpperCase()
                    CustomButton(
                      text: 'login'.tr.toUpperCase(),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.signIn(context,
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?'.tr,
                          ),
                          InkWell(
                            onTap: () {
                              Get.offNamed('/signUp');
                            },
                            child: Text(
                              'signup'.tr,
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
