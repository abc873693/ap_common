import 'dart:async';
import 'dart:io';

import 'package:ap_common/config/analytics_constants.dart';
import 'package:ap_common/models/user_info.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_utils.dart';

export 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsUtils extends AnalyticsUtils {
  static FirebaseAnalyticsUtils? _instance;

  static bool get isSupported =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

  static FirebaseAnalyticsUtils get instance {
    return _instance ??= FirebaseAnalyticsUtils();
  }

  FirebaseAnalyticsUtils() {
    if (isSupported) analytics = FirebaseAnalytics.instance;
  }

  FirebaseAnalytics? analytics;

  Future<void> setCurrentScreen(
    String screenName,
    String screenClassOverride,
  ) async {
    await analytics?.logScreenView(
      screenName: screenName,
      screenClass: screenClassOverride,
    );
  }

  Future<void> setUserId(String id) async {
    await analytics?.setUserId(id: id);
    debugPrint('setUserId succeeded');
  }

  Future<void> setUserProperty(
    String name,
    String? value,
  ) async {
    await analytics?.setUserProperty(
      name: name,
      value: value,
    );
    debugPrint('setUserProperty $name succeeded');
  }

  Future<void> logEvent(
    String name, {
    Map<String, dynamic>? parameters,
  }) async {
    await analytics?.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  Future<void> logUserInfo(UserInfo? userInfo) async {
    if (userInfo == null) return;
    if (userInfo.department != null && userInfo.department!.isNotEmpty) {
      await analytics?.logEvent(
        name: 'user_info',
        parameters: <String, dynamic>{
          AnalyticsConstants.department: userInfo.department,
        },
      );
      FirebaseAnalyticsUtils.instance.setUserProperty(
        AnalyticsConstants.department,
        userInfo.department,
      );
    }
    if (userInfo.className != null && userInfo.className!.isNotEmpty) {
      FirebaseAnalyticsUtils.instance.setUserProperty(
        AnalyticsConstants.className,
        userInfo.className,
      );
    }
    if (userInfo.id.isNotEmpty) {
      await analytics?.setUserId(id: userInfo.id);
      FirebaseAnalyticsUtils.instance.setUserProperty(
        AnalyticsConstants.studentId,
        userInfo.id,
      );
    }
    debugPrint('logUserInfo succeeded');
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

  Future<void> logThemeEvent(ThemeMode themeMode) async {
    Brightness brightness;
    switch (themeMode) {
      case ThemeMode.system:
        brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
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
      AnalyticsConstants.theme,
      brightness == Brightness.light ? ApTheme.LIGHT : ApTheme.DARK,
    );
  }
}
