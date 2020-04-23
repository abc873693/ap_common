import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences prefs;

  static encrypt.Encrypter encrypter;

  static encrypt.IV iv;

  static init({encrypt.Key key, encrypt.IV iv}) async {
    if (kIsWeb || Platform.isIOS || Platform.isAndroid || Platform.isMacOS) {
      prefs = await SharedPreferences.getInstance();
      if (key != null && iv != null) {
        encrypter = encrypt.Encrypter(
          encrypt.AES(
            key,
            mode: encrypt.AESMode.cbc,
          ),
        );
        Preferences.iv = iv;
      }
    }
  }

  static Future<Null> setString(String key, String data) async {
    final base64Text = base64.encode(utf8.encode(data));
    await prefs?.setString(key, base64Text);
  }

  static String getString(String key, String defaultValue) {
    final data = prefs?.getString(key);
    if (data == null || data.isEmpty)
      return defaultValue;
    else {
      final decoded = utf8.decode(base64.decode(data));
      return decoded;
    }
  }

  static Future<Null> setStringSecurity(String key, String data) async {
    await prefs?.setString(
      key,
      encrypter.encrypt(data, iv: iv).base64,
    );
  }

  static String getStringSecurity(String key, String defaultValue) {
    String data = prefs?.getString(key) ?? '';
    if (data == '')
      return defaultValue;
    else
      return encrypter.decrypt64(data, iv: iv);
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
