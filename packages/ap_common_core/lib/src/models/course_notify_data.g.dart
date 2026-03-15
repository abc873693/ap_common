// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_notify_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseNotifyData _$CourseNotifyDataFromJson(Map<String, dynamic> json) =>
    _CourseNotifyData(
      version: (json['version'] as num?)?.toInt() ?? 2,
      lastId: (json['lastId'] as num?)?.toInt() ?? 1,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CourseNotify.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CourseNotify>[],
    );

Map<String, dynamic> _$CourseNotifyDataToJson(_CourseNotifyData instance) =>
    <String, dynamic>{
      'version': instance.version,
      'lastId': instance.lastId,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

_CourseNotify _$CourseNotifyFromJson(Map<String, dynamic> json) =>
    _CourseNotify(
      id: (json['id'] as num).toInt(),
      weekday: (json['weekday'] as num).toInt(),
      startTime: json['startTime'] as String,
      title: json['title'] as String?,
      location: json['location'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CourseNotifyToJson(_CourseNotify instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekday': instance.weekday,
      'startTime': instance.startTime,
      'title': instance.title,
      'location': instance.location,
      'code': instance.code,
    };
