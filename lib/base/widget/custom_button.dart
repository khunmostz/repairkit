import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.onTap, this.text,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();

  final Function()? onTap;
  final String? text;
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 256,
        height: 60.h,
        decoration: BoxDecoration(
          color: ColorConstants.COLOR_ORANGE,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            widget.text ?? '',
            style: TextStyle(
              color: ColorConstants.COLOR_WHITE,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
