import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/shimmer.dart';
import 'package:flutter_boilerplate/home/controller/home.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutterBoilerPlate'.tr),
        centerTitle: true,
        backgroundColor: ColorConstants.COLOR_RED,
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return ListView.builder(
            itemCount: controller.userModel?.length,
            itemBuilder: (context, index) {
              if (controller.loading == false) {
                return getLoading(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24, right: 24),
                    child: ListTile(
                      title: Container(
                        width: size.width,
                        height: 20.h,
                        color: Colors.white,
                      ),
                      subtitle: Container(
                        width: size.width,
                        margin: EdgeInsets.only(top: 10),
                        height: 20.h,
                        color: Colors.white,
                      ),
                      leading: const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 24, right: 24),
                child: ListTile(
                  title: Text(controller.userModel?[index].firstName ?? ''),
                  subtitle: Text(controller.userModel?[index].email ?? ''),
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      controller.userModel?[index].avatar ?? '',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
