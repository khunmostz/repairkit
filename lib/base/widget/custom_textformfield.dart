import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.label,
    this.controller,
    this.onChanged,
    this.validator,
    this.onTap,
  });

  final String? label;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(label ?? ''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            onTap: onTap,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorConstants.COLOR_WHITE,
            ),
          ),
        ),
      ],
    );
  }
}
