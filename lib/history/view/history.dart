import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/history/controller/history.controller.dart';
import 'package:get/get.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var controller = Get.put(HistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      titleName: 'ประวัติการเช่า',
      onBackPress: () {
        Get.back();
      },
      body: GetBuilder<HistoryController>(builder: (_) {
        return ListView.builder(
          itemCount: controller.historyData.length,
          itemBuilder: (context, index) {
            return Container(
              width: size.width,
              margin: const EdgeInsets.only(
                  bottom: 10, top: 24, left: 24, right: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ColorConstants.COLOR_BLUE,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(
                      controller.historyData[index]['productImage'] ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, object, stacktrace) {
                        return Image.network(
                            'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=');
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller.historyData[index]['rentalName'] ?? '',
                              style:
                                  TextStyle(color: ColorConstants.COLOR_WHITE),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller.historyData[index]['product'] ?? '',
                              style:
                                  TextStyle(color: ColorConstants.COLOR_WHITE),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                int.parse(controller.historyData[index]
                                                ['productAmount'] ??
                                            '0') >
                                        1
                                    ? 'x${controller.historyData[index]['productAmount']}'
                                    : controller.historyData[index]
                                            ['productAmount'] ??
                                        '',
                                style: TextStyle(
                                    color: ColorConstants.COLOR_WHITE)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    controller.historyData[index]['rentDay'] ??
                                        '',
                                    style: TextStyle(
                                        color: ColorConstants.COLOR_WHITE)),
                              ),
                              Text('day',
                                  style: TextStyle(
                                      color: ColorConstants.COLOR_WHITE)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
