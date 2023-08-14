import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/profie/controller/profile.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.COLOR_WHITE,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          margin: const EdgeInsets.only(top: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: ColorConstants.COLOR_BLUE,
                  radius: 40,
                ),
                Text(FirebaseAuth.instance.currentUser?.email ?? ''),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
      ),
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
