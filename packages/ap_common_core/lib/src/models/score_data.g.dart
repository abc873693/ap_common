// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoreData _$ScoreDataFromJson(Map<String, dynamic> json) => _ScoreData(
      scores: (json['scores'] as List<dynamic>)
          .map((e) => Score.fromJson(e as Map<String, dynamic>))
          .toList(),
      detail: Detail.fromJson(json['detail'] as Map<String, dynamic>),
      scoreType: $enumDecodeNullable(_$ScoreTypeEnumMap, json['scoreType']) ??
          ScoreType.numeric,
      passingScore: (json['passingScore'] as num?)?.toDouble() ?? 60.0,
      passingGradePoint: (json['passingGradePoint'] as num?)?.toDouble() ?? 1.7,
    );

Map<String, dynamic> _$ScoreDataToJson(_ScoreData instance) =>
    <String, dynamic>{
      'scores': instance.scores.map((e) => e.toJson()).toList(),
      'detail': instance.detail.toJson(),
      'scoreType': _$ScoreTypeEnumMap[instance.scoreType]!,
      'passingScore': instance.passingScore,
      'passingGradePoint': instance.passingGradePoint,
    };

const _$ScoreTypeEnumMap = {
  ScoreType.numeric: 'numeric',
  ScoreType.gradePoint: 'gradePoint',
};

_Detail _$DetailFromJson(Map<String, dynamic> json) => _Detail(
      creditTaken: (json['creditTaken'] as num?)?.toDouble(),
      creditEarned: (json['creditEarned'] as num?)?.toDouble(),
      average: (json['average'] as num?)?.toDouble(),
      classRank: json['classRank'] as String?,
      departmentRank: json['departmentRank'] as String?,
      classPercentage: (json['classPercentage'] as num?)?.toDouble(),
      conduct: (json['conduct'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DetailToJson(_Detail instance) => <String, dynamic>{
      'creditTaken': instance.creditTaken,
      'creditEarned': instance.creditEarned,
      'average': instance.average,
      'classRank': instance.classRank,
      'departmentRank': instance.departmentRank,
      'classPercentage': instance.classPercentage,
      'conduct': instance.conduct,
    };

_Score _$ScoreFromJson(Map<String, dynamic> json) => _Score(
      courseNumber: json['courseNumber'] as String?,
      isPreScore: json['isPreScore'] as bool? ?? false,
      title: json['title'] as String,
      units: json['units'] as String,
      hours: json['hours'] as String?,
      required: json['required'] as String?,
      at: json['at'] as String?,
      middleScore: json['middleScore'] as String?,
      generalScore: json['generalScore'] as String?,
      finalScore: json['finalScore'] as String?,
      semesterScore: json['semesterScore'] as String?,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$ScoreToJson(_Score instance) => <String, dynamic>{
      'courseNumber': instance.courseNumber,
      'isPreScore': instance.isPreScore,
      'title': instance.title,
      'units': instance.units,
      'hours': instance.hours,
      'required': instance.required,
      'at': instance.at,
      'middleScore': instance.middleScore,
      'generalScore': instance.generalScore,
      'finalScore': instance.finalScore,
      'semesterScore': instance.semesterScore,
      'remark': instance.remark,
    };
