import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';

class CustomOverlay extends StatelessWidget {
  const CustomOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(color: Colors.black54),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
