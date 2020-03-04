import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences prefs;

  static init() async {
    if (kIsWeb || Platform.isIOS || Platform.isAndroid || Platform.isMacOS) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  static Future<Null> setString(String key, String data) async {
    await prefs?.setString(key, data);
  }

  static String getString(String key, String defaultValue) {
    return prefs?.getString(key) ?? defaultValue;
  }

  static Future<Null> setInt(String key, int data) async {
    await prefs?.setInt(key, data);
  }

  static int getInt(String key, int defaultValue) {
    return prefs?.getInt(key) ?? defaultValue;
  }

  static Future<Null> setDouble(String key, double data) async {
    await prefs?.setDouble(key, data);
  }

  static double getDouble(String key, double defaultValue) {
    return prefs?.getDouble(key) ?? defaultValue;
  }

  static Future<Null> setBool(String key, bool data) async {
    await prefs?.setBool(key, data);
  }

  static bool getBool(String key, bool defaultValue) {
    return prefs?.getBool(key) ?? defaultValue;
  }

  static Future<Null> setStringList(String key, List<String> data) async {
    await prefs?.setStringList(key, data);
  }

  static List<String> getStringList(String key, List<String> defaultValue) {
    return prefs?.getStringList(key) ?? defaultValue;
  }
}
