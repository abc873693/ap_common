import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';

class ScoreData {
  List<Score> scores;
  Detail detail;

  ScoreData({
    this.scores,
    this.detail,
  });

  factory ScoreData.fromRawJson(String str) =>
      ScoreData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScoreData.fromJson(Map<String, dynamic> json) => new ScoreData(
        scores:
            new List<Score>.from(json["scores"].map((x) => Score.fromJson(x))),
        detail: Detail.fromJson(json["detail"]),
      );

  Map<String, dynamic> toJson() => {
        "scores": new List<dynamic>.from(scores.map((x) => x.toJson())),
        "detail": detail.toJson(),
      };

  void save(String tag) {
    Preferences.setString(
      '${ApConstants.PACKAGE_NAME}'
      '.score_data_$tag',
      this.toRawJson(),
    );
  }

  factory ScoreData.load(String tag) {
    String rawString = Preferences.getString(
      '${ApConstants.PACKAGE_NAME}'
          '.score_data_$tag',
      '',
    );
    if (rawString == '')
      return null;
    else
      return ScoreData.fromRawJson(rawString);
  }
}

class Detail {
  double creditTaken;
  double creditEarned;
  double conduct;
  double average;
  String classRank;
  String departmentRank;
  double classPercentage;

  Detail({
    this.creditTaken,
    this.creditEarned,
    this.conduct,
    this.average,
    this.classRank,
    this.departmentRank,
    this.classPercentage,
  });

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  bool get isCreditEmpty => (creditTaken == null && creditEarned == null);

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => new Detail(
        creditTaken: json["creditTaken"],
        creditEarned: json["creditEarned"],
        conduct: json["conduct"],
        average: json["average"],
        classRank: json["classRank"],
        departmentRank: json["departmentRank"],
        classPercentage: json["classPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "creditTaken": creditTaken,
        "creditEarned": creditEarned,
        "conduct": conduct,
        "average": average,
        "classRank": classRank,
        "departmentRank": departmentRank,
        "classPercentage": classPercentage,
      };
}

class Score {
  String courseNumber;
  bool isPreScore;
  String title;
  String units;
  String hours;
  String required;
  String at;
  String middleScore;
  String generalScore;
  String finalScore;
  String semesterScore;
  String remark;

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

  factory Score.fromRawJson(String str) => Score.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Score.fromJson(Map<String, dynamic> json) => new Score(
        courseNumber: json["courseNumber"],
        isPreScore: json["isPreScore"] ?? false,
        title: json["title"],
        units: json["units"],
        hours: json["hours"],
        required: json["required"],
        at: json["at"],
        middleScore: json["middleScore"],
        generalScore: json['generalScore'],
        finalScore: json["finalScore"],
        semesterScore: json["semesterScore"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "courseNumber": courseNumber,
        "isPreScore": isPreScore,
        "title": title,
        "units": units,
        "hours": hours,
        "required": required,
        "at": at,
        "middleScore": middleScore,
        "generalScore": generalScore,
        "finalScore": finalScore,
        "semesterScore": semesterScore,
        "remark": remark,
      };
}
