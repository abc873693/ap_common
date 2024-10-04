import 'dart:convert';
import 'dart:developer';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/models/course_data.dart';
import 'package:ap_common_core/src/utilities/notification_util.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:json_annotation/json_annotation.dart';

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
    final String rawString = PreferenceUtil.instance.getString(
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
    final String semester = PreferenceUtil.instance.getString(
      ApConstants.currentSemesterCode,
      ApConstants.semesterLatest,
    );
    final String rawString = PreferenceUtil.instance.getString(
      '${ApConstants.packageName}.'
          'course_notify_data_$semester',
      '',
    );
    log('loadCurrent $rawString', name: 'ap_common');
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
    PreferenceUtil.instance.setString(
      '${ApConstants.packageName}'
      '.course_notify_data_$tag',
      toRawJson(),
    );
  }

  //TODO: revert for i18n implement
  // void update(BuildContext context, String tag, CourseData courseData) {
  //   final String key = '${ApConstants.packageName}.course_notify_data_$tag';
  //   final ApLocalizations ap = ApLocalizations.of(context);
  //   final CourseNotifyData cache = CourseNotifyData.load(key);
  //   for (final CourseNotify courseNotify in cache.data) {
  //     for (final Course courseDetail in courseData.courses) {
  //       if (courseDetail.code == courseNotify.code) {
  //         courseNotify.title = sprintf(ap.courseNotifyContent, <String?>[
  //           courseNotify.title,
  //           if (courseNotify.location == null || courseNotify.location!.isEmpty)
  //             ap.courseNotifyUnknown
  //           else
  //             courseNotify.location,
  //         ]);
  //       }
  //     }
  //   }
  //   PreferenceUtil.instance.setString(
  //     key,
  //     toRawJson(),
  //   );
  // }

  static void clearOldVersionNotification({
    required String tag,
    required String newTag,
  }) {
    final String rawString = PreferenceUtil.instance.getString(
      '${ApConstants.packageName}.'
          'course_notify_data_$tag',
      '',
    );
    log('clearOldVersionNotification $rawString', name: 'ap_common');
    if (rawString.isNotEmpty) {
      final CourseNotifyData courseNotifyData =
          CourseNotifyData.fromRawJson(rawString);
      for (final CourseNotify element in courseNotifyData.data) {
        NotificationUtil.instance.cancelNotify(id: element.id);
      }
      courseNotifyData.data.clear();
      courseNotifyData.tag = newTag;
      courseNotifyData.save();
    }
    PreferenceUtil.instance
        .remove('${ApConstants.packageName}.course_notify_data_$tag');
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
