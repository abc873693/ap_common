import 'dart:convert';
import 'dart:developer';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_data.freezed.dart';
part 'course_data.g.dart';

@freezed
abstract class CourseData with _$CourseData {

  const factory CourseData({
    required List<Course> courses,
    required List<TimeCode> timeCodes,
  }) = _CourseData;
  const CourseData._();

  factory CourseData.empty() => const CourseData(
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

  bool get hasHoliday {
    for (final Course course in courses) {
      if (course.times.isEmpty) continue;
      for (final SectionTime section in course.times) {
        if (section.weekday == DateTime.saturday ||
            section.weekday == DateTime.sunday) {
          return true;
        }
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

  /// Merge user-created custom courses into this course data.
  ///
  /// Returns a new [CourseData] containing both the original API
  /// courses and the custom courses. [timeCodes] are kept as-is.
  CourseData mergeCustom(List<Course> customCourses) {
    if (customCourses.isEmpty) return this;
    return CourseData(
      courses: <Course>[...courses, ...customCourses],
      timeCodes: timeCodes,
    );
  }

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

@freezed
abstract class Course with _$Course {

  const factory Course({
    required String code,
    required String title,
    String? className,
    String? group,
    String? units,
    String? hours,
    String? required,
    String? at,
    @JsonKey(name: 'sectionTimes') required List<SectionTime> times,
    Location? location,
    required List<String> instructors,
  }) = _Course;
  const Course._();

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  factory Course.fromRawJson(String str) => Course.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

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
}

@freezed
abstract class Location with _$Location {

  const factory Location({
    required String room,
    required String building,
  }) = _Location;
  const Location._();

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  factory Location.fromRawJson(String str) => Location.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());

  @override
  String toString() {
    return '$building$room';
  }
}

@freezed
abstract class SectionTime with _$SectionTime {

  const factory SectionTime({
    ///The day of the week [DateTime.monday]..[DateTime.sunday].
    ///In accordance with ISO 8601 a week starts with Monday,
    /// which has the value 1.
    required int weekday,

    /// index of [CourseData.timeCodes]
    required int index,
  }) = _SectionTime;
  const SectionTime._();

  factory SectionTime.fromJson(Map<String, dynamic> json) =>
      _$SectionTimeFromJson(json);

  factory SectionTime.fromRawJson(String str) => SectionTime.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  int get weekDayIndex => weekday - 1;

  String toRawJson() => jsonEncode(toJson());
}

@freezed
abstract class TimeCode with _$TimeCode {

  const factory TimeCode({
    required String title,
    required String startTime,
    required String endTime,
  }) = _TimeCode;
  const TimeCode._();

  factory TimeCode.fromJson(Map<String, dynamic> json) =>
      _$TimeCodeFromJson(json);

  factory TimeCode.fromRawJson(String str) => TimeCode.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

extension TimeCodeExtension on List<TimeCode> {
  int getIndex(String section) {
    for (int i = 0; i < length; i++) {
      if (this[i].title == section) return i;
    }
    return -1;
  }
}
