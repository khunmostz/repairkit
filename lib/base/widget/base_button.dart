import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({super.key, this.textButton, this.onTap, this.color});

  final String? textButton;
  final Function()? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        color: color ??ColorConstants.COLOR_BLUE,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              textButton ?? '',
              style: TextStyle(
                color: ColorConstants.COLOR_WHITE,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
