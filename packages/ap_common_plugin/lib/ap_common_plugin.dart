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
}
