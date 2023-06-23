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

class ChatView extends GetView<ChatController> {
  ChatView({super.key});

  TextEditingController chatController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showCart: false,
      onBackPress: () => Get.back(),
      titleName:
          'Chat',
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<QuerySnapshot>(
          stream: controller.getMessage(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Column(
              children: [
                if (snapshot.data!.docs.isNotEmpty) ...{
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        var data = snapshot.data?.docs;

                        ChatMessage messageSnapshot = ChatMessage(
                          message: data?[index]['message'],
                          messageId: data?[index]['messageId'],
                          isSender: FirebaseAuth.instance.currentUser?.uid ==
                              data?[index]['sendBy'],
                        );

                        return MessageBubble(
                          message: messageSnapshot,
                        );
                      },
                    ),
                  ),
                } else ...{
                  const Spacer()
                },
                Container(
                  // width: size.width,
                  color: ColorConstants.COLOR_BLUE,
                  // height: 70.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              print(DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(DateTime.now()));
                            },
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
                                controller.setMessage({
                                  'messageId':
                                      '${FirebaseAuth.instance.currentUser?.uid}-${Get.find<ProductController>().rentalModel?.rentalName}',
                                  'sendBy':
                                      '${FirebaseAuth.instance.currentUser?.uid}',
                                  'message': message,
                                  'messageType': MessageType.TEXT,
                                  'date': DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .format(DateTime.now()),
                                });
                              },
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.sendMessage();
                            chatController.clear();
                            controller.setMessage({
                              'messageId':
                                  '${FirebaseAuth.instance.currentUser?.uid}-${Get.find<ProductController>().rentalModel?.rentalName}',
                              'sendBy':
                                  '${FirebaseAuth.instance.currentUser?.uid}',
                              'message': '',
                              'messageType': MessageType.TEXT,
                              'date': DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(DateTime.now()),
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
