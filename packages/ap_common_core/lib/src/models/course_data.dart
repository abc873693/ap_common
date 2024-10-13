import 'dart:convert';
import 'dart:developer';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_data.g.dart';

@JsonSerializable()
class CourseData {
  CourseData({
    required this.courses,
    required this.timeCodes,
  });

  factory CourseData.empty() => CourseData(
        courses: <Course>[],
        timeCodes: <TimeCode>[],
      );

  factory CourseData.fromJson(Map<String, dynamic> json) =>
      _$CourseDataFromJson(json);

  factory CourseData.fromRawJson(String str) => CourseData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  static CourseData? load(String tag) {
    final String rawString = PreferenceUtil.instance.getString(
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

  final List<Course> courses;
  final List<TimeCode> timeCodes;

  bool get hasHoliday {
    for (final Course course in courses) {
      if (course.times.isEmpty) continue;
      for (final SectionTime section in course.times) {
        if (section.weekday == DateTime.saturday ||
            section.weekday == DateTime.sunday) return true;
      }
    }
    return false;
  }

  int get maxTimeCodeIndex {
    int index = 10;
    for (final Course course in courses) {
      if (course.times.isEmpty) continue;
      for (final SectionTime time in course.times) {
        if (time.index > index) {
          index = time.index;
        }
      }
    }
    return index;
  }

  int get minTimeCodeIndex {
    int index = 10;
    for (final Course course in courses) {
      if (course.times.isEmpty) continue;
      for (final SectionTime time in course.times) {
        if (time.index < index) {
          index = time.index;
        }
      }
    }
    return index < 10 ? 0 : index;
  }

  CourseData copyWith({
    List<Course>? courses,
    List<TimeCode>? timeCodes,
  }) =>
      CourseData(
        courses: courses ?? this.courses,
        timeCodes: timeCodes ?? this.timeCodes,
      );

  Map<String, dynamic> toJson() => _$CourseDataToJson(this);

  String toRawJson() => jsonEncode(toJson());

  void save(String tag) {
    PreferenceUtil.instance.setString(
      '${ApConstants.packageName}'
      '.course_data_$tag',
      toRawJson(),
    );
  }

  static Future<void> migrateFrom0_10() async {
    PreferenceUtil.instance.getKeys().forEach((String key) {
      if (key.contains('course_data')) {
        log(key);
        PreferenceUtil.instance.remove(key);
      }
    });
  }

  List<List<Course>> get weekDayCourseList {
    final List<List<Course>> list = <List<Course>>[
      <Course>[],
      <Course>[],
      <Course>[],
      <Course>[],
      <Course>[],
      if (hasHoliday) ...<List<Course>>[
        <Course>[],
        <Course>[],
      ],
    ];
    for (final Course course in courses) {
      for (final SectionTime time in course.times) {
        for (int i = 0; i < timeCodes.length; i++) {
          list[time.weekday - 1].add(course);
        }
      }
    }
    return list;
  }

  int getTimeCodeIndex(String section) {
    for (int i = 0; i < timeCodes.length; i++) {
      if (timeCodes[i].title == section) return i;
    }
    return -1;
  }
}

@JsonSerializable()
class Course {
  Course({
    required this.code,
    required this.title,
    this.className,
    this.group,
    required this.units,
    this.hours,
    this.required,
    this.at,
    required this.times,
    this.location,
    required this.instructors,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  factory Course.fromRawJson(String str) => Course.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  final String code;
  final String title;

  //TODO nullable evaluation
  final String? className;
  final String? group;

  //TODO nullable evaluation
  final String? units;
  final String? hours;
  final String? required;
  final String? at;
  @JsonKey(name: 'sectionTimes')
  final List<SectionTime> times;
  final Location? location;
  final List<String> instructors;

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  String toRawJson() => jsonEncode(toJson());

  String getInstructors() {
    ///Use https://dart-lang.github.io/linter/lints/use_string_buffers.html
    final StringBuffer buffer = StringBuffer();
    if (instructors.isNotEmpty) {
      buffer.write(instructors[0]);
      for (int i = 1; i < instructors.length; i++) {
        buffer.write(',${instructors[i]}');
      }
    }
    return buffer.toString();
  }

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
}

@JsonSerializable()
class Location {
  Location({
    required this.room,
    required this.building,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  factory Location.fromRawJson(String str) => Location.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  final String room;
  final String building;

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  String toRawJson() => jsonEncode(toJson());

  Location copyWith({
    String? room,
    String? building,
  }) =>
      Location(
        room: room ?? this.room,
        building: building ?? this.building,
      );

  @override
  String toString() {
    return '$building$room';
  }
}

@JsonSerializable()
class SectionTime {
  SectionTime({
    required this.weekday,
    required this.index,
  });

  factory SectionTime.fromJson(Map<String, dynamic> json) =>
      _$SectionTimeFromJson(json);

  factory SectionTime.fromRawJson(String str) => SectionTime.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  ///The day of the week [DateTime.monday]..[DateTime.sunday].
  ///In accordance with ISO 8601 a week starts with Monday,
  /// which has the value 1.
  final int weekday;

  /// index of [CourseData.timeCodes]
  final int index;

  int get weekDayIndex => weekday - 1;

  Map<String, dynamic> toJson() => _$SectionTimeToJson(this);

  String toRawJson() => jsonEncode(toJson());

  SectionTime copyWith({
    int? weekDay,
    int? index,
  }) =>
      SectionTime(
        weekday: weekDay ?? weekday,
        index: index ?? this.index,
      );
}

@JsonSerializable()
class TimeCode {
  TimeCode({
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  factory TimeCode.fromJson(Map<String, dynamic> json) =>
      _$TimeCodeFromJson(json);

  factory TimeCode.fromRawJson(String str) => TimeCode.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  final String title;
  final String startTime;
  final String endTime;

  Map<String, dynamic> toJson() => _$TimeCodeToJson(this);

  String toRawJson() => jsonEncode(toJson());

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
}

extension TimeCodeExtension on List<TimeCode> {
  int getIndex(String section) {
    for (int i = 0; i < length; i++) {
      if (this[i].title == section) return i;
    }
    return -1;
  }
}
