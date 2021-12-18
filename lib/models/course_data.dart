import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/material.dart';

class CourseData {
  CourseData({
    this.courses,
    this.timeCodes,
  });

  List<Course>? courses;
  List<TimeCode>? timeCodes;

  bool get hasHoliday {
    for (final course in courses!) {
      if (course.times == null) continue;
      for (final section in course.times!) {
        if (section.weekday == DateTime.saturday ||
            section.weekday == DateTime.sunday) return true;
      }
    }
    return false;
  }

  int? get maxTimeCodeIndex {
    int? index = 10;
    for (final course in courses!) {
      if (course.times == null) continue;
      for (final time in course.times!) {
        if (time.index! > index!) {
          index = time.index;
        }
      }
    }
    return index;
  }

  int? get minTimeCodeIndex {
    int? index = 10;
    for (final Course course in courses!) {
      if (course.times == null) continue;
      for (final time in course.times!) {
        if (time.index! < index!) {
          index = time.index;
        }
      }
    }
    return index! < 10 ? 0 : index;
  }

  CourseData copyWith({
    List<Course>? courses,
    List<TimeCode>? timeCodes,
  }) =>
      CourseData(
        courses: courses ?? this.courses,
        timeCodes: timeCodes ?? this.timeCodes,
      );

  factory CourseData.fromRawJson(String str) => CourseData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        courses: json['courses'] == null
            ? null
            : List<Course>.from(
                (json['courses'] as List<dynamic>).map(
                  (x) => Course.fromJson(x as Map<String, dynamic>),
                ),
              ),
        timeCodes: json['timeCodes'] == null
            ? null
            : List<TimeCode>.from(
                (json['timeCodes'] as List<dynamic>).map(
                  (x) => TimeCode.fromJson(x as Map<String, dynamic>),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        'courses': courses == null
            ? null
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
        'timeCodes': timeCodes == null
            ? null
            : List<dynamic>.from(timeCodes!.map((x) => x.toJson())),
      };

  void save(String tag) {
    Preferences.setString(
      '${ApConstants.packageName}'
      '.course_data_$tag',
      toRawJson(),
    );
  }

  static CourseData? load(String tag) {
    final String rawString = Preferences.getString(
      '${ApConstants.packageName}'
          '.course_data_$tag',
      '',
    );
    if (rawString == '') {
      return null;
    } else {
      return CourseData.fromRawJson(rawString);
    }
  }

  static Future<void> migrateFrom0_10() async {
    Preferences.prefs?.getKeys().forEach((key) {
      if (key.contains('course_data')) {
        debugPrint(key);
        Preferences.remove(key);
      }
    });
  }

  List<List<Course>> get weekDayCourseList {
    final List<List<Course>> list = [
      [],
      [],
      [],
      [],
      [],
      if (hasHoliday) ...[
        [],
        [],
      ]
    ];
    for (final course in courses!) {
      for (final time in course.times!) {
        for (int i = 0; i < timeCodes!.length; i++) {
          list[time.weekday! - 1].add(course);
        }
      }
    }
    return list;
  }

  int getTimeCodeIndex(String section) {
    for (int i = 0; i < timeCodes!.length; i++) {
      if (timeCodes![i].title == section) return i;
    }
    return -1;
  }
}

class Course {
  Course({
    this.code,
    this.title,
    this.className,
    this.group,
    this.units,
    this.hours,
    this.required,
    this.at,
    this.times,
    this.location,
    this.instructors,
  });

  String? code;
  String? title;
  String? className;
  String? group;
  String? units;
  String? hours;
  String? required;
  String? at;
  List<SectionTime>? times;
  Location? location;
  List<String>? instructors;

  Course copyWith({
    String? code,
    String? title,
    String? className,
    String? group,
    String? units,
    String? hours,
    String? required,
    String? at,
    List<SectionTime>? times,
    Location? location,
    List<String>? instructors,
  }) =>
      Course(
        code: code ?? this.code,
        title: title ?? this.title,
        className: className ?? this.className,
        group: group ?? this.group,
        units: units ?? this.units,
        hours: hours ?? this.hours,
        required: required ?? this.required,
        at: at ?? this.at,
        times: times ?? this.times,
        location: location ?? this.location,
        instructors: instructors ?? this.instructors,
      );

  factory Course.fromRawJson(String str) => Course.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        code: json['code'] as String?,
        title: json['title'] as String?,
        className: json['className'] as String?,
        group: json['group'] as String?,
        units: json['units'] as String?,
        hours: json['hours'] as String?,
        required: json['required'] as String?,
        at: json['at'] as String?,
        times: json['sectionTimes'] == null
            ? null
            : List<SectionTime>.from(
                (json['sectionTimes'] as List<dynamic>).map(
                  (x) => SectionTime.fromJson(x as Map<String, dynamic>),
                ),
              ),
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        instructors: json['instructors'] == null
            ? null
            : List<String>.from(
                (json['instructors'] as List<dynamic>).map(
                  (dynamic x) => x,
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'title': title,
        'className': className,
        'group': group,
        'units': units,
        'hours': hours,
        'required': required,
        'at': at,
        'sectionTimes': times == null
            ? null
            : List<dynamic>.from(times!.map((x) => x.toJson())),
        'location': location == null ? null : location!.toJson(),
        'instructors': instructors == null
            ? null
            : List<dynamic>.from(instructors!.map((x) => x)),
      };

  String getInstructors() {
    ///Use https://dart-lang.github.io/linter/lints/use_string_buffers.html
    final buffer = StringBuffer();
    if (instructors!.isNotEmpty) {
      buffer.write(instructors![0]);
      for (var i = 1; i < instructors!.length; i++) {
        buffer.write(',${instructors![i]}');
      }
    }
    return buffer.toString();
  }

  String getTimesShortName(List<TimeCode>? timeCode) {
    String text = '';
    if ((times?.length ?? 0) == 0) return text;
    int startIndex = -1;
    int repeat = 0;
    final len = times?.length ?? 0;
    for (var i = 0; i < len; i++) {
      final time = times![i];
      if (startIndex != -1 &&
          time.index! - 1 == times![i - 1].index &&
          time.weekday == times![i - 1].weekday) {
        repeat++;
        if (i == len - 1 ||
            times![i + 1].weekday != times![i].weekday ||
            times![i + 1].index != times![i].index! + 1) {
          final endTime = times![startIndex + repeat];
          text += '-'
              '${timeCode![endTime.index!].title}';
          repeat = 0;
          startIndex = -1;
        }
      } else {
        startIndex = i;
        text += '${text.isEmpty ? '' : ' '}'
            '(${ApLocalizations.current.weekdaysCourse[time.weekDayIndex]}) '
            '${timeCode![time.index!].title}';
      }
    }
    return text;
  }
}

class Location {
  Location({
    this.room,
    this.building,
  });

  String? room;
  String? building;

  Location copyWith({
    String? room,
    String? building,
  }) =>
      Location(
        room: room ?? this.room,
        building: building ?? this.building,
      );

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        room: json['room'] as String?,
        building: json['building'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'room': room,
        'building': building,
      };

  @override
  String toString() {
    return '${building ?? ''}${room ?? ''}';
  }
}

class SectionTime {
  SectionTime({
    this.weekday,
    this.index,
  });

  ///The day of the week [DateTime.monday]..[DateTime.sunday].
  ///In accordance with ISO 8601 a week starts with Monday,
  /// which has the value 1.
  int? weekday;

  /// index of [CourseData.timeCodes]
  int? index;

  int get weekDayIndex => weekday! - 1;

  SectionTime copyWith({
    int? weekDay,
    int? index,
  }) =>
      SectionTime(
        weekday: weekDay ?? weekday,
        index: index ?? this.index,
      );

  factory SectionTime.fromRawJson(String str) => SectionTime.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory SectionTime.fromJson(Map<String, dynamic> json) => SectionTime(
        weekday: json['weekday'] as int,
        index: json['index'] as int,
      );

  Map<String, dynamic> toJson() => {
        'weekday': weekday,
        'index': index,
      };
}

class TimeCode {
  TimeCode({
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  String title;
  String startTime;
  String endTime;

  TimeCode copyWith({
    String? title,
    String? startTime,
    String? endTime,
  }) =>
      TimeCode(
        title: title ?? this.title,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );

  factory TimeCode.fromRawJson(String str) =>
      TimeCode.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory TimeCode.fromJson(Map<String, dynamic> json) => TimeCode(
        title: json['title'] as String,
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
      };
}

extension TimeCodeExtension on List<TimeCode> {
  int getIndex(String section) {
    for (int i = 0; i < length; i++) {
      if (this[i].title == section) return i;
    }
    return -1;
  }
}
