import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/chat/model/chat_message.dart';
import 'package:flutter_boilerplate/chat/view/message_bubble.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<ChatMessage> demoMessage = [
    ChatMessage(
        content:
            'ChatText 1 asdlkasl;dakl;alsdkal;dakl;sdkl;asdsdakasdasdasdassl;',
        isSender: true),
    ChatMessage(content: 'ChatText 2', isSender: false),
    ChatMessage(content: 'ChatText 3', isSender: true),
    ChatMessage(content: 'ChatText 4', isSender: false),
    ChatMessage(content: 'ChatText 5', isSender: true),
    ChatMessage(content: 'ChatText 6', isSender: false),
    ChatMessage(content: 'ChatText 7', isSender: true),
    ChatMessage(content: 'ChatText 8', isSender: true),
    ChatMessage(content: 'ChatText 9', isSender: false),
    ChatMessage(content: 'ChatText 10', isSender: true),
    ChatMessage(content: 'ChatText 11', isSender: false),
    ChatMessage(content: 'ChatText 12', isSender: true),
    ChatMessage(content: 'ChatText 13', isSender: false),
    ChatMessage(content: 'ChatText 14', isSender: true),
    ChatMessage(content: 'ChatText 1', isSender: true),
    ChatMessage(content: 'ChatText 2', isSender: false),
    ChatMessage(content: 'ChatText 3', isSender: true),
    ChatMessage(content: 'ChatText 4', isSender: false),
    ChatMessage(content: 'ChatText 5', isSender: true),
    ChatMessage(content: 'ChatText 6', isSender: false),
    ChatMessage(content: 'ChatText 7', isSender: true),
    ChatMessage(content: 'ChatText 8', isSender: true),
    ChatMessage(content: 'ChatText 9', isSender: false),
    ChatMessage(content: 'ChatText 10', isSender: true),
    ChatMessage(content: 'ChatText 11', isSender: false),
    ChatMessage(content: 'ChatText 12', isSender: true),
    ChatMessage(content: 'ChatText 13', isSender: false),
    ChatMessage(content: 'ChatText 14', isSender: true),
  ];

  @override
  Widget build(BuildContext context) {

    if (Get.find<ProductController>().rentalModel != null) {
      print(Get.find<ProductController>().rentalModel?.rentalId);
    }

    return BaseScaffold(
      showCart: false,
      onBackPress: () => Get.back(),
      titleName: 'Chat',
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: demoMessage.length,
              itemBuilder: (context, index) {

                return MessageBubble(
                  message: demoMessage[index],
                );
              },
            ),
          ),
          Container(
            width: size.width,
            color: ColorConstants.COLOR_BLUE,
            height: 70.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: ColorConstants.COLOR_WHITE,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.COLOR_WHITE,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.send_rounded,
                    color: ColorConstants.COLOR_WHITE,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
