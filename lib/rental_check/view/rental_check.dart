import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/widget/base_button.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/receive_product/model/receive_product_model.dart';
import 'package:flutter_boilerplate/rental_check/controller/rental_check.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RentalCheck extends StatefulWidget {
  const RentalCheck({super.key});

  @override
  State<RentalCheck> createState() => _RentalCheckState();
}

class _RentalCheckState extends State<RentalCheck> {
  var controller = Get.put(RentalCheckController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getReturnProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'เช็คสถานะสินค้า',
      showBackPress: false,
      body: GetBuilder<RentalCheckController>(builder: (context) {
        return ListView.builder(
          itemCount: controller.receiveProductModel?.length ?? 0,
          itemBuilder: (context, index) {
            ReceiveProductModel? data = controller.receiveProductModel?[index];
            var dateFormat = DateFormat('dd/MM/yyyy HH:mm');
            return _receiveItem(
                rentalName: data?.rentalName,
                product: data?.product,
                productImage: data?.productImage,
                date: dateFormat.format(
                    DateTime.fromMillisecondsSinceEpoch(data?.createdAt ?? 0)
                        .add(Duration(days: int.parse(data?.rentDay ?? "0")))),
                endDate: dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
                        data?.createdAt ?? 0)
                    .add(
                        Duration(days: (int.parse(data?.rentDay ?? "0") + 3)))),
                onAccept: () {
                  controller.day = "1";
                  controller.setTotalPrice(int.parse(data?.eachPrice ?? "0"));
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(data?.product ?? ''),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            dialogTextRow(
                              title: 'Day of rent',
                              unit: 'Day',
                              widget: GetBuilder<RentalCheckController>(
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
                                    controller.calculateTotalPrice(
                                        int.parse(data?.eachPrice ?? "0"));
                                  },
                                );
                              }),
                            ),
                            SizedBox(height: 50.h),
                            GetBuilder<RentalCheckController>(
                                builder: (context) {
                              return dialogTextRow(
                                  title: 'Total price',
                                  widget: Center(
                                      child: Text(
                                          controller.totalPrice.toString())),
                                  unit: 'Bath');
                            }),
                            GetBuilder<RentalCheckController>(
                                builder: (context) {
                              return dialogTextRow(
                                  title: 'Total rental days',
                                  widget: Center(
                                      child: Text(controller.day ?? '0')),
                                  unit: 'Days');
                            })
                          ],
                        ),
                        actions: [
                          BaseButton(
                            textButton: 'Accept',
                            onTap: ()async {
                            int? date = int.parse(controller.day ?? "0") + int.parse(data?.rentDay ?? "0");
                             bool? result = await  controller.updateDayProduct(docId: data?.docId ?? "",date: '$date');
                             if (result == true && mounted) return Get.toNamed(RouteConstants.payment);
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
          },
        );
      }),
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

  Widget _receiveItem(
      {String? rentalName,
      String? endDate,
      String? product,
      String? date,
      String? productImage,
      String? textButton,
      Function()? onAccept}) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration:
          BoxDecoration(color: ColorConstants.COLOR_BLUE.withOpacity(0.5)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rentalName ?? ''),
                Container(
                  width: 120.w,
                  height: 120.h,
                  margin: const EdgeInsets.only(top: 12),
                  // color: Colors.blue,
                  child: Image.network(productImage ?? ''),
                ),
                const Spacer(),
                // Text('จัดส่งโดย  ${trackingCompany ?? '-'}'),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product ?? '-'),
                const SizedBox(
                  height: 20,
                ),
                Text('ครบกำหนดส่ง ${date ?? '-'}'),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'โปรดส่งคืนภายในวันที่ ${endDate ?? '-'}',
                  style: TextStyle(
                    color: ColorConstants.COLOR_RED,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onAccept,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    color: ColorConstants.COLOR_YELLOW,
                    child: Center(
                      child: Text(textButton ?? 'เพิ่มระยะเวลาการเช่ายืม'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
