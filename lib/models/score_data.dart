import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:json_annotation/json_annotation.dart';

part 'score_data.g.dart';

@JsonSerializable()
class ScoreData {
  ScoreData({
    required this.scores,
    required this.detail,
  });

  factory ScoreData.fromJson(Map<String, dynamic> json) =>
      _$ScoreDataFromJson(json);

  factory ScoreData.fromRawJson(String str) => ScoreData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

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

  final List<Score> scores;
  final Detail detail;

  Map<String, dynamic> toJson() => _$ScoreDataToJson(this);

  String toRawJson() => jsonEncode(toJson());

  void save(String tag) {
    Preferences.setString(
      '${ApConstants.packageName}'
      '.score_data_$tag',
      toRawJson(),
    );
  }
}

@JsonSerializable()
class Detail {
  Detail({
    this.creditTaken,
    this.creditEarned,
    this.conduct,
    this.average,
    this.classRank,
    this.departmentRank,
    this.classPercentage,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  factory Detail.fromRawJson(String str) => Detail.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  final double? creditTaken;
  final double? creditEarned;
  final double? conduct;
  final double? average;
  final String? classRank;
  final String? departmentRank;
  final double? classPercentage;

  bool get isCreditEmpty => creditTaken == null && creditEarned == null;

  Map<String, dynamic> toJson() => _$DetailToJson(this);

  String toRawJson() => jsonEncode(toJson());
}

@JsonSerializable()
class Score {
  Score({
    required this.courseNumber,
    this.isPreScore = false,
    required this.title,
    required this.units,
    this.hours,
    this.required,
    this.at,
    this.middleScore,
    this.generalScore,
    this.finalScore,
    this.semesterScore,
    this.remark,
  });

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  factory Score.fromRawJson(String str) => Score.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  final String? courseNumber;
  final bool isPreScore;
  final String title;
  final String units;
  final String? hours;
  final String? required;
  final String? at;
  final String? middleScore;
  final String? generalScore;
  final String? finalScore;
  final String? semesterScore;
  final String? remark;

  Map<String, dynamic> toJson() => _$ScoreToJson(this);

  String toRawJson() => jsonEncode(toJson());

  Score copyWith({
    String? courseNumber,
    bool? isPreScore,
    String? title,
    String? units,
    String? hours,
    String? required,
    String? at,
    String? middleScore,
    String? generalScore,
    String? finalScore,
    String? semesterScore,
    String? remark,
  }) {
    return Score(
      courseNumber: courseNumber ?? this.courseNumber,
      isPreScore: isPreScore ?? this.isPreScore,
      title: title ?? this.title,
      units: units ?? this.units,
      hours: hours ?? this.hours,
      required: required ?? this.required,
      at: at ?? this.at,
      middleScore: middleScore ?? this.middleScore,
      generalScore: generalScore ?? this.generalScore,
      finalScore: finalScore ?? this.finalScore,
      semesterScore: semesterScore ?? this.semesterScore,
      remark: units ?? this.remark,
    );
  }
}
