import 'package:ap_common_flutter_platform/src/utilities/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  group('getNextWeekdayDateTime', () {
    test('should return a DateTime with correct time', () {
      const TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
      final DateTime result =
          util.getNextWeekdayDateTime(Day.monday, time);
      expect(result.hour, 14);
      expect(result.minute, 30);
    });

    test('should return a future date', () {
      const TimeOfDay time = TimeOfDay(hour: 0, minute: 0);
      final DateTime result =
          util.getNextWeekdayDateTime(Day.monday, time);
      // Result should be within 7 days from now
      final DateTime now = DateTime.now();
      expect(
        result.difference(now).inDays,
        lessThanOrEqualTo(7),
      );
    });
  });
}
