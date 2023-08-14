import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/rental/controller/rental.controller.dart';
import 'package:get/get.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  var controller = Get.find<RentalController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getOrderRental();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        showCart: false,
        titleName: 'Order Request',
        onBackPress: () {
          Navigator.pop(context);
        },
        body: GetBuilder<RentalController>(builder: (_) {
          return ListView.builder(
              itemCount: controller.orderData?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  color: ColorConstants.COLOR_BLUE_1.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.card_travel),
                        ),
                        Expanded(
                            child: Text(
                          controller.orderData?[index]['docId'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        InkWell(
                          onTap: () async {
                            controller.setActiveOrderData(
                                controller.orderData?[index]);
                            Get.toNamed(RouteConstants.requestOrder);
                          },
                          child: Container(
                            color: ColorConstants.COLOR_YELLOW,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            child: const Text('เลือกออเดอร์'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }));
  }
}
