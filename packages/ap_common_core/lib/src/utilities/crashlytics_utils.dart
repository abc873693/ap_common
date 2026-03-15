import 'package:ap_common_core/injector.dart';

abstract class CrashlyticsUtil {
  const CrashlyticsUtil();

  static CrashlyticsUtil get instance => injector.get<CrashlyticsUtil>();

  Future<void> recordError(
    dynamic exception,
    StackTrace stack, {
    dynamic reason,
    Iterable<Object>? information,
    bool? printDetails,
  });

  Future<void> setCrashlyticsCollectionEnabled(bool enabled);

  Future<void> log(String message);

  Future<void> setCustomKey(String key, Object value);
}
