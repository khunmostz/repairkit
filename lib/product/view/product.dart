import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/base/widget/custom_overlay.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_boilerplate/product/model/product.model.dart';
import 'package:get/get.dart';

class Product extends GetView<ProductController> {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onBackPress: () => Get.back(),
      titleName: 'Product',
      onCartPress: () async {
        await Get.showOverlay(
          asyncFunction: () => Get.find<CartController>().calculateTotalCart(),
          loadingWidget: const CustomOverlay(),
        );
        Get.toNamed(RouteConstants.cart);
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            CustomTextFormField(
              isDense: true,
              showBorder: true,
              hintText: 'Search name product'.tr,
              suffixIcon: Icon(
                Icons.search,
                color: ColorConstants.COLOR_BLUE,
              ),
              onChanged: (value) {
                print(value);
                controller.searchProduct(value);
              },
            ),
            GetBuilder<ProductController>(builder: (_) {
              if (controller.isLoading == true) {
                return SizedBox(
                  width: size.width,
                  height: size.height * 0.5,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: controller.product?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        controller.setRentalActive(
                            controller.product?[index].rentalId ?? 0);
                        await Get.showOverlay(
                            asyncFunction: () => controller.getRentalById(),
                            loadingWidget: const CustomOverlay());
                        Get.toNamed(
                          '/product/detail',
                          arguments: ProductModel(
                            rentalId: controller.product?[index].rentalId,
                            productCategory:
                                controller.product?[index].productCategory,
                            productName: controller.product?[index].productName,
                            productPrice:
                                controller.product?[index].productPrice,
                            productDate: controller.product?[index].productDate,
                            productAmount:
                                controller.product?[index].productAmount,
                            productInfo: controller.product?[index].productInfo,
                            productImage:
                                controller.product?[index].productImage,
                            rating: controller.product?[index].rating,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              controller.product?[index].productImage ?? '',
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: size.width,
                                height: 50,
                                color:
                                    ColorConstants.COLOR_BLACK.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    controller.product?[index].productName ??
                                        '',
                                    style: TextStyle(
                                        color: ColorConstants.COLOR_WHITE),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
