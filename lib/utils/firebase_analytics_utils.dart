import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ap_common/utils/analytics_utils.dart';

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
    print('setUserId succeeded');
  }

  Future<void> setUserProperty(
    String name,
    String value,
  ) async {
    await analytics?.setUserProperty(
      name: name,
      value: value,
    );
    print('setUserProperty succeeded');
  }

  Future<void> logUserInfo(String department) async {
    await analytics?.logEvent(
      name: 'user_info',
      parameters: <String, dynamic>{
        'department': department,
      },
    );
    print('setUserProperty succeeded');
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
    print('logEvent succeeded');
  }

  Future<void> logCalculateUnits(double seconds) async {
    await analytics?.logEvent(
      name: 'calculate_units_time',
      parameters: <String, dynamic>{
        'time': seconds,
      },
    );
    print('log CalculateUnits succeeded');
  }

  Future<void> logTimeEvent(String name, double seconds) async {
    await analytics?.logEvent(
      name: name,
      parameters: <String, dynamic>{
        'time': seconds,
      },
    );
    print('log TimeEvent succeeded');
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
