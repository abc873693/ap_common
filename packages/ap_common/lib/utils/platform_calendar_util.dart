import 'dart:io';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:flutter/foundation.dart';

export 'package:add_2_calendar/add_2_calendar.dart';

class ApPlatformCalendarUtil extends PlatformCalendarUtil {
  static bool isSupported = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static ApPlatformCalendarUtil? _instance;

  //ignore: prefer_constructors_over_static_methods
  static ApPlatformCalendarUtil get instance {
    return _instance ??= ApPlatformCalendarUtil();
  }

  @override
  Future<bool> addToApp({
    required String title,
    String? description,
    String? location,
    String? timeZone,
    required DateTime startDate,
    required DateTime endDate,
    bool allDay = false,
    Map<String, dynamic>? extra,
  }) async {
    return Add2Calendar.addEvent2Cal(
      Event(
        title: title,
        description: description,
        timeZone: timeZone,
        startDate: startDate,
        endDate: endDate,
        allDay: allDay,
      ),
    );
  }
}
