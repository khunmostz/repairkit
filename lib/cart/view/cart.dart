import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_button.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Cart extends GetView<CartController> {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BaseScaffold(
      onBackPress: () {
        Get.back();
      },
      titleName: 'Cart',
    showCart: false,
      bottomNavigationBar: Container(
        width: size.width,
        height: 100.h,
        color: ColorConstants.COLOR_BLUE,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'total',
                      style: TextStyle(
                          color: ColorConstants.COLOR_WHITE,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      controller.totalCart.toString(),
                      style: TextStyle(
                          color: ColorConstants.COLOR_WHITE,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'bath',
                      style: TextStyle(
                          color: ColorConstants.COLOR_WHITE,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              BaseButton(
                textButton: 'Accetp to rent',
                color: ColorConstants.COLOR_ORANGE,
                onTap: (){
                  Get.toNamed('/payment');
                },
              )
            ],
          ),
        ),
      ),
      body: GetBuilder<CartController>(
        builder: (context) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
               for (var i = 0; i < (controller.cartList?.length ?? 0); i++) ...{
                Container(
                  width: size.width,
                  margin: const EdgeInsets.only(
                      bottom: 10, top: 24, left: 24, right: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: ColorConstants.COLOR_BLUE,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.network(
                            controller.cartList?[i].productImage ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,object,stacktrace){
                              return Image.network('https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=');
                            },
                            ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               controller.cartList?[i].productName ?? '' ,
                                style: TextStyle(color: ColorConstants.COLOR_WHITE),
                              ),
                              Text(int.parse(controller.cartList?[i].productAmout ?? '0') > 1 ? 'x${controller.cartList?[i].productAmout}':  controller.cartList?[i].productAmout ?? '',
                                  style:
                                      TextStyle(color: ColorConstants.COLOR_WHITE)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.cartList?[i].productPrice ?? '',
                                      style: TextStyle(
                                          color: ColorConstants.COLOR_WHITE)),
                                  Text('bath',
                                      style: TextStyle(
                                          color: ColorConstants.COLOR_WHITE)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.cartList?[i].productRent ?? '',
                                      style: TextStyle(
                                          color: ColorConstants.COLOR_WHITE)),
                                  Text('day',
                                      style: TextStyle(
                                          color: ColorConstants.COLOR_WHITE)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('total',
                                      style: TextStyle(
                                          color: ColorConstants.COLOR_WHITE)),
                                  Text(controller.cartList?[i].productTotal ?? '',
                                      style: TextStyle(
                                          color: ColorConstants.COLOR_WHITE)),
                                  Text('bath',
                                      style: TextStyle(
                                          color: ColorConstants.COLOR_WHITE)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            controller.removeItemCart(i);
                          },
                          child: Icon(Icons.delete,
                          color: ColorConstants.COLOR_WHITE,),
                        ),
                      )
                    ],
                  ),
                ),
              }
            ],
          );
        }
      ),
    );
  }
}
