import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'Add Product',
      onBackPress: () {
        Navigator.pop(context);
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 300.h,
              margin: const EdgeInsets.all(24),
              color: ColorConstants.COLOR_BLACK,
              child: Icon(
                Icons.add,
                color: ColorConstants.COLOR_WHITE,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
              child: Row(
                children: [
                 const  Expanded(child: Text('select type', style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                  DropdownButton(
                    value: null,
                    items: [],
                    // items: controller.amountRent
                    //     .map(
                    //       (e) => DropdownMenuItem(
                    //           value: e,
                    //           child: Text(e.toString())),
                    //     )
                    //     .toList(),
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextFormField(
                label: 'name product',
                showBorder: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextFormField(
                label: 'product amount',
                showBorder: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextFormField(
                label: 'price to day',
                showBorder: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: CustomTextFormField(
                label: 'product description',
                showBorder: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: CustomButton(
                text: 'accept product',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
