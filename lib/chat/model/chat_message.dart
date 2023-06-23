import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatMessage chatMessageFromJson(String str) =>
    ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
  String? messageId;
  String? message;
  String? messageType;
  bool? isSender;
  DateTime? date;

  ChatMessage({
    this.messageId,
    this.message,
    this.messageType,
    this.isSender,
    this.date,
  });

  ChatMessage copyWith({
    String? messageId,
    String? message,
    String? messageType,
    bool? isSender,
    DateTime? date,
  }) =>
      ChatMessage(
        messageId: messageId ?? this.messageId,
        message: message ?? this.message,
        messageType: messageType ?? this.messageType,
        isSender: isSender ?? this.isSender,
        date: date ?? this.date,
      );

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        messageId: json['messageId'],
        message: json["message"],
        messageType: json['messageType'],
        isSender: json["isSender"],
        date: json['date'],
      );

  Map<String, dynamic> toMap() => {
        "messageId": messageId,
        "message": message,
        "messageType": messageType,
        "isSender": isSender,
        "date": date,
      };

  String toJson() => json.encode(toMap());
}
