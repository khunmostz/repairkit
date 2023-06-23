import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_button.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_overlay.dart';
import 'package:flutter_boilerplate/base/widget/custom_toast.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:flutter_boilerplate/cart/model/cart.model.dart';
import 'package:flutter_boilerplate/chat/controller/chat.controller.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_boilerplate/product/model/product.model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetail extends GetView<ProductController> {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = Get.arguments;
    return WillPopScope(
      onWillPop: () async {
        controller.setDefaultAmount();
        return true;
      },
      child: BaseScaffold(
        titleName: productModel.productName,
        onBackPress: () {
          controller.setDefaultAmount();
          Get.back();
        },
        onCartPress: () async {
          await Get.showOverlay(
            asyncFunction: () =>
                Get.find<CartController>().calculateTotalCart(),
            loadingWidget: const CustomOverlay(),
          );
          Get.toNamed(RouteConstants.cart);
        },
        body: ListView(
          children: [
            Image.network(
              productModel.productImage ?? '',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  productModel.productName ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price product ${productModel.productPrice ?? ''}'),
                  const Text('each 1 day'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 20),
              child: RatingBar.builder(
                initialRating: productModel.rating?.toDouble() ?? 0.0,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 20,
                ignoreGestures: true,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  debugPrint(rating.toString());
                },
              ),
            ),
            Divider(
              color: ColorConstants.COLOR_GREY,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              controller.rentalModel?.rentalImage ?? ''),
                        ),
                      ),
                      Text(controller.rentalModel?.rentalName ?? "")
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      debugPrint('chat');
                      Get.find<ChatController>().userMode = ChatMode.USER;
                      Get.toNamed(
                        RouteConstants.chat,
                      );
                    },
                    child: Icon(
                      Icons.chat,
                      color: ColorConstants.COLOR_BLUE,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: ColorConstants.COLOR_GREY,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                width: size.width,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: ColorConstants.COLOR_BLUE.withOpacity(0.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category ${productModel.productCategory ?? ''}',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text('Description'),
                    ),
                    Text(productModel.productInfo ?? ''),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 175,
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.only(right: 24),
                child: BaseButton(
                  textButton: 'Add to Cart',
                  onTap: () {
                    controller.setAmountRent(
                        productModel.productAmount?.toInt() ?? 0);
                    controller
                        .setTotalPrice(productModel.productPrice?.toInt() ?? 0);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(productModel.productName ?? ''),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              dialogTextRow(
                                title: 'Day of rent',
                                unit: 'Day',
                                widget: GetBuilder<ProductController>(
                                    builder: (context) {
                                  return DropdownButton(
                                    value: controller.day,
                                    items: controller.dayRent
                                        .map(
                                          (e) => DropdownMenuItem(
                                              value: e, child: Text(e)),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      controller.onChangeDropdownDayRent(value);
                                      controller.calculateTotalPrice(
                                          productModel.productPrice?.toInt() ??
                                              0);
                                    },
                                  );
                                }),
                              ),
                              dialogTextRow(
                                title: 'amount',
                                unit: 'each',
                                widget: GetBuilder<ProductController>(
                                    builder: (context) {
                                  return DropdownButton(
                                    value: controller.amount,
                                    items: controller.amountRent
                                        .map(
                                          (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e.toString())),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      controller.onChangeDropdownAmount(value);
                                      controller.calculateTotalPrice(
                                          productModel.productPrice?.toInt() ??
                                              0);
                                    },
                                  );
                                }),
                              ),
                              SizedBox(height: 50.h),
                              GetBuilder<ProductController>(builder: (context) {
                                return dialogTextRow(
                                    title: 'Total price',
                                    widget: Center(
                                        child: Text(
                                            controller.totalPrice.toString())),
                                    unit: 'Bath');
                              }),
                              GetBuilder<ProductController>(builder: (_) {
                                return dialogTextRow(
                                    title: 'Quantity',
                                    widget: Center(
                                        child:
                                            Text(controller.amount.toString())),
                                    unit: 'Each');
                              }),
                              GetBuilder<ProductController>(builder: (context) {
                                return dialogTextRow(
                                    title: 'Total rental days',
                                    widget: Center(
                                        child: Text(controller.day ?? '0')),
                                    unit: 'Days');
                              })
                            ],
                          ),
                          actions: [
                            BaseButton(
                              textButton: 'Accept',
                              onTap: () {
                                try {
                                  Get.find<CartController>().addItemCart(
                                    CartModel(
                                      productImage: productModel.productImage,
                                      productName: productModel.productName,
                                      productAmout:
                                          controller.amount.toString(),
                                      productRent: controller.day,
                                      productPrice:
                                          productModel.productPrice.toString(),
                                      productTotal:
                                          controller.totalPrice.toString(),
                                    ),
                                  );
                                  showToast(context,
                                      toastText:
                                          'Add product to cart successfully.',
                                      status: ToastStatus.SUCCESS);
                                  Get.back();
                                } catch (e) {
                                  debugPrint(e.toString());
                                  showToast(context,
                                      toastText: 'Add product to cart failed.',
                                      status: ToastStatus.ERROR);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogTextRow({String? title, Widget? widget, String? unit}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title: '),
          Expanded(
            child: widget ?? Container(),
          ),
          Text(unit ?? '')
        ],
      ),
    );
  }
}
