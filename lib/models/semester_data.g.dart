// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemesterData _$SemesterDataFromJson(Map<String, dynamic> json) => SemesterData(
      data: (json['data'] as List<dynamic>)
          .map((e) => Semester.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultSemester: json['default'] == null
          ? null
          : Semester.fromJson(json['default'] as Map<String, dynamic>),
      currentIndex: json['currentIndex'] as int? ?? 0,
    );

Map<String, dynamic> _$SemesterDataToJson(SemesterData instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'default': instance.defaultSemester?.toJson(),
      'currentIndex': instance.currentIndex,
    };

Semester _$SemesterFromJson(Map<String, dynamic> json) => Semester(
      year: json['year'] as String,
      value: json['value'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$SemesterToJson(Semester instance) => <String, dynamic>{
      'year': instance.year,
      'value': instance.value,
      'text': instance.text,
    };
