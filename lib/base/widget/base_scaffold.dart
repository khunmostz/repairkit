import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:get/get.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.titleName,
    this.onBackPress,
    this.onCartPress,
    this.body,
    this.bottomNavigationBar,
    this.showCart = true,
    this.resizeToAvoidBottomInset,
    this.showBackPress = true,
  });

  final String? titleName;
  final Function()? onBackPress;
  final Function()? onCartPress;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool? showCart;
  final bool? showBackPress;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: ColorConstants.COLOR_WHITE,
      appBar: AppBar(
        backgroundColor: ColorConstants.COLOR_BLUE,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(titleName ?? ''),
        leading: showBackPress == true ? InkWell(
          onTap: onBackPress,
          child: const Icon(Icons.arrow_back),
        ) : null,
        actions: [
          showCart == true
              ? GetBuilder<CartController>(builder: (cartController) {
                  return InkWell(
                    onTap: onCartPress,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: Center(
                        child: Badge(
                          isLabelVisible: cartController.cartList!.isNotEmpty
                              ? true
                              : false,
                          label: cartController.cartList!.isNotEmpty
                              ? Text(
                                  cartController.cartList?.length.toString() ??
                                      '')
                              : null,
                          child: Icon(Icons.shopping_cart,
                              color: ColorConstants.COLOR_YELLOW),
                        ),
                      ),
                    ),
                  );
                })
              : Container(),
        ],
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
