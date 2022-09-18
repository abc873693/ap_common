// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreData _$ScoreDataFromJson(Map<String, dynamic> json) => ScoreData(
      scores: (json['scores'] as List<dynamic>)
          .map((e) => Score.fromJson(e as Map<String, dynamic>))
          .toList(),
      detail: Detail.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScoreDataToJson(ScoreData instance) => <String, dynamic>{
      'scores': instance.scores.map((e) => e.toJson()).toList(),
      'detail': instance.detail.toJson(),
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      creditTaken: (json['creditTaken'] as num?)?.toDouble(),
      creditEarned: (json['creditEarned'] as num?)?.toDouble(),
      conduct: (json['conduct'] as num?)?.toDouble(),
      average: (json['average'] as num?)?.toDouble(),
      classRank: json['classRank'] as String?,
      departmentRank: json['departmentRank'] as String?,
      classPercentage: (json['classPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'creditTaken': instance.creditTaken,
      'creditEarned': instance.creditEarned,
      'conduct': instance.conduct,
      'average': instance.average,
      'classRank': instance.classRank,
      'departmentRank': instance.departmentRank,
      'classPercentage': instance.classPercentage,
    };

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
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

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
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
