import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/custom_overlay.dart';
import 'package:flutter_boilerplate/cart/controller/cart.controller.dart';
import 'package:flutter_boilerplate/home/controller/home.controller.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.COLOR_BLUE,
        leadingWidth: size.width * 0.7,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Search name product'.tr,
              border: InputBorder.none,
              filled: true,
              fillColor: ColorConstants.COLOR_WHITE,
              suffixIcon: Icon(
                Icons.search,
                color: ColorConstants.COLOR_BLUE,
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await Get.showOverlay(
                asyncFunction: () =>
                    Get.find<CartController>().calculateTotalCart(),
                loadingWidget: const CustomOverlay(),
              );
              Get.toNamed('/cart');

            },
            child: GetBuilder<CartController>(
                // id: 'addcart',
                builder: (cartController) {
              return Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Center(
                  child: Badge(
                    label: cartController.cartList!.isNotEmpty
                        ? Text(cartController.cartList?.length.toString() ?? '')
                        : null,
                    isLabelVisible:
                        cartController.cartList!.isNotEmpty ? true : false,
                    // alignment: AlignmentDirectional.center,
                    child: Icon(Icons.shopping_cart,
                        color: ColorConstants.COLOR_YELLOW),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Text(
                  'category'.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: size.height,
                constraints: const BoxConstraints(maxHeight: 200),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  childAspectRatio: 4 / 3,
                  children: controller.categoryList
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            print(e['name']);
                            controller.setActiveCategory(e['name'] ?? '');
                            Get.toNamed('/product');
                          },
                          child: Container(
                            color: ColorConstants.COLOR_BLUE,
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(18),
                            child: Image.asset(e['image'].toString()),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height * 0.4,
                child: CarouselSlider.builder(
                    // key: _sliderKey,
                    unlimitedMode: true,
                    enableAutoSlider: true,
                    slideBuilder: (index) {
                      return Image.network(
                        controller.bannerCarousel[index],
                        fit: BoxFit.cover,
                      );
                    },
                    slideTransform: const DefaultTransform(),
                    slideIndicator: CircularSlideIndicator(
                      currentIndicatorColor: ColorConstants.COLOR_YELLOW,
                      padding: const EdgeInsets.only(bottom: 20),
                    ),
                    itemCount: controller.bannerCarousel.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
