import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/profie/controller/profile.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getProfile();
    return Scaffold(
      backgroundColor: ColorConstants.COLOR_WHITE,
      body: SafeArea(
        child: GetBuilder<ProfileController>(builder: (_) {
          return Container(
            width: size.width,
            height: size.height,
            margin: const EdgeInsets.only(top: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundColor: ColorConstants.COLOR_BLUE,
                        backgroundImage:
                            controller.dataProfile['imageProfile'] != null
                                ? NetworkImage(
                                    controller.dataProfile['imageProfile'],
                                  )
                                : null,
                        radius: 40,
                      ),
                      Positioned(
                        right: -10,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            openModalCamera(context);
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            child: Icon(Icons.camera),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(controller.dataProfile['name'] ?? "-"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...controller.itemColumnProfile.map(
                          (e) => InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                switch (e["name"]) {
                                  case "history_rent":
                                    Get.toNamed(RouteConstants.receiveProduct);
                                    break;
                                  default:
                                }
                              },
                              child: _itemColumnProfile(
                                  title: e['title'], icon: e['icon'])),
                        ),
                      ],
                    ),
                  ),
                  ...controller.itemRowProfile
                      .map((e) => InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              switch (e["name"]) {
                                case "rent_store":
                                  Get.toNamed(RouteConstants.myShop);
                                  break;
                                case "history_rent":
                                  Get.toNamed(RouteConstants.history);
                                  break;
                                case "profile_setting":
                                  Get.toNamed(RouteConstants.editProfile);
                                  break;
                                default:
                              }
                            },
                            child: _itemRowProfile(
                              iconLeading: e['iconLeading'],
                              title: e['title'],
                              iconAction: e['iconAction'],
                            ),
                          ))
                      .toList(),
                  CustomButton(
                    onTap: () {
                      controller.logout();
                    },
                    text: 'LOGOUT',
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<dynamic> openModalCamera(BuildContext context) {
    List<Map<String, dynamic>> cameraList = [
      {
        'name': "camera",
        'title': "กล้อง",
        'icon': const Icon(Icons.camera),
      },
      {
        'name': "gallery",
        'title': "แกลลอรี่",
        'icon': const Icon(Icons.image),
      },
    ];
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: cameraList
                .map((e) => InkWell(
                      onTap: () async {
                        switch (e['name']) {
                          case 'camera':
                            bool? result = await controller.selectImageProfile(
                                imageSource: ImageSource.camera);
                            if (result == true && context.mounted) Get.back();
                            break;
                          case 'gallery':
                            bool? result = await controller.selectImageProfile(
                                imageSource: ImageSource.gallery);
                            if (result == true && context.mounted) Get.back();
                            break;
                          default:
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            e['icon'],
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(e['title']),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _itemColumnProfile({String? title, Icon? icon}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(title ?? ''),
        ),
        icon ?? const Icon(Icons.account_balance_wallet_rounded)
      ],
    );
  }

  Widget _itemRowProfile(
      {Icon? iconLeading,
      String? title,
      Icon? iconAction,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        height: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration:
            BoxDecoration(color: ColorConstants.COLOR_BLUE.withOpacity(0.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconLeading ?? Container(),
            Text(
              title ?? '',
              style: TextStyle(fontSize: 16, color: ColorConstants.COLOR_WHITE),
            ),
            iconAction ?? Container(),
          ],
        ),
      ),
    );
  }
}
