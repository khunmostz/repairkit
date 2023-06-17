import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/payment/controller/payment.controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PaymentSuccessful extends GetView<PaymentController> {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'Payment Complete',
      onBackPress: () => Get.offAllNamed(RouteConstants.layout),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Icon(Icons.check, size: 100,color: ColorConstants.COLOR_GREEN,),
            Text(
              'Thank you',
              style: TextStyle(
                color: ColorConstants.COLOR_GREEN,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Payment successful',
              style: TextStyle(
                color: ColorConstants.COLOR_GREEN,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
