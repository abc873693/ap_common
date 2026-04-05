import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:ap_common_firebase/src/utils/firebase_utils.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

export 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsUtils extends AnalyticsUtil {
  FirebaseAnalyticsUtils() {
    if (isSupported) analytics = FirebaseAnalytics.instance;
  }

  static bool get isSupported =>
      kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS;

  FirebaseAnalytics? analytics;

  @override
  Future<void> setCurrentScreen(
    String screenName,
    String screenClassOverride,
  ) async {
    await analytics?.logScreenView(
      screenName: screenName,
      screenClass: screenClassOverride,
    );
  }

  @override
  Future<void> setUserId(String id) async {
    await analytics?.setUserId(id: id);
    log('setUserId succeeded');
  }

  @override
  Future<void> setUserProperty(
    String name,
    String? value,
  ) async {
    await analytics?.setUserProperty(
      name: name,
      value: value,
    );
    log('setUserProperty $name succeeded');
  }

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object>? parameters,
  }) async {
    await analytics?.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  @override
  Future<void> logUserInfo(UserInfo? userInfo) async {
    if (userInfo?.department == null) return;
    if (userInfo!.department!.isNotEmpty) {
      await analytics?.logEvent(
        name: 'user_info',
        parameters: <String, Object>{
          AnalyticsConstants.department: userInfo.department!,
        },
      );
      AnalyticsUtil.instance.setUserProperty(
        AnalyticsConstants.department,
        userInfo.department!,
      );
    }
    if (userInfo.className != null && userInfo.className!.isNotEmpty) {
      AnalyticsUtil.instance.setUserProperty(
        AnalyticsConstants.className,
        userInfo.className!,
      );
    }
    if (userInfo.id.isNotEmpty) {
      await analytics?.setUserId(id: userInfo.id);
      AnalyticsUtil.instance.setUserProperty(
        AnalyticsConstants.studentId,
        userInfo.id,
      );
    }
    log('logUserInfo succeeded');
  }

  @override
  Future<void> logApiEvent(
    String type,
    int status, {
    String message = '',
  }) async {
    await analytics?.logEvent(
      name: 'ap_api',
      parameters: <String, Object>{
        'type': type,
        'status': status,
        'message': message,
      },
    );
    log('logEvent succeeded');
  }

  Future<void> logCalculateUnits(double seconds) async {
    await analytics?.logEvent(
      name: 'calculate_units_time',
      parameters: <String, Object>{
        'time': seconds,
      },
    );
    log('log CalculateUnits succeeded');
  }

  @override
  Future<void> logTimeEvent(String name, double seconds) async {
    await analytics?.logEvent(
      name: name,
      parameters: <String, Object>{
        'time': seconds,
      },
    );
    log('log TimeEvent succeeded');
  }

  Future<void> logCaptchaErrorEvent(String tag, int count) async {
    await analytics?.logEvent(
      name: '${tag}_captcha_error',
      parameters: <String, Object>{
        'count': count,
      },
    );
    log('log CaptchaErrorEvent succeeded');
  }

  Future<void> logLeavesImageSize(File source) async {
    await analytics?.logEvent(
      name: 'leaves_image_pick',
      parameters: <String, Object>{
        'image_size': source.lengthSync() / 1024 / 1024,
      },
    );
  }

  Future<void> logLeavesImageCompressSize(File source, File result) async {
    await analytics?.logEvent(
      name: 'leaves_image_compress',
      parameters: <String, Object>{
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
      case ThemeMode.light:
        brightness = Brightness.light;
      case ThemeMode.dark:
        brightness = Brightness.dark;
    }
    setUserProperty(
      AnalyticsConstants.theme,
      brightness == Brightness.light ? 'light' : 'dart',
    );
  }
}
