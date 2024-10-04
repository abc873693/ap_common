abstract class CrashlyticsUtils {
  static CrashlyticsUtils? instance;

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
