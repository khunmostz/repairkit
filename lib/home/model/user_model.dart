import 'dart:convert';

class UsersModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UsersModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  UsersModel copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      UsersModel(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

List<UsersModel> parseUserModelToJson(Map<String, dynamic> json) {
  Iterable userList = json['data'];
  return List<UsersModel>.from(userList.map((e) => UsersModel.fromJson(e)));
}
