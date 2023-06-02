import "package:flash/flash.dart";
import "package:flash/flash_helper.dart";
import "package:flutter/material.dart";
import "package:flutter_boilerplate/base/utils/constants/color.dart";
import "package:flutter_boilerplate/base/utils/constants/size.dart";
import "package:flutter_boilerplate/base/widget/custom_button.dart";
import "package:flutter_boilerplate/base/widget/custom_textformfield.dart";
import "package:flutter_boilerplate/signin/view/controller/signin.controller.dart";
import "package:get/get.dart";

class SignIn extends GetView<SignInController> {
  SignIn({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: ColorConstants.COLOR_BLUE_1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 188,
                    height: 188,
                    margin: const EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        image: const DecorationImage(
                          image: AssetImage('assets/logo/rent-a-repair-kit.png'),
                        )),
                  ),
                  CustomTextFormField(
                    label: 'email'.tr,
                    controller: _emailController,
                  ),
                  CustomTextFormField(
                    label: 'password'.tr,
                    controller: _passwordController,
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
                      controller.signIn(context,email: _emailController.text,password: _passwordController.text);
                      context.showFlash(
                        duration: const Duration(seconds: 3),
                        builder: (context, controller) => Flash(
                          controller: controller,
                          position: FlashPosition.bottom,
                          dismissDirections: const [
                            FlashDismissDirection.startToEnd
                          ],
                          child: SafeArea(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Material(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    width: size.width,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: ColorConstants.COLOR_GREEN,
                                        borderRadius: BorderRadius.circular(50)),
                                    child: SafeArea(
                                      child: Row(
                                        children: const [
                                          Icon(Icons.person),
                                          Expanded(
                                              child: Text(
                                            'Login Success.',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
