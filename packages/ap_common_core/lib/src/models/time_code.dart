// To parse this JSON data, do
//
//     final timeCodeConfig = timeCodeConfigFromJson(jsonString);

import 'dart:convert';

import 'package:ap_common_core/src/models/course_data.dart' show TimeCode;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_code.freezed.dart';
part 'time_code.g.dart';

@freezed
abstract class TimeCodeConfig with _$TimeCodeConfig {

  const factory TimeCodeConfig({
    required List<TimeCode> timeCodes,
  }) = _TimeCodeConfig;
  const TimeCodeConfig._();

  factory TimeCodeConfig.fromJson(Map<String, dynamic> json) =>
      _$TimeCodeConfigFromJson(json);

  factory TimeCodeConfig.fromRawJson(String str) => TimeCodeConfig.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());

  List<String> get textList {
    final List<String> tmp = <String>[];
    for (final TimeCode timeCode in timeCodes) {
      tmp.add(timeCode.title);
    }
    return tmp;
  }

  int indexOf(String section) {
    return textList.indexOf(section);
  }
}
