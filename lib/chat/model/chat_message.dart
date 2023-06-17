import 'dart:convert';

ChatMessage chatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
    String? content;
    bool? isSender;

    ChatMessage({
        this.content,
        this.isSender,
    });

    ChatMessage copyWith({
        String? content,
        bool? isSender,
    }) => 
        ChatMessage(
            content: content ?? this.content,
            isSender: isSender ?? this.isSender,
        );

    factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        content: json["content"],
        isSender: json["isSender"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "isSender": isSender,
    };
}


 