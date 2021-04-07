import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/l10n/l10n.dart';
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
    for (var course in courses!) {
      if (course.times == null) continue;
      for (var section in course.times!)
        if (section.weekday == DateTime.saturday ||
            section.weekday == DateTime.sunday) return true;
    }
    return false;
  }

  int? get maxTimeCodeIndex {
    int? index = 10;
    for (var course in courses!) {
      if (course.times == null) continue;
      for (var time in course.times!) {
        if (time.index! > index!) {
          index = time.index;
        }
      }
    }
    return index;
  }

  int? get minTimeCodeIndex {
    int? index = 10;
    for (var course in courses!) {
      if (course.times == null) continue;
      for (var time in course.times!) {
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

  factory CourseData.fromRawJson(String str) =>
      CourseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        courses: json["courses"] == null
            ? null
            : List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
        timeCodes: json["timeCodes"] == null
            ? null
            : List<TimeCode>.from(
                json["timeCodes"].map((x) => TimeCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "courses": courses == null
            ? null
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "timeCodes": timeCodes == null
            ? null
            : List<dynamic>.from(timeCodes!.map((x) => x.toJson())),
      };

  void save(String tag) {
    Preferences.setString(
      '${ApConstants.PACKAGE_NAME}'
      '.course_data_$tag',
      this.toRawJson(),
    );
  }

  static CourseData? load(String tag) {
    String rawString = Preferences.getString(
      '${ApConstants.PACKAGE_NAME}'
          '.course_data_$tag',
      '',
    );
    if (rawString == '')
      return null;
    else
      return CourseData.fromRawJson(rawString);
  }

  static migrateFrom0_10() async {
    Preferences.prefs?.getKeys().forEach((key) {
      if (key.contains('course_data')) {
        debugPrint(key);
        Preferences.remove(key);
      }
    });
  }

  List<List<Course>> get weekDayCourseList {
    List<List<Course>> list = [
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
    for (var course in courses!) {
      for (var time in course.times!) {
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

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        code: json["code"] == null ? null : json["code"],
        title: json["title"] == null ? null : json["title"],
        className: json["className"] == null ? null : json["className"],
        group: json["group"] == null ? null : json["group"],
        units: json["units"] == null ? null : json["units"],
        hours: json["hours"] == null ? null : json["hours"],
        required: json["required"] == null ? null : json["required"],
        at: json["at"] == null ? null : json["at"],
        times: json["sectionTimes"] == null
            ? null
            : List<SectionTime>.from(
                json["sectionTimes"].map((x) => SectionTime.fromJson(x))),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        instructors: json["instructors"] == null
            ? null
            : List<String>.from(json["instructors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "title": title == null ? null : title,
        "className": className == null ? null : className,
        "group": group == null ? null : group,
        "units": units == null ? null : units,
        "hours": hours == null ? null : hours,
        "required": required == null ? null : required,
        "at": at == null ? null : at,
        "sectionTimes": times == null
            ? null
            : List<dynamic>.from(times!.map((x) => x.toJson())),
        "location": location == null ? null : location!.toJson(),
        "instructors": instructors == null
            ? null
            : List<dynamic>.from(instructors!.map((x) => x)),
      };

  String getInstructors() {
    String text = "";
    if (instructors!.length > 0) {
      text += instructors![0];
      for (var i = 1; i < instructors!.length; i++)
        text += ",${instructors![i]}";
    }
    return text;
  }

  String getTimesShortName(List<TimeCode>? timeCode) {
    String text = '';
    if ((times?.length ?? 0) == 0) return text;
    int startIndex = -1, repeat = 0;
    final len = (times?.length ?? 0);
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
        text +=
            '${text.isEmpty ? '' : ' '}(${ApLocalizations.current.weekdaysCourse[time.weekDayIndex]}) '
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
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        room: json["room"] == null ? null : json["room"],
        building: json["building"] == null ? null : json["building"],
      );

  Map<String, dynamic> toJson() => {
        "room": room == null ? null : room,
        "building": building == null ? null : building,
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
  ///In accordance with ISO 8601 a week starts with Monday, which has the value 1.
  int? weekday;

  /// index of [CourseData.timeCodes]
  int? index;

  int get weekDayIndex => weekday! - 1;

  SectionTime copyWith({
    int? weekDay,
    String? index,
  }) =>
      SectionTime(
        weekday: weekDay ?? this.weekday,
        index: index as int? ?? this.index,
      );

  factory SectionTime.fromRawJson(String str) =>
      SectionTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SectionTime.fromJson(Map<String, dynamic> json) => SectionTime(
        weekday: json["weekday"] == null ? null : json["weekday"],
        index: json["index"] == null ? null : json["index"],
      );

  Map<String, dynamic> toJson() => {
        "weekday": weekday == null ? null : weekday,
        "index": index == null ? null : index,
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

extension TimeCodeExtension on List<TimeCode> {
  int getIndex(String section) {
    for (int i = 0; i < length; i++) {
      if (this[i].title == section) return i;
    }
    return -1;
  }
}
