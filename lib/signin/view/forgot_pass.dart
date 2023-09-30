import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/signin/view/controller/signin.controller.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var controller = Get.find<SignInController>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.COLOR_BLUE_1,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            Container(
              width: 188,
              height: 188,
              margin: const EdgeInsets.only(bottom: 40, top: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  image: const DecorationImage(
                    image: AssetImage('assets/logo/rent-a-repair-kit.png'),
                  )),
            ),
            const Text(
              "Forgot password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.toNamed(RouteConstants.signIn);
                },
                child: const Text('Go to sign in'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: CustomButton(
                text: "SEND",
                onTap: () async {
                  bool? result = await controller.forgotPass(
                    context,
                    email: _emailController.text,
                  );
                  if (result == true) {
                    Get.back();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
