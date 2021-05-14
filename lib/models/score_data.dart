import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';

class ScoreData {
  List<Score>? scores;
  Detail? detail;

  ScoreData({
    this.scores,
    this.detail,
  });

  factory ScoreData.fromRawJson(String str) => ScoreData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory ScoreData.fromJson(Map<String, dynamic> json) => ScoreData(
        scores: List<Score>.from(
          (json['scores'] as List<dynamic>).map(
            (x) => Score.fromJson(x as Map<String, dynamic>),
          ),
        ),
        detail: Detail.fromJson(
          json['detail'] as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'scores': List<dynamic>.from(scores!.map((x) => x.toJson())),
        'detail': detail!.toJson(),
      };

  void save(String tag) {
    Preferences.setString(
      '${ApConstants.packageName}'
      '.score_data_$tag',
      toRawJson(),
    );
  }

  static ScoreData? load(String tag) {
    final String rawString = Preferences.getString(
      '${ApConstants.packageName}'
          '.score_data_$tag',
      '',
    );
    if (rawString == '') {
      return null;
    } else {
      return ScoreData.fromRawJson(rawString);
    }
  }
}

class Detail {
  double? creditTaken;
  double? creditEarned;
  double? conduct;
  double? average;
  String? classRank;
  String? departmentRank;
  double? classPercentage;

  Detail({
    this.creditTaken,
    this.creditEarned,
    this.conduct,
    this.average,
    this.classRank,
    this.departmentRank,
    this.classPercentage,
  });

  factory Detail.fromRawJson(String str) => Detail.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  bool get isCreditEmpty => creditTaken == null && creditEarned == null;

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        creditTaken: json['creditTaken'] as double,
        creditEarned: json['creditEarned'] as double,
        conduct: json['conduct'] as double,
        average: json['average'] as double,
        classRank: json['classRank'] as String,
        departmentRank: json['departmentRank'] as String,
        classPercentage: json['classPercentage'] as double,
      );

  Map<String, dynamic> toJson() => {
        'creditTaken': creditTaken,
        'creditEarned': creditEarned,
        'conduct': conduct,
        'average': average,
        'classRank': classRank,
        'departmentRank': departmentRank,
        'classPercentage': classPercentage,
      };
}

class Score {
  String? courseNumber;
  bool isPreScore;
  String? title;
  String? units;
  String? hours;
  String? required;
  String? at;
  String? middleScore;
  String? generalScore;
  String? finalScore;
  String? semesterScore;
  String? remark;

  Score({
    this.courseNumber,
    this.isPreScore = false,
    this.title,
    this.units,
    this.hours,
    this.required,
    this.at,
    this.middleScore,
    this.generalScore,
    this.finalScore,
    this.semesterScore,
    this.remark,
  });

  factory Score.fromRawJson(String str) => Score.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        courseNumber: json['courseNumber'] as String?,
        isPreScore: json['isPreScore'] as bool? ?? false,
        title: json['title'] as String?,
        units: json['units'] as String?,
        hours: json['hours'] as String?,
        required: json['required'] as String?,
        at: json['at'] as String?,
        middleScore: json['middleScore'] as String?,
        generalScore: json['generalScore'] as String?,
        finalScore: json['finalScore'] as String?,
        semesterScore: json['semesterScore'] as String?,
        remark: json['remark'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'courseNumber': courseNumber,
        'isPreScore': isPreScore,
        'title': title,
        'units': units,
        'hours': hours,
        'required': required,
        'at': at,
        'middleScore': middleScore,
        'generalScore': generalScore,
        'finalScore': finalScore,
        'semesterScore': semesterScore,
        'remark': remark,
      };
}
