// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseData _$CourseDataFromJson(Map<String, dynamic> json) => _CourseData(
      courses: (json['courses'] as List<dynamic>)
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeCodes: (json['timeCodes'] as List<dynamic>)
          .map((e) => TimeCode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseDataToJson(_CourseData instance) =>
    <String, dynamic>{
      'courses': instance.courses.map((e) => e.toJson()).toList(),
      'timeCodes': instance.timeCodes.map((e) => e.toJson()).toList(),
    };

_Course _$CourseFromJson(Map<String, dynamic> json) => _Course(
      code: json['code'] as String,
      title: json['title'] as String,
      className: json['className'] as String?,
      group: json['group'] as String?,
      units: json['units'] as String?,
      hours: json['hours'] as String?,
      required: json['required'] as String?,
      at: json['at'] as String?,
      times: (json['sectionTimes'] as List<dynamic>)
          .map((e) => SectionTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      instructors: (json['instructors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      colorIndex: (json['colorIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseToJson(_Course instance) => <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
      'className': instance.className,
      'group': instance.group,
      'units': instance.units,
      'hours': instance.hours,
      'required': instance.required,
      'at': instance.at,
      'sectionTimes': instance.times.map((e) => e.toJson()).toList(),
      'location': instance.location?.toJson(),
      'instructors': instance.instructors,
      'colorIndex': instance.colorIndex,
    };

_Location _$LocationFromJson(Map<String, dynamic> json) => _Location(
      room: json['room'] as String,
      building: json['building'] as String,
    );

Map<String, dynamic> _$LocationToJson(_Location instance) => <String, dynamic>{
      'room': instance.room,
      'building': instance.building,
    };

_SectionTime _$SectionTimeFromJson(Map<String, dynamic> json) => _SectionTime(
      weekday: (json['weekday'] as num).toInt(),
      index: (json['index'] as num).toInt(),
    );

Map<String, dynamic> _$SectionTimeToJson(_SectionTime instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'index': instance.index,
    };

_TimeCode _$TimeCodeFromJson(Map<String, dynamic> json) => _TimeCode(
      title: json['title'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$TimeCodeToJson(_TimeCode instance) => <String, dynamic>{
      'title': instance.title,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
