import 'package:ap_common_flutter_platform/src/utilities/preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late ApPreferenceUtil preferenceUtil;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    preferenceUtil = ApPreferenceUtil();
    final encrypt.Key key = encrypt.Key.fromLength(32);
    final encrypt.IV iv = encrypt.IV.fromLength(16);
    await preferenceUtil.init(
      key: key,
      iv: iv,
      initialApIcon: false,
    );
  });

  group('String operations', () {
    test('setString and getString', () async {
      await preferenceUtil.setString('key', 'value');
      expect(preferenceUtil.getString('key', ''), 'value');
    });

    test('getString should return default when key not found', () {
      expect(preferenceUtil.getString('missing', 'default'), 'default');
    });
  });

  group('Int operations', () {
    test('setInt and getInt', () async {
      await preferenceUtil.setInt('intKey', 42);
      expect(preferenceUtil.getInt('intKey', 0), 42);
    });

    test('getInt should return default when key not found', () {
      expect(preferenceUtil.getInt('missing', -1), -1);
    });
  });

  group('Double operations', () {
    test('setDouble and getDouble', () async {
      await preferenceUtil.setDouble('doubleKey', 3.14);
      expect(preferenceUtil.getDouble('doubleKey', 0.0), 3.14);
    });

    test('getDouble should return default when key not found', () {
      expect(preferenceUtil.getDouble('missing', 0.0), 0.0);
    });
  });

  group('Bool operations', () {
    test('setBool and getBool', () async {
      await preferenceUtil.setBool('boolKey', true);
      expect(preferenceUtil.getBool('boolKey', false), isTrue);
    });

    test('getBool should return default when key not found', () {
      expect(preferenceUtil.getBool('missing', false), isFalse);
    });
  });

  group('StringList operations', () {
    test('setStringList and getStringList', () async {
      final List<String> list = <String>['a', 'b', 'c'];
      await preferenceUtil.setStringList('listKey', list);
      expect(
        preferenceUtil.getStringList('listKey', <String>[]),
        list,
      );
    });

    test('getStringList should return default when key not found', () {
      expect(
        preferenceUtil.getStringList('missing', <String>['x']),
        <String>['x'],
      );
    });
  });

  group('Encrypted string operations', () {
    test('setStringSecurity and getStringSecurity', () async {
      await preferenceUtil.setStringSecurity('secret', 'password123');
      final String result =
          preferenceUtil.getStringSecurity('secret', '');
      expect(result, 'password123');
    });

    test(
        'getStringSecurity should return default '
        'when key not found', () {
      expect(
        preferenceUtil.getStringSecurity('missing', 'default'),
        'default',
      );
    });
  });

  group('Key operations', () {
    test('getKeys should return stored keys', () async {
      await preferenceUtil.setString('key1', 'a');
      await preferenceUtil.setString('key2', 'b');
      final Set<String> keys = preferenceUtil.getKeys();
      expect(keys, contains('key1'));
      expect(keys, contains('key2'));
    });

    test('remove should delete a key', () async {
      await preferenceUtil.setString('toRemove', 'value');
      expect(preferenceUtil.getString('toRemove', ''), 'value');
      await preferenceUtil.remove('toRemove');
      expect(preferenceUtil.getString('toRemove', ''), '');
    });
  });
}
