import 'package:ap_common/models/user_info.dart';
import 'package:flutter/material.dart';

abstract class AnalyticsUtils {
  static AnalyticsUtils? instance;

  Future<void> setCurrentScreen(String screenName, String screenClassOverride);

  Future<void> setUserId(String id);

  Future<void> setUserProperty(String name, String value);

  Future<void> logUserInfo(UserInfo userInfo);

  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});

  Future<void> logApiEvent(String type, int status, {String message = ''});

  @deprecated
  Future<void> logCalculateUnits(double seconds);

  Future<void> logTimeEvent(String name, double seconds);

  @deprecated
  Future<void> logAction(String name, String action, {String message = ''});

  Future<void> logThemeEvent(ThemeMode themeMode);
}
