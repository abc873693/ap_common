import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:sprintf/sprintf.dart';

class CourseNotifyData {
  // ignore: constant_identifier_names
  static const VERSION = 2;
  static const initialId = 1;

  late int version;
  late int lastId;
  List<CourseNotify> data;

  String? tag;

  CourseNotifyData({
    this.version = VERSION,
    this.lastId = initialId,
    this.data = const [],
  });

  factory CourseNotifyData.fromRawJson(String str) => CourseNotifyData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory CourseNotifyData.fromJson(Map<String, dynamic> json) =>
      CourseNotifyData(
        version: json['version'] as int,
        lastId: json['lastId'] as int,
        data: json['data'] == null
            ? []
            : List<CourseNotify>.from(
                (json['data'] as List<dynamic>).map(
                  (x) => CourseNotify.fromJson(x as Map<String, dynamic>),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        'version': version,
        'lastId': lastId,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };

  CourseNotify? getByCode(String? code, String? startTime, int weekIndex) {
    for (final value in data) {
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
    final key = '${ApConstants.packageName}.course_notify_data_$tag';
    final ap = ApLocalizations.of(context);
    final cache = CourseNotifyData.load(key);
    for (final courseNotify in cache.data) {
      for (final courseDetail in courseData.courses!) {
        if (courseDetail.code == courseNotify.code) {
          courseNotify.title = sprintf(ap.courseNotifyContent, [
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

  factory CourseNotifyData.load(String? tag) {
    final String rawString = Preferences.getString(
      '${ApConstants.packageName}.'
          'course_notify_data_$tag',
      '',
    );
    if (rawString == '') {
      return CourseNotifyData(data: [])..tag = tag;
    } else {
      return CourseNotifyData.fromRawJson(rawString)..tag = tag;
    }
  }

  factory CourseNotifyData.loadCurrent() {
    final semester = Preferences.getString(
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
      return CourseNotifyData(data: [])..tag = semester;
    } else {
      return CourseNotifyData.fromRawJson(rawString)..tag = semester;
    }
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
      final courseNotifyData = CourseNotifyData.fromRawJson(rawString);
      for (final element in courseNotifyData.data) {
        NotificationUtils.cancelCourseNotify(id: element.id);
      }
      courseNotifyData.data.clear();
      courseNotifyData.tag = newTag;
      courseNotifyData.save();
    }
    Preferences.remove('${ApConstants.packageName}.course_notify_data_$tag');
  }
}

class CourseNotify {
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

  CourseNotify({
    required this.id,
    required this.weekday,
    required this.startTime,
    this.title,
    this.location,
    this.code,
  });

  factory CourseNotify.fromRawJson(String str) => CourseNotify.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory CourseNotify.fromJson(Map<String, dynamic> json) => CourseNotify(
        id: json['id'] as int,
        title: json['title'] as String,
        location: json['location'] as String,
        code: json['code'] as String,
        weekday: json['weekday'] as int? ??
            (json['weeklyIndex'] == null
                ? 1
                : (json['weeklyIndex'] as int) + 1),
        startTime: json['startTime'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'code': code,
        'weekday': weekday,
        'startTime': startTime,
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
