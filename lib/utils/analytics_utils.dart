import 'package:ap_common/models/user_info.dart';

abstract class AnalyticsUtils {
  Future<void> setCurrentScreen(String screenName, String screenClassOverride);

  Future<void> setUserId(String id);

  Future<void> setUserProperty(String name, String value);

  Future<void> logUserInfo(UserInfo userInfo);

  Future<void> logApiEvent(String type, int status, {String message = ''});

  Future<void> logCalculateUnits(double seconds);

  Future<void> logTimeEvent(String name, double seconds);

  Future<void> logAction(String name, String action, {String message = ''});
}
