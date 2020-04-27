import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAnalyticsUtils extends AnalyticsUtils {
  static FirebaseAnalyticsUtils _instance;
  static FirebaseAnalytics analytics;

  static FirebaseAnalyticsUtils get instance {
    if (_instance == null) {
      _instance = FirebaseAnalyticsUtils();
    }
    return _instance;
  }

  Future<void> setCurrentScreen(
    String screenName,
    String screenClassOverride,
  ) async {
    await analytics?.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenClassOverride,
    );
  }

  Future<void> setUserId(String id) async {
    await analytics?.setUserId(id);
    debugPrint('setUserId succeeded');
  }

  Future<void> setUserProperty(
    String name,
    String value,
  ) async {
    await analytics?.setUserProperty(
      name: name,
      value: value,
    );
    debugPrint('setUserProperty succeeded');
  }

  Future<void> logUserInfo(String department) async {
    await analytics?.logEvent(
      name: 'user_info',
      parameters: <String, dynamic>{
        'department': department,
      },
    );
    debugPrint('setUserProperty succeeded');
  }

  Future<void> logApiEvent(String type, int status,
      {String message = ''}) async {
    await analytics?.logEvent(
      name: 'ap_api',
      parameters: <String, dynamic>{
        'type': type,
        'status': status,
        'message': message,
      },
    );
    debugPrint('logEvent succeeded');
  }

  Future<void> logCalculateUnits(double seconds) async {
    await analytics?.logEvent(
      name: 'calculate_units_time',
      parameters: <String, dynamic>{
        'time': seconds,
      },
    );
    debugPrint('log CalculateUnits succeeded');
  }

  Future<void> logTimeEvent(String name, double seconds) async {
    await analytics?.logEvent(
      name: name,
      parameters: <String, dynamic>{
        'time': seconds,
      },
    );
    debugPrint('log TimeEvent succeeded');
  }

  Future<void> logCaptchaErrorEvent(String tag, int count) async {
    await analytics?.logEvent(
      name: '${tag}_captcha_error',
      parameters: <String, dynamic>{
        'count': count,
      },
    );
    debugPrint('log CaptchaErrorEvent succeeded');
  }

  Future<void> logAction(String name, String action,
      {String message = ''}) async {
    await analytics?.logEvent(
      name: name ?? '',
      parameters: <String, dynamic>{
        'action': action ?? '',
        'message': message ?? '',
      },
    );
  }
}
