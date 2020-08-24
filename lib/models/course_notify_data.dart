import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/generated/l10n.dart';
import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/generated/l10n.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:sprintf/sprintf.dart';

class CourseNotifyData {
  static const VERSION = 1;
  static const INITIAL_ID = 1;

  int version;
  int lastId;
  List<CourseNotify> data;

  CourseNotifyData({
    this.version = VERSION,
    this.lastId = INITIAL_ID,
    this.data,
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
        "version": version == null ? null : version,
        "lastId": lastId == null ? null : lastId,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };

  CourseNotify getByCode(String code, String startTime, int weekIndex) {
    for (var value in data) {
      if (value.code == code &&
          value.startTime == startTime &&
          value.weeklyIndex == weekIndex) return value;
    }
    return null;
  }

  void save(String tag) {
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
      courseData?.courses?.forEach((courseDetail) {
        if (courseDetail.code == courseNotify.code) {
          courseNotify.title = sprintf(ap.courseNotifyContent, [
            courseNotify.title,
            courseNotify.location.isEmpty
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

  factory CourseNotifyData.load(String tag) {
    String rawString = Preferences.getString(
      '${ApConstants.PACKAGE_NAME}.'
          'course_notify_data_$tag',
      '',
    );
    if (rawString == '')
      return CourseNotifyData(data: []);
    else
      return CourseNotifyData.fromRawJson(rawString);
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
    if (rawString == '')
      return CourseNotifyData(data: []);
    else
      return CourseNotifyData.fromRawJson(rawString);
  }
}

class CourseNotify {
  int id;
  String title;
  String location;
  String code;
  int weeklyIndex;
  String startTime;

  CourseNotify({
    this.id,
    this.title,
    this.location,
    this.code,
    this.weeklyIndex,
    this.startTime,
  });

  factory CourseNotify.fromRawJson(String str) =>
      CourseNotify.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseNotify.fromJson(Map<String, dynamic> json) => CourseNotify(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        location: json["location"] == null ? null : json["location"],
        code: json["code"] == null ? null : json["code"],
        weeklyIndex: json["weeklyIndex"] == null ? null : json["weeklyIndex"],
        startTime: json["startTime"] == null ? null : json["startTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "location": location == null ? null : location,
        "code": code == null ? null : code,
        "weeklyIndex": weeklyIndex == null ? null : weeklyIndex,
        "startTime": startTime == null ? null : startTime,
      };

  factory CourseNotify.fromCourse({
    @required int id,
    @required int weeklyIndex,
    @required Course course,
    @required CourseDetail courseDetail,
  }) {
    return CourseNotify(
      id: id,
      title: course.title,
      code: courseDetail.code,
      startTime: course.date?.startTime,
      weeklyIndex: weeklyIndex,
      location: course.location.toString(),
    );
  }
}
