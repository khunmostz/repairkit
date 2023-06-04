import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_button.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetail extends GetView<ProductController> {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleName: 'Product Number',
      onBackPress: () {
        Get.back();
      },
      onCartPress: (){
        Get.toNamed('/cart');
      },
      body: ListView(
        children: [
          Image.network(
            'https://assets.entrepreneur.com/content/3x2/2000/20180703190744-rollsafe-meme.jpeg',
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 24, left: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Product name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('Price product 18.00'), Text('each 1 day')],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 20),
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemSize: 20,
              ignoreGestures: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          Divider(
            color: ColorConstants.COLOR_GREY,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        radius: 25,
                      ),
                    ),
                    Text('Rental Name')
                  ],
                ),
                InkWell(
                  onTap: () {
                    debugPrint('chat');
                  },
                  child: Icon(
                    Icons.chat,
                    color: ColorConstants.COLOR_BLUE,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: ColorConstants.COLOR_GREY,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ColorConstants.COLOR_BLUE.withOpacity(0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Product Id: P12345',
                  ),
                  Text(
                    'Category: Drill',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text('Description'),
                  ),
                  Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley"),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 175,
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.only(right: 24),
              child: BaseButton(
                textButton: 'Add to Cart',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Product title'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            dialogTextRow(
                              title: 'productId',
                              widget: Text('T123123'),
                            ),
                            dialogTextRow(
                              title: 'productName',
                              widget: Text('name'),
                            ),
                            dialogTextRow(
                              title: 'Day of rent',
                              unit: 'Day',
                              widget: GetBuilder<ProductController>(
                                  builder: (context) {
                                return DropdownButton(
                                  value: controller.day,
                                  items: controller.dayRent
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e, child: Text(e)),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    controller.onChangeDropdownDayRent(value);
                                  },
                                );
                              }),
                            ),
                            dialogTextRow(
                              title: 'amount',
                              unit: 'each',
                              widget: GetBuilder<ProductController>(
                                  builder: (context) {
                                return DropdownButton(
                                  value: controller.day,
                                  items: controller.dayRent
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e, child: Text(e)),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    controller.onChangeDropdownDayRent(value);
                                  },
                                );
                              }),
                            ),
                            SizedBox(height: 50.h),
                            dialogTextRow(
                                title: 'price',
                                widget: const Center(child: Text('data')),
                                unit: 'Bath'),
                            dialogTextRow(
                                title: 'price',
                                widget: const Center(child: Text('data')),
                                unit: 'Bath'),
                            dialogTextRow(
                                title: 'price',
                                widget: const Center(child: Text('data')),
                                unit: 'Bath')
                          ],
                        ),
                        actions: [
                          BaseButton(
                            textButton: 'Accept',
                            onTap: () {},
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogTextRow({String? title, Widget? widget, String? unit}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title: '),
          Expanded(
            child: widget ?? Container(),
          ),
          Text(unit ?? '')
        ],
      ),
    );
  }
}
