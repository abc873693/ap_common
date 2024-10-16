import 'dart:async';

import 'package:flutter/services.dart';

class ApCommonPlugin {
  static const MethodChannel _channel = MethodChannel('ap_common_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
