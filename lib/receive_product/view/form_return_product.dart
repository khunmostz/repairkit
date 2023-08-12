

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:get/get.dart';

class FormReturnProduct extends StatefulWidget {
  const FormReturnProduct({super.key});

  @override
  State<FormReturnProduct> createState() => _FormReturnProductState();
}

class _FormReturnProductState extends State<FormReturnProduct> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      onBackPress: (){
        Get.back();
      },
    );
  }
}