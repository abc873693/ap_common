import 'dart:async';
import 'dart:io';

import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common_firebase/constants/fiirebase_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:firebase_analytics/firebase_analytics.dart';

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

  Future<void> logEvent(String name) async {
    await analytics?.logEvent(name: name ?? '');
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

  Future<void> logLeavesImageSize(File source) async {
    await analytics?.logEvent(
      name: 'leaves_image_pick',
      parameters: <String, dynamic>{
        'image_size': source.lengthSync() / 1024 / 1024,
      },
    );
  }

  Future<void> logLeavesImageCompressSize(File source, File result) async {
    await analytics?.logEvent(
      name: 'leaves_image_compress',
      parameters: <String, dynamic>{
        'image_original_size': source.lengthSync() / 1024 / 1024,
        'image_compress_size': result.lengthSync() / 1024 / 1024,
      },
    );
  }

  void logThemeEvent(ThemeMode themeMode) async {
    Brightness brightness;
    switch (themeMode) {
      case ThemeMode.system:
        brightness = WidgetsBinding.instance.window.platformBrightness;
        break;
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
      default:
        brightness = Brightness.dark;
        break;
    }
    setUserProperty(
      FirebaseConstants.THEME,
      brightness == Brightness.light ? ApTheme.LIGHT : ApTheme.DARK,
    );
  }
}
