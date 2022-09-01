// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_notify_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseNotifyData _$CourseNotifyDataFromJson(Map<String, dynamic> json) =>
    CourseNotifyData(
      version: json['version'] as int? ?? 2,
      lastId: json['lastId'] as int? ?? 1,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CourseNotify.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )..tag = json['tag'] as String?;

Map<String, dynamic> _$CourseNotifyDataToJson(CourseNotifyData instance) =>
    <String, dynamic>{
      'version': instance.version,
      'lastId': instance.lastId,
      'data': instance.data.map((e) => e.toJson()).toList(),
      'tag': instance.tag,
    };

CourseNotify _$CourseNotifyFromJson(Map<String, dynamic> json) => CourseNotify(
      id: json['id'] as int,
      weekday: json['weekday'] as int,
      startTime: json['startTime'] as String,
      title: json['title'] as String?,
      location: json['location'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CourseNotifyToJson(CourseNotify instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'code': instance.code,
      'weekday': instance.weekday,
      'startTime': instance.startTime,
    };
