import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';

class SemesterData {
  List<Semester>? data;
  Semester? defaultSemester;
  int currentIndex = 0;

  int get defaultIndex {
    if (defaultSemester == null) return 0;
    for (int i = 0; i < data!.length; i++) {
      if (defaultSemester!.text == data![i].text) return i;
    }
    return 0;
  }

  Semester get currentSemester {
    return data![currentIndex];
  }

  List<String> get semesters {
    final List<String> texts = <String>[];
    for (final Semester semester in data!) {
      texts.add(semester.text ?? '');
    }
    return texts;
  }

  SemesterData({
    this.data,
    this.defaultSemester,
    this.currentIndex = 0,
  });

  factory SemesterData.fromRawJson(String str) =>
      SemesterData.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory SemesterData.fromJson(Map<String, dynamic> json) => SemesterData(
        data: List<Semester>.from(
          (json['data'] as List<dynamic>).map(
            (x) => Semester.fromJson(x as Map<String, dynamic>),
          ),
        ),
        defaultSemester: Semester.fromJson(
          json['default'] as Map<String, dynamic>,
        ),
        currentIndex: json['currentIndex'] as int,
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'default': defaultSemester!.toJson(),
        'currentIndex': currentIndex,
      };

  void save() {
    Preferences.setString(
      '${ApConstants.packageName}'
      'semester_data',
      toRawJson(),
    );
  }

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
}

class Semester {
  String? year;
  String? value;
  String? text;

  String get code => '$year$value';

//  String get cacheSaveTag => '${Helper.username}_$code';

  Semester({
    this.year,
    this.value,
    this.text,
  });

  factory Semester.fromRawJson(String str) => Semester.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        year: json['year'] as String,
        value: json['value'] as String,
        text: json['text'] as String,
      );

  Map<String, dynamic> toJson() => {
        'year': year,
        'value': value,
        'text': text,
      };
}
