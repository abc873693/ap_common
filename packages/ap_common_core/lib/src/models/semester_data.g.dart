// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SemesterData _$SemesterDataFromJson(Map<String, dynamic> json) =>
    _SemesterData(
      data: (json['data'] as List<dynamic>)
          .map((e) => Semester.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultSemester:
          Semester.fromJson(json['default'] as Map<String, dynamic>),
      currentIndex: (json['currentIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SemesterDataToJson(_SemesterData instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'default': instance.defaultSemester.toJson(),
      'currentIndex': instance.currentIndex,
    };

_Semester _$SemesterFromJson(Map<String, dynamic> json) => _Semester(
      year: json['year'] as String,
      value: json['value'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$SemesterToJson(_Semester instance) => <String, dynamic>{
      'year': instance.year,
      'value': instance.value,
      'text': instance.text,
    };
