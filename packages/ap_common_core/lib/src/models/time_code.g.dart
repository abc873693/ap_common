// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeCodeConfig _$TimeCodeConfigFromJson(Map<String, dynamic> json) =>
    _TimeCodeConfig(
      timeCodes: (json['timeCodes'] as List<dynamic>)
          .map((e) => TimeCode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeCodeConfigToJson(_TimeCodeConfig instance) =>
    <String, dynamic>{
      'timeCodes': instance.timeCodes.map((e) => e.toJson()).toList(),
    };
