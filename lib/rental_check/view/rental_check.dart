import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';

class RentalCheck extends StatefulWidget {
  const RentalCheck({super.key});

  @override
  State<RentalCheck> createState() => _RentalCheckState();
}

class _RentalCheckState extends State<RentalCheck> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'เช็คสถานะสินค้า',
      showBackPress: false,
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}
