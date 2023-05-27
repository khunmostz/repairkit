// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) => ErrorModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      code: json['code'] as int?,
    );

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'error': instance.error,
      'code': instance.code,
    };
