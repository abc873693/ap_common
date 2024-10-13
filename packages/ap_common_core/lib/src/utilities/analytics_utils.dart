import 'package:ap_common_core/injector.dart';
import 'package:ap_common_core/src/models/user_info.dart';

abstract class AnalyticsUtil {
  const AnalyticsUtil();

  static AnalyticsUtil get instance => injector.get<AnalyticsUtil>();

  Future<void> setCurrentScreen(String screenName, String screenClassOverride);

  Future<void> setUserId(String id);

  Future<void> setUserProperty(String name, String value);

  Future<void> logUserInfo(UserInfo userInfo);

  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});

  Future<void> logApiEvent(String type, int status, {String message = ''});

  Future<void> logTimeEvent(String name, double seconds);

  //TODO: migration to implement level
  // Future<void> logThemeEvent(ThemeMode themeMode);
}
