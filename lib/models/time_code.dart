// To parse this JSON data, do
//
//     final timeCodeConfig = timeCodeConfigFromJson(jsonString);

import 'dart:convert';

import 'course_data.dart' show TimeCode;

class TimeCodeConfig {
  List<TimeCode>? timeCodes;

  TimeCodeConfig({
    this.timeCodes,
  });

  factory TimeCodeConfig.fromRawJson(String str) =>
      TimeCodeConfig.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TimeCodeConfig.fromJson(Map<String, dynamic> json) => TimeCodeConfig(
        timeCodes: json["timeCodes"] == null
            ? null
            : List<TimeCode>.from(
                json["timeCodes"].map((x) => TimeCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timeCodes": timeCodes == null
            ? null
            : List<dynamic>.from(timeCodes!.map((x) => x.toJson())),
      };

  List<String?> get textList {
    List<String?> tmp = [];
    timeCodes?.forEach((timeCode) => tmp.add(timeCode.title));
    return tmp;
  }

  int indexOf(String section) {
    return textList.indexOf(section);
  }
}