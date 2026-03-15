import 'package:ap_common_core/ap_common_core.dart';

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

class MockCrashlyticsUtil extends CrashlyticsUtil {
  const MockCrashlyticsUtil();

  @override
  Future<void> log(String message) async {}

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace stack, {
    dynamic reason,
    Iterable<Object>? information,
    bool? printDetails,
  }) async {}

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {}

  @override
  Future<void> setCustomKey(String key, Object value) async {}
}
