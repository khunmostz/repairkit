import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/utils/constants/color.dart';
import 'package:flutter_boilerplate/base/utils/constants/size.dart';
import 'package:flutter_boilerplate/chat/model/chat_message.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isSender ?? true
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: message.isSender ?? true
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: size.width / 2,
              ),
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: message.isSender == true
                      ? ColorConstants.COLOR_BLUE
                      : ColorConstants.COLOR_BLUE.withOpacity(0.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '''${message.message}''',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.COLOR_WHITE,
                  ),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Text(
                DateFormat('dd-MM-yy HH:mm')
                    .format(message.date ?? DateTime.now()),
                style: TextStyle(color: ColorConstants.COLOR_GREY, fontSize: 10),
              ),
            )
          ],
        ),
      ],
    );
  }
}
