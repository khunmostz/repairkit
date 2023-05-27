import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  int? statusCode;
  String? message;
  String? error;
  int? code;

  ErrorModel({this.statusCode, this.message, this.error, this.code});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
