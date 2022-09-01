import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:json_annotation/json_annotation.dart';

part 'score_data.g.dart';

@JsonSerializable()
class ScoreData {
  List<Score>? scores;
  Detail? detail;

  ScoreData({
    this.scores,
    this.detail,
  });

  factory ScoreData.fromJson(Map<String, dynamic> json) =>
      _$ScoreDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreDataToJson(this);

  factory ScoreData.fromRawJson(String str) => ScoreData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());

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

@JsonSerializable()
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

  bool get isCreditEmpty => creditTaken == null && creditEarned == null;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);

  factory Detail.fromRawJson(String str) => Detail.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

@JsonSerializable()
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

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreToJson(this);

  factory Score.fromRawJson(String str) => Score.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}
