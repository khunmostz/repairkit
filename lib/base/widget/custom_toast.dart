import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';

showToast(BuildContext context, {String? toastText, String? status}) {
  return context.showFlash(
    duration: const Duration(seconds: 3),
    builder: (context, controller) => Flash(
      controller: controller,
      position: FlashPosition.bottom,
      dismissDirections: const [FlashDismissDirection.startToEnd],
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: status == ToastStatus.SUCCESS
                        ? ColorConstants.COLOR_GREEN
                        : ColorConstants.COLOR_RED,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: status == ToastStatus.SUCCESS
                            ? ColorConstants.COLOR_GREEN.withOpacity(0.5)
                            : ColorConstants.COLOR_RED.withOpacity(0.5),
                        blurRadius: 1,
                        spreadRadius: 7,
                      ),
                    ]),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          toastText ?? '',
                          style: TextStyle(
                            color: ColorConstants.COLOR_WHITE,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
