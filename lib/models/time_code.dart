// To parse this JSON data, do
//
//     final timeCodeConfig = timeCodeConfigFromJson(jsonString);

import 'dart:convert';

import 'package:ap_common/models/course_data.dart' show TimeCode;
import 'package:json_annotation/json_annotation.dart';

part 'time_code.g.dart';

@JsonSerializable()
class TimeCodeConfig {
  List<TimeCode>? timeCodes;

  TimeCodeConfig({
    this.timeCodes,
  });

  factory TimeCodeConfig.fromJson(Map<String, dynamic> json) =>
      _$TimeCodeConfigFromJson(json);

  Map<String, dynamic> toJson() => _$TimeCodeConfigToJson(this);

  factory TimeCodeConfig.fromRawJson(String str) => TimeCodeConfig.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());

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
