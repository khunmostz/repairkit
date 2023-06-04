import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_button.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onBackPress: () {
        Get.back();
      },
      titleName: 'Cart',
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
                      '500',
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
              )
            ],
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          for (var i = 0; i < 10; i++) ...{
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
                        'https://assets.entrepreneur.com/content/3x2/2000/20180703190744-rollsafe-meme.jpeg',
                        fit: BoxFit.cover),
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
                            'เลื่อยไฟฟ้ายนต์ ESK-3435',
                            style: TextStyle(color: ColorConstants.COLOR_WHITE),
                          ),
                          Text('x2',
                              style:
                                  TextStyle(color: ColorConstants.COLOR_WHITE)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('29.99',
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
                              Text('7',
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
                              Text('500',
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
                    child: Icon(Icons.delete,
                    color: ColorConstants.COLOR_WHITE,),
                  )
                ],
              ),
            ),
          }
        ],
      ),
    );
  }
}
