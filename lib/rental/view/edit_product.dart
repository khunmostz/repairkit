import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_button.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/product/model/product.model.dart';
import 'package:flutter_boilerplate/rental/controller/rental.controller.dart';
import 'package:get/get.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  var controller = Get.find<RentalController>();
  ProductModel product = Get.arguments as ProductModel;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productNameController.text = product.productName ?? "";
    productDescController.text = product.productInfo ?? "";
    productPriceController.text = product.productPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onBackPress: () => Navigator.pop(context),
      showCart: false,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstants.COLOR_BLUE,
                width: 2,
              ),
            ),
            child: Image.network(product.productImage ?? "-"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(product.docId ?? "-"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomTextFormField(
              controller: productNameController,
              showBorder: true,
              label: "ชื่อสินค้า",
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomTextFormField(
              controller: productDescController,
              showBorder: true,
              label: "รายละเอียดสินค้า",
              maxLines: 5,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomTextFormField(
              controller: productPriceController,
              showBorder: true,
              label: "ราคาสินค้า",
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: CustomButton(
              text: "แก้ไขสินค้า",
              onTap: () async {
                bool? result = await controller.updateProduct(
                  docId: product.docId,
                  productName: productNameController.text,
                  productInfo: productDescController.text,
                  productPrice: int.parse(productPriceController.text),
                );
                if (result == true && mounted) {
                  controller.getProductRental();
                  Get.back();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
