import 'dart:async';
import 'dart:convert';

import 'package:ap_common_core/ap_common_core.dart';
import 'package:flutter/services.dart';

class ApCommonPlugin {
  static const MethodChannel _channel = MethodChannel('ap_common_plugin');

  static Future<String?> get platformVersion async {
    final String? version =
        await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// Configure the plugin with platform-specific settings.
  ///
  /// [appGroupId] is required on iOS for sharing data with the
  /// WidgetKit extension via App Group UserDefaults.
  /// It is ignored on Android.
  static Future<void> configure({required String appGroupId}) async {
    await _channel.invokeMethod<void>('configure', <String, String>{
      'appGroupId': appGroupId,
    });
  }

  /// Update the course widget with the given [courseData].
  ///
  /// On Android, writes to SharedPreferences and triggers widget
  /// refresh.
  /// On iOS, writes to App Group UserDefaults so the WidgetKit
  /// extension can read it.
  static Future<void> updateCourseWidget(CourseData courseData) async {
    await _channel.invokeMethod<void>(
      'updateCourseWidget',
      jsonEncode(courseData.toJson()),
    );
  }

  /// Clear the course widget data.
  static Future<void> clearCourseWidget() async {
    await _channel.invokeMethod<void>('clearCourseWidget');
  }

  /// Update the student ID widget with user info.
  ///
  /// Sends a JSON object with `id`, `name`, `department`, and
  /// `className` fields to the native widget.
  static Future<void> updateUserInfoWidget(UserInfo userInfo) async {
    await _channel.invokeMethod<void>(
      'updateUserInfoWidget',
      jsonEncode(userInfo.toJson()),
    );
  }

  /// Clear the student ID widget data.
  static Future<void> clearUserInfoWidget() async {
    await _channel.invokeMethod<void>('clearUserInfoWidget');
  }

  /// Update the course widget with fake data for testing.
  ///
  /// Injects two courses starting 30 and 90 minutes from now
  /// on today's weekday. Only intended for debug builds.
  static Future<void> setFakeCourseWidget() async {
    final DateTime now = DateTime.now();
    final DateTime t1 = now.add(const Duration(minutes: 30));
    final DateTime t2 = now.add(const Duration(minutes: 90));
    final DateTime t3 = now.add(const Duration(minutes: 150));
    final DateTime t4 = now.add(const Duration(minutes: 210));
    String fmt(DateTime dt) => '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
    await updateCourseWidget(
      CourseData(
        courses: <Course>[
          Course(
            code: 'TEST001',
            title: '測試課程 A',
            className: 'Test',
            instructors: <String>['測試教師'],
            location: const Location(
              building: 'EC',
              room: '5012',
            ),
            times: <SectionTime>[
              SectionTime(weekday: now.weekday, index: 0),
              SectionTime(weekday: now.weekday, index: 1),
            ],
          ),
          Course(
            code: 'TEST002',
            title: '測試課程 B',
            className: 'Test',
            instructors: <String>['測試教師'],
            location: const Location(
              building: 'EC',
              room: '4008',
            ),
            times: <SectionTime>[
              SectionTime(weekday: now.weekday, index: 2),
            ],
          ),
        ],
        timeCodes: <TimeCode>[
          TimeCode(
            title: 'T1',
            startTime: fmt(t1),
            endTime: fmt(t2),
          ),
          TimeCode(
            title: 'T2',
            startTime: fmt(t2),
            endTime: fmt(t3),
          ),
          TimeCode(
            title: 'T3',
            startTime: fmt(t3),
            endTime: fmt(t4),
          ),
        ],
      ),
    );
  }
}
