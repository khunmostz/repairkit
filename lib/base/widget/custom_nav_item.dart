import 'package:flutter/material.dart';

class CustomNavItem extends StatelessWidget {
  CustomNavItem({super.key, this.icon, this.name});

  Icon? icon;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          Text(
            name ?? '',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
