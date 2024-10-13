import 'dart:io';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApPreferenceUtil extends PreferenceUtil {
  static SharedPreferences? prefs;

  static late encrypt.Encrypter encrypter;

  static encrypt.IV? iv;

  @override
  bool get isSupport =>
      kIsWeb ||
      Platform.isIOS ||
      Platform.isAndroid ||
      Platform.isMacOS ||
      Platform.isLinux ||
      Platform.isWindows;

  Future<void> init({
    required encrypt.Key key,
    required encrypt.IV iv,
    bool initialApIcon = true,
  }) async {
    if (isSupport) {
      prefs = await SharedPreferences.getInstance();
      //TODO logic move to other place
      ApIcon.code = getString(
        ApConstants.prefIconStyleCode,
        ApIcon.outlined,
      );
      encrypter = encrypt.Encrypter(
        encrypt.AES(
          key,
          mode: encrypt.AESMode.cbc,
        ),
      );
      ApPreferenceUtil.iv = iv;
    }
  }

  @override
  Future<void> setString(String key, String data) async {
    await prefs?.setString(key, data);
  }

  @override
  String getString(String key, String defaultValue) {
    return prefs?.getString(key) ?? defaultValue;
  }

  @override
  Future<void> setStringSecurity(String key, String data) async {
    await prefs?.setString(
      key,
      encrypter.encrypt(data, iv: iv).base64,
    );
  }

  @override
  String getStringSecurity(String key, String defaultValue) {
    final String data = prefs?.getString(key) ?? '';
    if (data == '') {
      return defaultValue;
    } else {
      return encrypter.decrypt64(data, iv: iv);
    }
  }

  @override
  Future<void> setInt(String key, int data) async {
    await prefs?.setInt(key, data);
  }

  @override
  int getInt(String key, int defaultValue) {
    return prefs?.getInt(key) ?? defaultValue;
  }

  @override
  Future<void> setDouble(String key, double data) async {
    await prefs?.setDouble(key, data);
  }

  @override
  double getDouble(String key, double defaultValue) {
    return prefs?.getDouble(key) ?? defaultValue;
  }

  @override
  Future<void> setBool(String key, bool data) async {
    await prefs?.setBool(key, data);
  }

  @override
  bool getBool(String key, bool defaultValue) {
    return prefs?.getBool(key) ?? defaultValue;
  }

  @override
  Future<void> setStringList(String key, List<String> data) async {
    await prefs?.setStringList(key, data);
  }

  @override
  List<String> getStringList(String key, List<String> defaultValue) {
    return prefs?.getStringList(key) ?? defaultValue;
  }

  @override
  Set<String> getKeys() {
    return prefs!.getKeys();
  }

  @override
  Future<bool>? remove(String key) {
    return prefs?.remove(key);
  }
}
