import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ap_common_plugin/ap_common_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('ap_common_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ApCommonPlugin.platformVersion, '42');
  });
}
