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
      body: GetBuilder<RentalController>(builder: (context) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(controller.haveRental == false)...[
                const Padding(
                  padding:  EdgeInsets.only(bottom: 20),
                  child: Text('คุณยังไม่มีร้านผู้ให้เช่า '),
                ),
                 CustomButton(
                  text: 'สร้างร้านให้เช่า',
                  onTap: (){
                    Get.toNamed(RouteConstants.createShop);
                  },
                )
              ]
              // Expanded(
              //   child: Container(
              //     width: size.width,
              //     margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
              //     child: Column(
              //       children: [
              //         Row(
              //           children: [
              //             Expanded(
              //               child: Container(
              //                 color: ColorConstants.COLOR_BLACK,
              //                 height: 100,
              //               ),
              //             ),
              //             const Expanded(
              //               child: Text(
              //                 'show name',
              //                 textAlign: TextAlign.right,
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(24),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               InkWell(
              //                 onTap: () {
              //                   Get.toNamed(RouteConstants.order);
              //                 },
              //                 child: Container(
              //                   child: Icon(Icons.card_giftcard),
              //                 ),
              //               ),
              //               Container(
              //                 child: Icon(Icons.card_giftcard),
              //               ),
              //               Container(
              //                 child: Icon(Icons.card_giftcard),
              //               )
              //             ],
              //           ),
              //         ),
              //         InkWell(
                        
              //           onTap: (){
              //             Get.toNamed(RouteConstants.addProduct);
              //           },
              //           child: Container(
              //             margin: const EdgeInsets.only(bottom: 24),
              //             child: const Text('add product'),
              //           ),
              //         ),
              //         Container(
              //           child: const Text('my product'),
              //         ),
              //         SizedBox(
              //           height: 20,
              //         ),
              //         Expanded(
              //           child: GridView.count(
              //             crossAxisCount: 2,
              //             mainAxisSpacing: 10,
              //             crossAxisSpacing: 10,
              //             children: [
              //               Container(
              //                 color: Colors.black,
              //               ),
              //               Container(
              //                 color: Colors.black,
              //               ),
              //               Container(
              //                 color: Colors.black,
              //               ),
              //               Container(
              //                 color: Colors.black,
              //               ),
              //                Container(
              //                 color: Colors.black,
              //               ),
              //               Container(
              //                 color: Colors.black,
              //               ),
              //               Container(
              //                 color: Colors.black,
              //               ),
              //               Container(
              //                 color: Colors.black,
              //               ),

              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
           
            ],
          ),
        );
      }),
    );
  }
}
