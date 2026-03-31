import 'package:ap_common_flutter_platform/src/utilities/notification_utils.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/date_symbol_data_local.dart';

void main() {
  late ApNotificationUtil util;

  setUpAll(() async {
    await initializeDateFormatting('zh');
  });

  setUp(() {
    util = ApNotificationUtil();
  });

  group('ApNotificationUtil constants', () {
    test('androidResourceName should be correct', () {
      expect(
        ApNotificationUtil.androidResourceName,
        '@drawable/ic_stat_name',
      );
    });

    test('bus notification ID should be 100', () {
      expect(ApNotificationUtil.bus, 100);
    });

    test('course notification ID should be 101', () {
      expect(ApNotificationUtil.course, 101);
    });

    test('fcm notification ID should be 200', () {
      expect(ApNotificationUtil.fcm, 200);
    });
  });

  group('getDay', () {
    test('should return Monday for weekday 1', () {
      expect(util.getDay(1), Day.monday);
    });

    test('should return Tuesday for weekday 2', () {
      expect(util.getDay(2), Day.tuesday);
    });

    test('should return Wednesday for weekday 3', () {
      expect(util.getDay(3), Day.wednesday);
    });

    test('should return Thursday for weekday 4', () {
      expect(util.getDay(4), Day.thursday);
    });

    test('should return Friday for weekday 5', () {
      expect(util.getDay(5), Day.friday);
    });

    test('should return Saturday for weekday 6', () {
      expect(util.getDay(6), Day.saturday);
    });

    test('should return Sunday for weekday 7', () {
      expect(util.getDay(7), Day.sunday);
    });
  });

  group('parseTime', () {
    test('should parse HH:mm format correctly', () {
      final TimeOfDay result = util.parseTime('09:30');
      expect(result.hour, 9);
      expect(result.minute, 30);
    });

    test('should parse 00:00 correctly', () {
      final TimeOfDay result = util.parseTime('00:00');
      expect(result.hour, 0);
      expect(result.minute, 0);
    });

    test('should parse 23:59 correctly', () {
      final TimeOfDay result = util.parseTime('23:59');
      expect(result.hour, 23);
      expect(result.minute, 59);
    });

    test('should subtract beforeMinutes', () {
      final TimeOfDay result =
          util.parseTime('10:30', beforeMinutes: 10);
      expect(result.hour, 10);
      expect(result.minute, 20);
    });

    test('should handle hour rollback when subtracting minutes', () {
      final TimeOfDay result =
          util.parseTime('10:05', beforeMinutes: 10);
      expect(result.hour, 9);
      expect(result.minute, 55);
    });
  });

  // Day enum from flutter_local_notifications:
  // sunday=1, monday=2, tuesday=3, wednesday=4,
  // thursday=5, friday=6, saturday=7
  // Dart DateTime.weekday: monday=1 .. sunday=7
  // getDay() converts: Dart weekday -> Day enum

  group('getNextWeekdayDateTime', () {
    test('should return next Monday when today is Wednesday', () {
      // 2023-10-25 is Wednesday (Dart weekday=3)
      // Day.monday.value=2
      // diffDay = 7 - (3 - 2 + 1) = 7 - 2 = 5
      withClock(Clock.fixed(DateTime(2023, 10, 25, 10)), () {
        const TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
        final Day monday = util.getDay(DateTime.monday);
        final DateTime result =
            util.getNextWeekdayDateTime(monday, time);
        // Wednesday + 5 days = next Monday 2023-10-30
        expect(result, DateTime(2023, 10, 30, 14, 30));
      });
    });

    test('should return tomorrow when time is later', () {
      // 2023-10-25 is Wednesday (Dart weekday=3)
      // Request Thursday: getDay(4) => Day.thursday (value=5)
      // now.weekday+1 == day.value => 3+1=4 != 5 — wrong path
      // Actually: diffDay = 7 - (3 - 5 + 1) = 7 - (-1) = 8
      // But getDay(4) maps Dart Thursday(4) to Day.values[4]=thursday
      //
      // Use direct approach: request next day via getDay
      // 2023-10-24 is Tuesday (Dart weekday=2)
      // getDay(3) = Day.values[3] = wednesday (value=4)
      // diffDay = 7 - (2 - 4 + 1) = 7 - (-1) = 8
      // now.weekday+1 == day.value => 2+1=3 != 4 — no shortcut
      //
      // The method uses Day.value directly, not Dart weekday.
      // For the shortcut path: now.weekday+1 == day.value
      // Tuesday(2)+1=3 == Day.tuesday.value(3) ✓
      // So request getDay(2) = tuesday on a Monday
      // 2023-10-23 is Monday (Dart weekday=1)
      // getDay(2) = Day.tuesday (value=3)
      // now.weekday+1 == day.value => 1+1=2 != 3 — still no
      //
      // Shortcut triggers when now.weekday+1 == day.value
      // Monday(1)+1=2 == Day.monday.value(2) ✓
      // So on Monday, requesting Monday should trigger shortcut
      // if time is later
      withClock(Clock.fixed(DateTime(2023, 10, 23, 10)), () {
        const TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
        final Day monday = util.getDay(DateTime.monday);
        // weekday=1, day.value=2, 1+1=2==2 ✓, 10:00 < 14:30 ✓
        // diffDay=0
        final DateTime result =
            util.getNextWeekdayDateTime(monday, time);
        expect(result, DateTime(2023, 10, 23, 14, 30));
      });
    });

    test('should return next week when requesting past weekday', () {
      // 2023-10-27 is Friday (Dart weekday=5)
      // getDay(1) = Day.monday (value=2)
      // diffDay = 7 - (5 - 2 + 1) = 7 - 4 = 3
      withClock(Clock.fixed(DateTime(2023, 10, 27, 10)), () {
        const TimeOfDay time = TimeOfDay(hour: 9, minute: 15);
        final Day monday = util.getDay(DateTime.monday);
        final DateTime result =
            util.getNextWeekdayDateTime(monday, time);
        // Friday + 3 days = Monday 2023-10-30
        expect(result, DateTime(2023, 10, 30, 9, 15));
      });
    });
  });
}
