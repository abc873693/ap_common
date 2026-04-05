import 'dart:convert';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/models/course_data.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';

/// Stores user-created custom courses separately from API data.
///
/// Custom courses are persisted per-semester and merged with
/// API [CourseData] at the UI layer via [CourseData.mergeCustom].
class CustomCourseData {
  CustomCourseData({
    List<Course>? courses,
    this.tag,
  }) : courses = courses ?? <Course>[];

  /// Load custom courses for the given semester [tag].
  factory CustomCourseData.load(String? tag) {
    final String raw = PreferenceUtil.instance.getString(
      '$_prefix$tag',
      '',
    );
    if (raw.isEmpty) {
      return CustomCourseData(tag: tag);
    }
    return CustomCourseData._fromRawJson(raw, tag);
  }

  factory CustomCourseData._fromRawJson(
    String raw,
    String? tag,
  ) {
    final Map<String, dynamic> map =
        json.decode(raw) as Map<String, dynamic>;
    final List<dynamic> list =
        map['courses'] as List<dynamic>? ?? <dynamic>[];
    return CustomCourseData(
      courses: list
          .map(
            (dynamic e) =>
                Course.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      tag: tag,
    );
  }

  /// The list of user-created courses.
  final List<Course> courses;

  /// Semester tag used for persistence key.
  final String? tag;

  static const String _prefix = '${ApConstants.packageName}'
      '.custom_course_data_';

  /// Prefix used to identify custom course codes.
  static const String customCodePrefix = 'custom_';

  // ------------------------------------------------------------------
  // Persistence
  // ------------------------------------------------------------------

  /// Save to SharedPreferences.
  void save([String? overrideTag]) {
    final String key = '$_prefix${overrideTag ?? tag}';
    PreferenceUtil.instance.setString(key, _toRawJson());
  }

  // ------------------------------------------------------------------
  // CRUD helpers (return new instances for immutability)
  // ------------------------------------------------------------------

  /// Add a course and return an updated instance.
  CustomCourseData add(Course course) {
    return CustomCourseData(
      courses: <Course>[...courses, course],
      tag: tag,
    );
  }

  /// Remove a course by [code] and return an updated instance.
  CustomCourseData remove(String code) {
    return CustomCourseData(
      courses: courses
          .where((Course c) => c.code != code)
          .toList(),
      tag: tag,
    );
  }

  /// Replace a course matching [code] and return an updated instance.
  CustomCourseData update(String code, Course updated) {
    return CustomCourseData(
      courses: courses
          .map((Course c) => c.code == code ? updated : c)
          .toList(),
      tag: tag,
    );
  }

  /// Whether a course [code] belongs to the custom set.
  bool contains(String code) =>
      courses.any((Course c) => c.code == code);

  // ------------------------------------------------------------------
  // Serialization
  // ------------------------------------------------------------------

  String _toRawJson() => jsonEncode(
        <String, dynamic>{
          'courses': courses
              .map((Course c) => c.toJson())
              .toList(),
        },
      );

  /// Generate a unique course code for a new custom course.
  static String generateCode() =>
      '$customCodePrefix${DateTime.now().microsecondsSinceEpoch}';
}

/// Extension to check whether a [Course] is user-created.
extension CustomCourseExtension on Course {
  /// Returns `true` if this course was added by the user.
  bool get isCustomCourse =>
      code.startsWith(CustomCourseData.customCodePrefix);
}
