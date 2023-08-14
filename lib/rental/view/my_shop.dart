import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/rental/controller/rental.controller.dart';
import 'package:get/get.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  var controller = Get.put(RentalController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleName: 'My shop',
      onBackPress: () {
        Get.back();
      },
      showCart: false,
      body: GetBuilder<RentalController>(
          init: RentalController(),
          builder: (context) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.haveRental == false) ...[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text('คุณยังไม่มีร้านผู้ให้เช่า '),
                    ),
                    CustomButton(
                      text: 'สร้างร้านให้เช่า',
                      onTap: () {
                        Get.toNamed(RouteConstants.createShop);
                      },
                    )
                  ] else if (controller.haveRental == true) ...[
                    Expanded(
                      child: Container(
                        width: size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: ColorConstants.COLOR_BLACK,
                                    height: 100,
                                    child: controller
                                                .userData?['rentalImage'] !=
                                            null
                                        ? Image.network(
                                            controller.userData?['rentalImage'],
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    controller.userData?['rentalName'] ?? "",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Get.toNamed(RouteConstants.order);
                                    },
                                    child: const Icon(Icons.card_travel),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Get.toNamed(RouteConstants.rentalReceive);
                                    },
                                    child: const Icon(Icons.mail),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Get.toNamed(RouteConstants.editShop);
                                    },
                                    child: const Icon(Icons.settings),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Get.toNamed(RouteConstants.addProduct);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                child: const Text('เพิ่มสินค้า'),
                              ),
                            ),
                            Container(
                              child: const Text('สินค้าของฉัน'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (controller.product != null) ...{
                              Expanded(
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  children: controller.product
                                          ?.map((e) => Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Image.network(
                                                        e.productImage ?? '',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          e.productName ?? ''),
                                                    )
                                                  ],
                                                ),
                                              ))
                                          .toList() ??
                                      [],
                                ),
                              )
                            } else ...{
                              const Center(
                                child: Text('No product'),
                              )
                            }
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
    );
  }
}
