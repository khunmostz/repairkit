import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/rental/controller/rental.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RentalReceive extends StatefulWidget {
  const RentalReceive({super.key});

  @override
  State<RentalReceive> createState() => _RentalReceiveState();
}

class _RentalReceiveState extends State<RentalReceive> {
  var controller = Get.find<RentalController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getReturnProduct(isReceive: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: BaseScaffold(
        showBackPress: true,
        onBackPress: () {
          // Get.delete<ChatController>();
          // Get.offNamedUntil(RouteConstants.layout, (route) {
          //   return true;
          // });
          Get.back();
        },
        titleName: 'Receive product',
        body: GetBuilder<RentalController>(builder: (context) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    controller.tab?.length ?? 0,
                    (index) => _tabItem(
                        onTap: () {
                          controller.setSelectTab(controller.tab?[index]);
                          switch (controller.selectedTab) {
                            case 'ที่ต้องได้รับ':
                              controller.getReturnProduct(isReceive: false);
                              break;
                            case 'จัดส่งแล้ว':
                              controller.getHistory();
                              break;
                            default:
                          }
                        },
                        title: controller.tab?[index],
                        colorButton:
                            controller.selectedTab == controller.tab?[index]
                                ? ColorConstants.COLOR_YELLOW
                                : ColorConstants.COLOR_BLUE_1),
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: 50.h,
                margin: const EdgeInsets.only(bottom: 12),
                color: ColorConstants.COLOR_BLUE.withOpacity(0.2),
                child: Center(
                  child: Text(
                    '*กรุณาส่งสินค้าคืนภายใน 3 วันหลังหมดเวลาเช่ายืม*',
                    style: TextStyle(
                      color: ColorConstants.COLOR_RED,
                    ),
                  ),
                ),
              ),
              if (controller.selectedTab == 'ที่ต้องได้รับ') ...{
                ...List.generate(
                  controller.returnProductData?.length ?? 0,
                  (index) => _receiveItem(
                      // rentalName:
                      //     controller.returnProductData?[index].rentalName ?? '',
                      product:
                          controller.returnProductData?[index]['product'] ?? '',
                      trackingCompany: controller.returnProductData?[index]
                              ['deliveryCompany'] ??
                          '',
                      trackingProduct: controller.returnProductData?[index]
                              ['trackingCompany'] ??
                          "",
                      productImage: controller.returnProductData?[index]
                              ['productImage'] ??
                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pulsecarshalton.co.uk%2Fhome-v1%2Fimage-placeholder%2F&psig=AOvVaw3cnfu_3h5p_-I_I0YUlXzL&ust=1692079388545000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIi6xIi924ADFQAAAAAdAAAAABAE",
                      onAccept: () {
                        controller.accepthItem(
                            docId: controller.returnProductData?[index]
                                ['docId']);
                      }),
                ),
              } else ...{
                ...List.generate(
                  controller.returnProductData?.length ?? 0,
                  (index) => _receiveItem(
                    textButton: 'จัดส่งสำเร็จ',
                    product:
                        controller.returnProductData?[index]['product'] ?? '',
                    trackingCompany: controller.returnProductData?[index]
                            ['trackingProduct'] ??
                        '',
                    trackingProduct: controller.returnProductData?[index]
                            ['trackingCompany'] ??
                        "",
                    productImage: controller.returnProductData?[index]
                            ['productImage'] ??
                        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pulsecarshalton.co.uk%2Fhome-v1%2Fimage-placeholder%2F&psig=AOvVaw3cnfu_3h5p_-I_I0YUlXzL&ust=1692079388545000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCIi6xIi924ADFQAAAAAdAAAAABAE",
                    // onAccept: () {
                    //   controller.deleteReturnProduct(
                    //       docId: controller.returnProductData?[index]['docId']);
                    // },
                  ),
                ),
              }
            ],
          );
        }),
      ),
    );
  }

  Widget _receiveItem(
      {String? rentalName,
      String? trackingCompany,
      String? product,
      String? trackingProduct,
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
                Text('จัดส่งโดย  ${trackingCompany ?? '-'}'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product ?? '-'),
                Text('รหัสติดตามพัสดุ ${trackingProduct ?? '-'}'),
                const Spacer(),
                InkWell(
                  onTap: onAccept,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    color: ColorConstants.COLOR_YELLOW,
                    child: Center(
                      child: Text(textButton ?? 'ยืนยันการรับ'),
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

  Widget _tabItem({
    Function()? onTap,
    String? title,
    Color? colorButton,
    Color? colorText,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: colorButton),
          child: Center(
            child: Text(
              title ?? '',
              style: TextStyle(color: colorText),
            ),
          ),
        ),
      ),
    );
  }
}
