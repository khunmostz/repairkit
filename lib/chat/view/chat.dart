import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/chat/controller/chat.controller.dart';
import 'package:flutter_boilerplate/chat/model/chat_message.dart';
import 'package:flutter_boilerplate/chat/view/message_bubble.dart';
import 'package:flutter_boilerplate/product/controller/product.controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart' as tz;

class ChatView extends GetView<ChatController> {
  ChatView({super.key});

  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? roomId =Get.arguments;
    
    return BaseScaffold(
      showCart: false,
      onBackPress: () => Get.back(),
      titleName: 'Chat',
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<QuerySnapshot>(
          stream: controller.getMessage(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // controller.getFcmFromChatRoom();
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            List<ChatMessage> messageSnapshot = [];

            snapshot.data?.docs.forEach(
              (element) {
                messageSnapshot.add(ChatMessage(
                  message: element['message'],
                  messageId: element['messageId'],
                  messageType: element['messageType'],
                  isSender: FirebaseAuth.instance.currentUser?.uid ==
                      element['sendBy'],

                ));
              },
            );

            return Column(
              children: [
                if (snapshot.data!.docs.isNotEmpty &&
                    messageSnapshot.isNotEmpty) ...{
                  Expanded(
                    child: ListView.builder(
                      // reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: messageSnapshot.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                          message: messageSnapshot[index],
                        );
                      },
                    ),
                  ),
                } else ...{
                  const Spacer()
                },
                Container(
                  color: ColorConstants.COLOR_BLUE,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.photo_size_select_actual_outlined,
                              color: ColorConstants.COLOR_WHITE,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: chatController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: ColorConstants.COLOR_WHITE,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (message) {
                                var detroit = tz.getLocation('Asia/Bangkok');
                                var now = tz.TZDateTime.now(detroit);
                                controller.setMessage({
                                  'messageId':
                                      '${FirebaseAuth.instance.currentUser?.uid}',
                                  'sendBy':
                                      '${FirebaseAuth.instance.currentUser?.uid}',
                                  'message': message,
                                  'messageType': MessageType.TEXT,
                                });
                              },
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            var detroit = tz.getLocation('Asia/Bangkok');
                            var now = tz.TZDateTime.now(detroit);
                            controller.sendMessage(roomId: roomId);
                            chatController.clear();
                            controller.setMessage({
                              'messageId':
                                  '${FirebaseAuth.instance.currentUser?.uid}-${Get.find<ProductController>().rentalModel?.rentalName}',
                              'sendBy':
                                  '${FirebaseAuth.instance.currentUser?.uid}',
                              'message': '',
                              'messageType': MessageType.TEXT,
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.send_rounded,
                              color: ColorConstants.COLOR_WHITE,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
