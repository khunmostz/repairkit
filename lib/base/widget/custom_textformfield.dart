import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.label,
      this.controller,
      this.onChanged,
      this.validator,
      this.onTap,
      this.autovalidateMode,
      this.maxLines,
      this.inputFormatters,
      this.keyboardType,
      this.isDense,
      this.hintText,
      this.showBorder, this.suffixIcon});

  final String? label;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? isDense;
  final String? hintText;
  final bool? showBorder;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              label ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            autovalidateMode: autovalidateMode,
            onTap: onTap,
            maxLines: maxLines,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              isDense: isDense,
              filled: true,
              fillColor: ColorConstants.COLOR_WHITE,
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: suffixIcon,
              enabledBorder: showBorder == true
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(),
                    )
                  : null,
                  focusedBorder: showBorder == true
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(),
                    )
                  : null
            ),
          ),
        ),
      ],
    );
  }
}
