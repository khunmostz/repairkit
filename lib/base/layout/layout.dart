import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/layout/controller/layout.controller.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/custom_nav_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Layout extends GetView<LayoutController> {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LayoutController>(builder: (_) {
        return IndexedStack(
          index: controller.screenIndex,
          children: controller.screen,
        );
      }),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.all(20),
          width: size.width,
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(100),
          ),
          child: GetBuilder<LayoutController>(builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < controller.screenArguments.length; i++)
                  InkWell(
                    onTap: () {
                      controller.changeScreen(i);
                    },
                    child: CustomNavItem(
                      icon: controller.screenArguments[i]["icon"],
                      name: controller.screenIndex == i
                          ? controller.screenArguments[i]["name"]
                          : '',
                    ),
                  ),
              ],
            );
          })),
    );
  }
}
