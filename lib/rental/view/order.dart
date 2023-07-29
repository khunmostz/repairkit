import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'Order Request',
      onBackPress: () {
        Navigator.pop(context);
      },
      body: ListView(
        children: [
          Card(
            color: ColorConstants.COLOR_BLUE_1.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.card_travel),
                  const Text('order code'),
                  Container(
                    color: ColorConstants.COLOR_YELLOW,
                    padding: const EdgeInsets.all(16),
                    child: Text('select order'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
