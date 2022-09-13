import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprintf/sprintf.dart';

part 'course_notify_data.g.dart';

@JsonSerializable()
class CourseNotifyData {
  CourseNotifyData({
    this.version = 2,
    this.lastId = 1,
    this.data = const <CourseNotify>[],
  });

  factory CourseNotifyData.fromJson(Map<String, dynamic> json) =>
      _$CourseNotifyDataFromJson(json);

  factory CourseNotifyData.fromRawJson(String str) => CourseNotifyData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory CourseNotifyData.load(String? tag) {
    final String rawString = Preferences.getString(
      '${ApConstants.packageName}.'
          'course_notify_data_$tag',
      '',
    );
    if (rawString == '') {
      return CourseNotifyData(data: <CourseNotify>[])..tag = tag;
    } else {
      return CourseNotifyData.fromRawJson(rawString)..tag = tag;
    }
  }

  factory CourseNotifyData.loadCurrent() {
    final String semester = Preferences.getString(
      ApConstants.currentSemesterCode,
      ApConstants.semesterLatest,
    );
    final String rawString = Preferences.getString(
      '${ApConstants.packageName}.'
          'course_notify_data_$semester',
      '',
    );
    debugPrint(rawString);
    if (rawString == '') {
      return CourseNotifyData(data: <CourseNotify>[])..tag = semester;
    } else {
      return CourseNotifyData.fromRawJson(rawString)..tag = semester;
    }
  }

  // ignore: constant_identifier_names
  static const int VERSION = 2;
  static const int initialId = 1;

  int version;
  int lastId;
  List<CourseNotify> data;

  String? tag;

  Map<String, dynamic> toJson() => _$CourseNotifyDataToJson(this);

  String toRawJson() => jsonEncode(toJson());

  CourseNotify? getByCode(String? code, String? startTime, int weekIndex) {
    for (final CourseNotify value in data) {
      if (value.code == code &&
          value.startTime == startTime &&
          value.weekday == weekIndex) return value;
    }
    return null;
  }

  void save() {
    Preferences.setString(
      '${ApConstants.packageName}'
      '.course_notify_data_$tag',
      toRawJson(),
    );
  }

  void update(BuildContext context, String tag, CourseData courseData) {
    final String key = '${ApConstants.packageName}.course_notify_data_$tag';
    final ApLocalizations ap = ApLocalizations.of(context);
    final CourseNotifyData cache = CourseNotifyData.load(key);
    for (final CourseNotify courseNotify in cache.data) {
      for (final Course courseDetail in courseData.courses!) {
        if (courseDetail.code == courseNotify.code) {
          courseNotify.title = sprintf(ap.courseNotifyContent, <String?>[
            courseNotify.title,
            if (courseNotify.location == null || courseNotify.location!.isEmpty)
              ap.courseNotifyUnknown
            else
              courseNotify.location
          ]);
        }
      }
    }
    Preferences.setString(
      key,
      toRawJson(),
    );
  }

  static void clearOldVersionNotification({
    required String tag,
    required String newTag,
  }) {
    final String rawString = Preferences.getString(
      '${ApConstants.packageName}.'
          'course_notify_data_$tag',
      '',
    );
    debugPrint(rawString);
    if (rawString.isNotEmpty) {
      final CourseNotifyData courseNotifyData =
          CourseNotifyData.fromRawJson(rawString);
      for (final CourseNotify element in courseNotifyData.data) {
        NotificationUtils.cancelCourseNotify(id: element.id);
      }
      courseNotifyData.data.clear();
      courseNotifyData.tag = newTag;
      courseNotifyData.save();
    }
    Preferences.remove('${ApConstants.packageName}.course_notify_data_$tag');
  }
}

@JsonSerializable()
class CourseNotify {
  CourseNotify({
    required this.id,
    required this.weekday,
    required this.startTime,
    this.title,
    this.location,
    this.code,
  });

  factory CourseNotify.fromCourse({
    required int id,
    required Course course,
    required int weekday,
    required TimeCode timeCode,
  }) {
    return CourseNotify(
      id: id,
      title: course.title,
      code: course.code,
      startTime: timeCode.startTime,
      weekday: weekday,
      location: course.location.toString(),
    );
  }

  factory CourseNotify.fromJson(Map<String, dynamic> json) =>
      _$CourseNotifyFromJson(json);

  factory CourseNotify.fromRawJson(String str) => CourseNotify.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  int id;
  String? title;
  String? location;
  String? code;

  ///The day of the week [DateTime.monday]..[DateTime.sunday].
  ///In accordance with ISO 8601 a week starts with Monday,
  /// which has the value 1.
  int weekday;

  String startTime;

  int get weekdayIndex => weekday - 1;

  Map<String, dynamic> toJson() => _$CourseNotifyToJson(this);

  String toRawJson() => jsonEncode(toJson());
}
