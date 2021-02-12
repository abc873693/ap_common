// To parse this JSON data, do
//
//     final timeCodeConfig = timeCodeConfigFromJson(jsonString);

import 'dart:convert';

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
            : List<dynamic>.from(timeCodes?.map((x) => x.toJson()) ?? []),
      };

  List<String> get textList {
    List<String> tmp = [];
    timeCodes?.forEach((timeCode) => tmp.add(timeCode.title ?? ''));
    return tmp;
  }

  int indexOf(String section) {
    return textList.indexOf(section);
  }
}

class TimeCode {
  String? title;
  String? startTime;
  String? endTime;

  TimeCode({
    this.title,
    this.startTime,
    this.endTime,
  });

  factory TimeCode.fromRawJson(String str) =>
      TimeCode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TimeCode.fromJson(Map<String, dynamic> json) => TimeCode(
        title: json["title"] == null ? null : json["title"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
      };
}
