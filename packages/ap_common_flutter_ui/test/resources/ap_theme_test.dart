import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:ap_common_flutter_ui/src/resources/ap_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeColor', () {
    test('should hold name and color', () {
      const ThemeColor themeColor = ThemeColor(
        name: 'test',
        color: Colors.blue,
      );
      expect(themeColor.name, 'test');
      expect(themeColor.color, Colors.blue);
    });
  });

  group('ApTheme constants', () {
    test('DARK should be "dark"', () {
      expect(ApTheme.DARK, 'dark');
    });

    test('LIGHT should be "light"', () {
      expect(ApTheme.LIGHT, 'light');
    });

    test('SYSTEM should be "system"', () {
      expect(ApTheme.SYSTEM, 'system');
    });

    test('customColorIndex should be -1', () {
      expect(ApTheme.customColorIndex, -1);
    });

    test('themeColors should have 10 entries', () {
      expect(ApTheme.themeColors.length, 10);
    });

    test('themeColors first entry should be 高科藍', () {
      expect(ApTheme.themeColors[0].name, '高科藍');
    });
  });

  group('ApTheme updateShouldNotify', () {
    test('should return true when themeMode changes', () {
      final ApTheme oldWidget = _createApTheme();
      final ApTheme newWidget = _createApTheme(themeMode: ThemeMode.dark);
      expect(newWidget.updateShouldNotify(oldWidget), isTrue);
    });

    test('should return true when colorIndex changes', () {
      final ApTheme oldWidget = _createApTheme();
      final ApTheme newWidget = _createApTheme(colorIndex: 1);
      expect(newWidget.updateShouldNotify(oldWidget), isTrue);
    });

    test('should return true when customColor changes', () {
      final ApTheme oldWidget = _createApTheme(customColor: Colors.red);
      final ApTheme newWidget = _createApTheme(customColor: Colors.blue);
      expect(newWidget.updateShouldNotify(oldWidget), isTrue);
    });

    test('should return false when nothing changes', () {
      final ApTheme oldWidget = _createApTheme();
      final ApTheme newWidget = _createApTheme();
      expect(newWidget.updateShouldNotify(oldWidget), isFalse);
    });
  });
}

ApTheme _createApTheme({
  ThemeMode themeMode = ThemeMode.light,
  int colorIndex = 0,
  Color? customColor,
}) {
  return ApTheme(
    themeMode: themeMode,
    currentColorIndex: colorIndex,
    customColor: customColor,
    preferences: _MockPreferenceUtil(),
    child: const SizedBox(),
  );
}

class _MockPreferenceUtil extends PreferenceUtil {
  final Map<String, dynamic> _store = <String, dynamic>{};

  @override
  bool get isSupport => true;

  @override
  Future<void> setString(String key, String data) async =>
      _store[key] = data;

  @override
  String getString(String key, String defaultValue) =>
      (_store[key] as String?) ?? defaultValue;

  @override
  Future<void> setStringSecurity(String key, String data) async =>
      _store[key] = data;

  @override
  String getStringSecurity(String key, String defaultValue) =>
      (_store[key] as String?) ?? defaultValue;

  @override
  Future<void> setInt(String key, int data) async =>
      _store[key] = data;

  @override
  int getInt(String key, int defaultValue) =>
      (_store[key] as int?) ?? defaultValue;

  @override
  Future<void> setDouble(String key, double data) async =>
      _store[key] = data;

  @override
  double getDouble(String key, double defaultValue) =>
      (_store[key] as double?) ?? defaultValue;

  @override
  Future<void> setBool(String key, bool data) async =>
      _store[key] = data;

  @override
  bool getBool(String key, bool defaultValue) =>
      (_store[key] as bool?) ?? defaultValue;

  @override
  Future<void> setStringList(String key, List<String> data) async =>
      _store[key] = data;

  @override
  List<String> getStringList(String key, List<String> defaultValue) =>
      (_store[key] as List<String>?) ?? defaultValue;

  @override
  Set<String> getKeys() => _store.keys.toSet();

  @override
  Future<bool>? remove(String key) {
    _store.remove(key);
    return Future<bool>.value(true);
  }
}
