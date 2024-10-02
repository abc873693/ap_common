import 'dart:io';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/foundation.dart';

export 'package:add_2_calendar/add_2_calendar.dart';

class PlatformCalendarUtil {
  static bool isSupported = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static PlatformCalendarUtil? _instance;

  //ignore: prefer_constructors_over_static_methods
  static PlatformCalendarUtil get instance {
    return _instance ??= PlatformCalendarUtil();
  }

  Future<bool> addToApp({required Event event}) async {
    return Add2Calendar.addEvent2Cal(event);
  }
}
