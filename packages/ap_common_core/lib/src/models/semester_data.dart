import 'dart:convert';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'semester_data.freezed.dart';
part 'semester_data.g.dart';

@freezed
abstract class SemesterData with _$SemesterData {
  const SemesterData._();

  const factory SemesterData({
    required List<Semester> data,
    @JsonKey(name: 'default') required Semester defaultSemester,
    @Default(0) int currentIndex,
  }) = _SemesterData;

  factory SemesterData.fromJson(Map<String, dynamic> json) =>
      _$SemesterDataFromJson(json);

  factory SemesterData.fromRawJson(String str) => SemesterData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  static SemesterData? load() {
    final String rawString = PreferenceUtil.instance.getString(
      '${ApConstants.packageName}'
          'semester_data',
      '',
    );
    if (rawString == '') {
      return null;
    } else {
      return SemesterData.fromRawJson(rawString);
    }
  }

  int get defaultIndex {
    for (int i = 0; i < data.length; i++) {
      if (defaultSemester.text == data[i].text) return i;
    }
    return 0;
  }

  Semester get currentSemester {
    try {
      return data[currentIndex];
    } catch (e) {
      return defaultSemester;
    }
  }

  List<String> get semesters {
    final List<String> texts = <String>[];
    for (final Semester semester in data) {
      texts.add(semester.text);
    }
    return texts;
  }

  String toRawJson() => jsonEncode(toJson());

  void save() {
    PreferenceUtil.instance.setString(
      '${ApConstants.packageName}'
      'semester_data',
      toRawJson(),
    );
  }
}

@freezed
abstract class Semester with _$Semester {
  const Semester._();

  const factory Semester({
    required String year,
    required String value,
    required String text,
  }) = _Semester;

  factory Semester.fromJson(Map<String, dynamic> json) =>
      _$SemesterFromJson(json);

  factory Semester.fromRawJson(String str) => Semester.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String get code => '$year$value';

  String toRawJson() => jsonEncode(toJson());
}
