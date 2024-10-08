import 'package:ap_common_core/injector.dart';

abstract class PlatformCalendarUtil {
  static PlatformCalendarUtil get instance =>
      injector.get<PlatformCalendarUtil>();

  Future<bool> addToApp({
    required String title,
    String? description,
    String? location,
    String? timeZone,
    required DateTime startDate,
    required DateTime endDate,
    bool allDay = false,
    Map<String, dynamic>? extra,
  });
}
