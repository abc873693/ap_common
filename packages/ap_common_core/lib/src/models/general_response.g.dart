// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeneralResponse _$GeneralResponseFromJson(Map<String, dynamic> json) =>
    _GeneralResponse(
      statusCode: (json['code'] as num).toInt(),
      message: json['description'] as String,
    );

Map<String, dynamic> _$GeneralResponseToJson(_GeneralResponse instance) =>
    <String, dynamic>{
      'code': instance.statusCode,
      'description': instance.message,
    };
