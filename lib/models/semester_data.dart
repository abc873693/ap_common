import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:json_annotation/json_annotation.dart';

part 'semester_data.g.dart';

@JsonSerializable()
class SemesterData {
  SemesterData({
    required this.data,
    this.defaultSemester,
    this.currentIndex = 0,
  });

  factory SemesterData.fromJson(Map<String, dynamic> json) =>
      _$SemesterDataFromJson(json);

  factory SemesterData.fromRawJson(String str) => SemesterData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  static SemesterData? load() {
    final String rawString = Preferences.getString(
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

  List<Semester> data;
  @JsonKey(name: 'default')
  Semester? defaultSemester;
  int currentIndex = 0;

  int get defaultIndex {
    if (defaultSemester == null) return 0;
    for (int i = 0; i < data.length; i++) {
      if (defaultSemester!.text == data[i].text) return i;
    }
    return 0;
  }

  Semester get currentSemester {
    return data[currentIndex];
  }

  List<String> get semesters {
    final List<String> texts = <String>[];
    for (final Semester semester in data) {
      texts.add(semester.text);
    }
    return texts;
  }

  Map<String, dynamic> toJson() => _$SemesterDataToJson(this);

  String toRawJson() => jsonEncode(toJson());

  void save() {
    Preferences.setString(
      '${ApConstants.packageName}'
      'semester_data',
      toRawJson(),
    );
  }
}

@JsonSerializable()
class Semester {
  Semester({
    required this.year,
    required this.value,
    required this.text,
  });

  factory Semester.fromJson(Map<String, dynamic> json) =>
      _$SemesterFromJson(json);

  factory Semester.fromRawJson(String str) => Semester.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  final String year;
  final String value;

  //TODO update to immutable
  String text;

  String get code => '$year$value';

//  String get cacheSaveTag => '${Helper.username}_$code';

  Map<String, dynamic> toJson() => _$SemesterToJson(this);

  String toRawJson() => jsonEncode(toJson());
}
