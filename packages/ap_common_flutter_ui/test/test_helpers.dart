import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/widgets.dart';

/// Mock [PreferenceUtil] that stores values in memory for testing.
class MockPreferenceUtil extends PreferenceUtil {
  final Map<String, dynamic> _store = <String, dynamic>{};

  @override
  Future<void> setString(String key, String data) async {
    _store[key] = data;
  }

  @override
  String getString(String key, String defaultValue) {
    return _store[key] as String? ?? defaultValue;
  }

  @override
  Future<void> setStringSecurity(String key, String data) async {
    _store[key] = data;
  }

  @override
  String getStringSecurity(String key, String defaultValue) {
    return _store[key] as String? ?? defaultValue;
  }

  @override
  Future<void> setInt(String key, int data) async {
    _store[key] = data;
  }

  @override
  int getInt(String key, int defaultValue) {
    return _store[key] as int? ?? defaultValue;
  }

  @override
  Future<void> setDouble(String key, double data) async {
    _store[key] = data;
  }

  @override
  double getDouble(String key, double defaultValue) {
    return _store[key] as double? ?? defaultValue;
  }

  @override
  Future<void> setBool(String key, bool data) async {
    _store[key] = data;
  }

  @override
  bool getBool(String key, bool defaultValue) {
    return _store[key] as bool? ?? defaultValue;
  }

  @override
  Future<void> setStringList(String key, List<String> data) async {
    _store[key] = data;
  }

  @override
  List<String> getStringList(String key, List<String> defaultValue) {
    return _store[key] as List<String>? ?? defaultValue;
  }

  @override
  Set<String> getKeys() => _store.keys.toSet();

  @override
  Future<bool>? remove(String key) async {
    _store.remove(key);
    return true;
  }
}

/// Mock [UiUtil] for testing.
class MockUiUtil extends UiUtil {
  String? lastToastMessage;

  @override
  void showToast(BuildContext context, String message, {int? gravity}) {
    lastToastMessage = message;
  }
}

/// Re-export the mock from ap_common_core.
class MockAnalyticsUtil extends AnalyticsUtil {
  const MockAnalyticsUtil();

  @override
  Future<void> logApiEvent(
    String type,
    int status, {
    String message = '',
  }) async {}
  @override
  Future<void> logEvent(
    String name, {
    Map<String, dynamic>? parameters,
  }) async {}
  @override
  Future<void> logTimeEvent(String name, double seconds) async {}
  @override
  Future<void> logUserInfo(UserInfo userInfo) async {}
  @override
  Future<void> setCurrentScreen(
    String screenName,
    String screenClassOverride,
  ) async {}
  @override
  Future<void> setUserId(String id) async {}
  @override
  Future<void> setUserProperty(String name, String value) async {}
}
