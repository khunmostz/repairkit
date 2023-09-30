import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/chat/controller/chat.controller.dart';
import 'package:flutter_boilerplate/receive_product/controller/receive_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReceiveProduct extends StatefulWidget {
  const ReceiveProduct({super.key});

  @override
  State<ReceiveProduct> createState() => _ReceiveProductState();
}

class _ReceiveProductState extends State<ReceiveProduct> {
  var controller = Get.put(ReceviceController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getReceivceProduct();
     controller.selectedTab = 'รับสินค้า';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<ChatController>();
        Get.offNamedUntil(RouteConstants.layout, (route) {
          return true;
        });
        return true;
      },
      child: BaseScaffold(
        showBackPress: true,
        onBackPress: () {
          Get.delete<ChatController>();
          Get.offNamedUntil(RouteConstants.layout, (route) {
            return true;
          });
        },
        titleName: 'Receive product',
        body: GetBuilder<ReceviceController>(builder: (context) {
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
                            case 'รับสินค้า':
                              controller.getReceivceProduct();
                              break;
                            case 'ส่งสินค้าคืน':
                              controller.getReturnProduct();
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
              if (controller.selectedTab == 'ส่งสินค้าคืน') ...{
                ...List.generate(
                  controller.receiveProductModel?.length ?? 0,
                  (index) => _receiveItem(
                      rentalName:
                          controller.receiveProductModel?[index].rentalName ??
                              '',
                      product:
                          controller.receiveProductModel?[index].product ?? '',
                      trackingCompany: controller
                              .receiveProductModel?[index].trackingProduct ??
                          '',
                      trackingProduct: controller
                              .receiveProductModel?[index].trackingCompany ??
                          "",
                      productImage:
                          controller.receiveProductModel?[index].productImage ??
                              "",
                      onAccept: () {
                        // controller.accepthItem(index: index);
                        controller.setActiveReceiveProduct(
                            controller.receiveProductModel?[index]);
                        Get.toNamed(RouteConstants.formReturnProduct);
                      }),
                ),
              } else ...{
                ...List.generate(
                  controller.receiveProductModel?.length ?? 0,
                  (index) => _receiveItem(
                      rentalName:
                          controller.receiveProductModel?[index].rentalName ??
                              '',
                      product:
                          controller.receiveProductModel?[index].product ?? '',
                      trackingCompany: controller
                              .receiveProductModel?[index].trackingProduct ??
                          '',
                      trackingProduct: controller
                              .receiveProductModel?[index].trackingCompany ??
                          "",
                      productImage:
                          controller.receiveProductModel?[index].productImage ??
                              "",
                      onAccept: () {
                        controller.accepthItem(index: index);
                      }),
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
                Text(rentalName ?? '-'),
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
                    child: const Center(
                      child: Text('ยืนยันการรับ'),
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
