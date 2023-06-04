import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/base/widget/custom_textformfield.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_boilerplate/product/model/product.model.dart';
import 'package:get/get.dart';

class Product extends GetView<ProductController> {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      onBackPress: () => Get.back(),
      titleName: 'Product',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            CustomTextFormField(
              isDense: true,
              showBorder: true,
              hintText: 'Search name product'.tr,
              suffixIcon: Icon(
                Icons.search,
                color: ColorConstants.COLOR_BLUE,
              ),
            ),
            GetBuilder<ProductController>(builder: (_) {
              if (controller.isLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          '/product/detail',
                          // arguments: ProductModel(

                          // ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://assets.entrepreneur.com/content/3x2/2000/20180703190744-rollsafe-meme.jpeg',
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: size.width,
                                height: 50,
                                color:
                                    ColorConstants.COLOR_BLACK.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Product Name',
                                    style: TextStyle(
                                        color: ColorConstants.COLOR_WHITE),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
