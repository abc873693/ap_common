import 'dart:ui';

import 'package:ap_common_core/injector.dart';

abstract class PlatformUtil {
  static PlatformUtil get instance => injector.get<PlatformUtil>();

  Future<void> launchUrl(String url);

  Future<void> callPhone(String url);

  Future<void> shareTo(
    String content, {
    Rect? sharePositionOrigin,
  });
}
