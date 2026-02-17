import 'dart:convert';
import 'dart:developer';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/models/course_data.dart';

import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_notify_data.freezed.dart';
part 'course_notify_data.g.dart';

@freezed
abstract class CourseNotifyData with _$CourseNotifyData {
  const CourseNotifyData._();

  const factory CourseNotifyData({
    @Default(2) int version,
    @Default(1) int lastId,
    @Default(<CourseNotify>[]) List<CourseNotify> data,
    @JsonKey(includeToJson: false, includeFromJson: false) String? tag,
  }) = _CourseNotifyData;

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
      return CourseNotifyData(data: <CourseNotify>[], tag: tag);
    } else {
      return CourseNotifyData.fromRawJson(rawString).copyWith(tag: tag);
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
      return CourseNotifyData(data: <CourseNotify>[], tag: semester);
    } else {
      return CourseNotifyData.fromRawJson(rawString).copyWith(tag: semester);
    }
  }

  // ignore: constant_identifier_names
  static const int VERSION = 2;
  static const int initialId = 1;

  String toRawJson() => jsonEncode(toJson());

  CourseNotify? getByCode(String? code, String? startTime, int weekIndex) {
    for (final CourseNotify value in data) {
      if (value.code == code &&
          value.startTime == startTime &&
          value.weekday == weekIndex) {
        return value;
      }
    }
    return null;
  }

  void save([String? tag]) {
    final String? finalTag = tag ?? this.tag;
    PreferenceUtil.instance.setString(
      '${ApConstants.packageName}'
      '.course_notify_data_$finalTag',
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
}

@freezed
abstract class CourseNotify with _$CourseNotify {
  const CourseNotify._();

  const factory CourseNotify({
    required int id,

    ///The day of the week [DateTime.monday]..[DateTime.sunday].
    ///In accordance with ISO 8601 a week starts with Monday,
    /// which has the value 1.
    required int weekday,
    required String startTime,
    String? title,
    String? location,
    String? code,
  }) = _CourseNotify;

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

  int get weekdayIndex => weekday - 1;

  String toRawJson() => jsonEncode(toJson());
}
