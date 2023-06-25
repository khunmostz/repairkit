import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/enum.dart';
import 'package:flutter_boilerplate/base/utils/constants/route.dart';
import 'package:flutter_boilerplate/base/widget/base_scaffold.dart';
import 'package:flutter_boilerplate/chat/controller/chat.controller.dart';
import 'package:get/get.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        controller.userMode = ChatMode.USER;
        return true;
      },
      child: BaseScaffold(
        showCart: false,
        showBackPress: false,
        titleName: 'Chat List',
        body: GetBuilder<ChatController>(
          builder: (_) {
            return StreamBuilder<QuerySnapshot?>(
              stream: controller.getRoom(),
              builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Container(
                    child: const Center(child: Text('ไม่มีคนคุย')),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      controller.userMode = ChatMode.RENTAL;
                      controller.activeChat = snapshot.data?.docs[index]['userName'];
                      print(snapshot.data?.docs[index]['roomId']);
                      controller.setRoomId(snapshot.data?.docs[index]['roomId']);
                      Get.toNamed(RouteConstants.chat,arguments: snapshot.data?.docs[index]['roomId']);
                    },
                    child: ListTile(
                      title: Text(snapshot.data?.docs[index]['shopName'] ?? ''),
                    ),
                  );
                });
              },
            );
          }
        ),
      ),
    );
  }
}
