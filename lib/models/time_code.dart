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

  factory TimeCodeConfig.fromRawJson(String str) => TimeCodeConfig.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory TimeCodeConfig.fromJson(Map<String, dynamic> json) => TimeCodeConfig(
        timeCodes: json['timeCodes'] == null
            ? null
            : List<TimeCode>.from(
                (json['timeCodes'] as List<dynamic>).map(
                  (dynamic x) => TimeCode.fromJson(x as Map<String, dynamic>),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        'timeCodes': timeCodes == null
            ? null
            : List<dynamic>.from(timeCodes!.map((x) => x.toJson())),
      };

  List<String?> get textList {
    final List<String?> tmp = [];
    for (final timeCode in timeCodes ?? <TimeCode>[]) {
      tmp.add(timeCode.title);
    }
    return tmp;
  }

  int indexOf(String section) {
    return textList.indexOf(section);
  }
}
