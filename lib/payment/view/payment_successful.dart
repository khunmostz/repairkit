import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:flutter_boilerplate/payment/controller/payment.controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PaymentSuccessful extends GetView<PaymentController> {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamedUntil(RouteConstants.home, (route) {
          return true;
        });
        return true;
      },
      child: BaseScaffold(
        showCart: false,
        titleName: 'Payment Complete',
        showBackPress: false,
        // onBackPress: () => Get.offAllNamed(RouteConstants.layout),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                size: 100,
                color: ColorConstants.COLOR_GREEN,
              ),
              Text(
                'Thank you',
                style: TextStyle(
                    color: ColorConstants.COLOR_GREEN,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Payment successful',
                style: TextStyle(
                    color: ColorConstants.COLOR_GREEN,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomButton(
                onTap: () async {
                  // print(Get.find<CartController>().cartList?[0].productName);
                  bool? result = await controller.buyProduct();
                  if (result == true) {
                    Get.find<CartController>().cartList?.clear();
                    // Get.offNamedUntil(RouteConstants.receiveProduct, (route) {
                    //   return true;
                    // });
                    Get.toNamed(RouteConstants.receiveProduct);
                  }
                },
                text: 'Go to receive product',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
