import 'package:ap_common_core/injector.dart';

abstract class PreferenceUtil {
  static PreferenceUtil get instance => injector.get<PreferenceUtil>();

  static bool get isSupport => true;

  Future<void> setString(String key, String data);

  String getString(String key, String defaultValue);

  Future<void> setStringSecurity(String key, String data);

  String getStringSecurity(String key, String defaultValue);

  Future<void> setInt(String key, int data);

  int getInt(String key, int defaultValue);

  Future<void> setDouble(String key, double data);

  double getDouble(String key, double defaultValue);

  Future<void> setBool(String key, bool data);

  bool getBool(String key, bool defaultValue);

  Future<void> setStringList(String key, List<String> data);

  List<String> getStringList(String key, List<String> defaultValue);

  List<String> getKeys();

  Future<bool>? remove(String key);
}
