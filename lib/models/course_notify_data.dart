import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:sprintf/sprintf.dart';

class CourseNotifyData {
  static const VERSION = 2;
  static const INITIAL_ID = 1;

  late int version;
  late int lastId;
  List<CourseNotify> data;

  String? tag;

  CourseNotifyData({
    this.version = VERSION,
    this.lastId = INITIAL_ID,
    this.data = const [],
  });

  factory CourseNotifyData.fromRawJson(String str) =>
      CourseNotifyData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseNotifyData.fromJson(Map<String, dynamic> json) =>
      CourseNotifyData(
        version: json["version"] == null ? null : json["version"],
        lastId: json["lastId"] == null ? null : json["lastId"],
        data: json["data"] == null
            ? []
            : List<CourseNotify>.from(
                json["data"].map((x) => CourseNotify.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "lastId": lastId,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  CourseNotify? getByCode(String? code, String? startTime, int weekIndex) {
    for (var value in data) {
      if (value.code == code &&
          value.startTime == startTime &&
          value.weekday == weekIndex) return value;
    }
    return null;
  }

  void save() {
    Preferences.setString(
      '${ApConstants.PACKAGE_NAME}'
      '.course_notify_data_$tag',
      this.toRawJson(),
    );
  }

  void update(BuildContext context, String tag, CourseData courseData) {
    final key = '${ApConstants.PACKAGE_NAME}.course_notify_data_$tag';
    final ap = ApLocalizations.of(context);
    var cache = CourseNotifyData.load(key);
    cache.data.forEach((courseNotify) {
      courseData.courses?.forEach((courseDetail) {
        if (courseDetail.code == courseNotify.code) {
          courseNotify.title = sprintf(ap.courseNotifyContent, [
            courseNotify.title,
            courseNotify.location == null || courseNotify.location!.isEmpty
                ? ap.courseNotifyUnknown
                : courseNotify.location
          ]);
        }
      });
    });
    Preferences.setString(
      key,
      this.toRawJson(),
    );
  }

  factory CourseNotifyData.load(String? tag) {
    String rawString = Preferences.getString(
      '${ApConstants.PACKAGE_NAME}.'
          'course_notify_data_$tag',
      '',
    );
    if (rawString == '')
      return CourseNotifyData(data: [])..tag = tag;
    else
      return CourseNotifyData.fromRawJson(rawString)..tag = tag;
  }

  factory CourseNotifyData.loadCurrent() {
    var semester = Preferences.getString(
      ApConstants.CURRENT_SEMESTER_CODE,
      ApConstants.SEMESTER_LATEST,
    );
    String rawString = Preferences.getString(
      '${ApConstants.PACKAGE_NAME}.'
          'course_notify_data_$semester',
      '',
    );
    print(rawString);
    if (rawString == '')
      return CourseNotifyData(data: [])..tag = semester;
    else
      return CourseNotifyData.fromRawJson(rawString)..tag = semester;
  }

  static void clearOldVersionNotification({
    required String tag,
    required String newTag,
  }) {
    String rawString = Preferences.getString(
      '${ApConstants.PACKAGE_NAME}.'
          'course_notify_data_$tag',
      '',
    );
    print(rawString);
    if (rawString.isNotEmpty) {
      var courseNotifyData = CourseNotifyData.fromRawJson(rawString);
      courseNotifyData.data.forEach(
          (element) => NotificationUtils.cancelCourseNotify(id: element.id));
      courseNotifyData.data.clear();
      courseNotifyData.tag = newTag;
      courseNotifyData.save();
    }
    Preferences.remove('${ApConstants.PACKAGE_NAME}.course_notify_data_$tag');
  }
}

class CourseNotify {
  int id;
  String? title;
  String? location;
  String? code;

  ///The day of the week [DateTime.monday]..[DateTime.sunday].
  ///In accordance with ISO 8601 a week starts with Monday, which has the value 1.
  int weekday;

  String startTime;

  int get weekdayIndex => weekday - 1;

  CourseNotify({
    required this.id,
    required this.weekday,
    required this.startTime,
    this.title,
    this.location,
    this.code,
  });

  factory CourseNotify.fromRawJson(String str) =>
      CourseNotify.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseNotify.fromJson(Map<String, dynamic> json) => CourseNotify(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        location: json["location"] == null ? null : json["location"],
        code: json["code"] == null ? null : json["code"],
        weekday: json["weekday"] == null
            ? (json["weeklyIndex"] == null ? null : json["weeklyIndex"] + 1)
            : json["weekday"],
        startTime: json["startTime"] == null ? null : json["startTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title == null ? null : title,
        "location": location == null ? null : location,
        "code": code == null ? null : code,
        "weekday": weekday,
        "startTime": startTime,
      };

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
}
