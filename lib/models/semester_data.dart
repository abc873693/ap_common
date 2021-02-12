import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';

class SemesterData {
  List<Semester>? data;
  Semester? defaultSemester;
  int? currentIndex;

  int get defaultIndex {
    if (defaultSemester == null || data == null) return -1;
    for (var i = 0; i < (data?.length ?? 0); i++)
      if (defaultSemester?.text == data?[i].text) return i;
    return 0;
  }

  Semester? get currentSemester {
    if (currentIndex == null || data?.length == 0) return null;
    return data?[currentIndex ?? 0];
  }

  List<String> get semesters {
    List<String> texts = [];
    data?.forEach((element) => texts.add(element.text ?? ''));
    return texts;
  }

  SemesterData({
    this.data,
    this.defaultSemester,
    this.currentIndex = 0,
  });

  factory SemesterData.fromRawJson(String str) =>
      SemesterData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SemesterData.fromJson(Map<String, dynamic> json) => new SemesterData(
        data: new List<Semester>.from(
            json["data"].map((x) => Semester.fromJson(x))),
        defaultSemester: Semester.fromJson(json["default"]),
        currentIndex: json['currentIndex'],
      );

  Map<String, dynamic> toJson() => {
        "data": new List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
        "default": defaultSemester?.toJson(),
        "currentIndex": currentIndex,
      };

  void save() {
    Preferences.setString(
      '${ApConstants.PACKAGE_NAME}'
      'semester_data',
      this.toRawJson(),
    );
  }

  factory SemesterData.load() {
    String rawString = Preferences.getString(
      '${ApConstants.PACKAGE_NAME}'
          'semester_data',
      '',
    );
    if (rawString == '')
      return SemesterData();
    else
      return SemesterData.fromRawJson(rawString);
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

  factory Semester.fromRawJson(String str) =>
      Semester.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Semester.fromJson(Map<String, dynamic> json) => new Semester(
        year: json["year"],
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "value": value,
        "text": text,
      };
}
