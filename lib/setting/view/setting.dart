import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/setting/controller/setting.controller.dart';
import 'package:get/get.dart';

class Setting extends GetView<SettingController> {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Setting',
            ),
            TextButton(
              onPressed: () {
                controller.toggleLanguages();
              },
              child: const Text('Change Languages'),
            )
          ],
        ),
      ),
    );
  }
}
