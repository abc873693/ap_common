import 'package:ap_common_flutter_core/src/ui/ap_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() {
    ApIcon.code = ApIcon.outlined;
  });

  group('ApIcon constants', () {
    test('outlined should be "outlined"', () {
      expect(ApIcon.outlined, 'outlined');
    });

    test('filled should be "filled"', () {
      expect(ApIcon.filled, 'filled');
    });

    test('values should contain outlined and filled', () {
      expect(ApIcon.values, <String>[ApIcon.outlined, ApIcon.filled]);
    });

    test('default code should be outlined', () {
      expect(ApIcon.code, ApIcon.outlined);
    });
  });

  group('ApIcon index', () {
    test('should return 0 when code is outlined', () {
      ApIcon.code = ApIcon.outlined;
      expect(ApIcon.index, 0);
    });

    test('should return 1 when code is filled', () {
      ApIcon.code = ApIcon.filled;
      expect(ApIcon.index, 1);
    });
  });

  group('ApIcon properties - outlined mode', () {
    setUp(() {
      ApIcon.code = ApIcon.outlined;
    });

    test('share should return share_outlined', () {
      expect(ApIcon.share, Icons.share_outlined);
    });

    test('print should return print_outlined', () {
      expect(ApIcon.print, Icons.print_outlined);
    });

    test('search should return search_outlined', () {
      expect(ApIcon.search, Icons.search_outlined);
    });

    test('locationOn should return location_on_outlined', () {
      expect(ApIcon.locationOn, Icons.location_on_outlined);
    });

    test('download should return download_outlined', () {
      expect(ApIcon.download, Icons.download_outlined);
    });

    test('directionsBus should return directions_bus_outlined', () {
      expect(ApIcon.directionsBus, Icons.directions_bus_outlined);
    });

    test('classIcon should return class_outlined', () {
      expect(ApIcon.classIcon, Icons.class_outlined);
    });

    test('assignment should return assignment_outlined', () {
      expect(ApIcon.assignment, Icons.assignment_outlined);
    });

    test('accountCircle should return account_circle_outlined', () {
      expect(ApIcon.accountCircle, Icons.account_circle_outlined);
    });

    test('school should return school_outlined', () {
      expect(ApIcon.school, Icons.school_outlined);
    });

    test('apps should return apps_outlined', () {
      expect(ApIcon.apps, Icons.apps_outlined);
    });

    test('calendarToday should return calendar_today_outlined', () {
      expect(ApIcon.calendarToday, Icons.calendar_today_outlined);
    });

    test('edit should return edit_outlined', () {
      expect(ApIcon.edit, Icons.edit_outlined);
    });

    test('dateRange should return date_range_outlined', () {
      expect(ApIcon.dateRange, Icons.date_range_outlined);
    });

    test('info should return info_outline', () {
      expect(ApIcon.info, Icons.info_outline);
    });

    test('face should return face_outlined', () {
      expect(ApIcon.face, Icons.face_outlined);
    });

    test('settings should return settings_outlined', () {
      expect(ApIcon.settings, Icons.settings_outlined);
    });

    test('powerSettingsNew should return power_settings_new_outlined', () {
      expect(ApIcon.powerSettingsNew, Icons.power_settings_new_outlined);
    });

    test('permIdentity should return perm_identity_outlined', () {
      expect(ApIcon.permIdentity, Icons.perm_identity_outlined);
    });

    test('accessTime should return access_time_outlined', () {
      expect(ApIcon.accessTime, Icons.access_time_outlined);
    });

    test('error should return error_outline_outlined', () {
      expect(ApIcon.error, Icons.error_outline_outlined);
    });

    test('phone should return phone_outlined', () {
      expect(ApIcon.phone, Icons.phone_outlined);
    });

    test('cancel should return cancel_outlined', () {
      expect(ApIcon.cancel, Icons.cancel_outlined);
    });

    test('check should return check_outlined', () {
      expect(ApIcon.check, Icons.check_outlined);
    });

    test('person should return person_outlined', () {
      expect(ApIcon.person, Icons.person_outlined);
    });

    test('exitToApp should return exit_to_app_outlined', () {
      expect(ApIcon.exitToApp, Icons.exit_to_app_outlined);
    });

    test('warning should return warning_outlined', () {
      expect(ApIcon.warning, Icons.warning_outlined);
    });

    test('folder should return folder_outlined', () {
      expect(ApIcon.folder, Icons.folder_outlined);
    });

    test('home should return home_outlined', () {
      expect(ApIcon.home, Icons.home_outlined);
    });

    test('map should return map_outlined', () {
      expect(ApIcon.map, Icons.map_outlined);
    });

    test('room should return room_outlined', () {
      expect(ApIcon.room, Icons.room_outlined);
    });
  });

  group('ApIcon properties - filled mode', () {
    setUp(() {
      ApIcon.code = ApIcon.filled;
    });

    test('share should return share', () {
      expect(ApIcon.share, Icons.share);
    });

    test('print should return print', () {
      expect(ApIcon.print, Icons.print);
    });

    test('search should return search', () {
      expect(ApIcon.search, Icons.search);
    });

    test('locationOn should return location_on', () {
      expect(ApIcon.locationOn, Icons.location_on);
    });

    test('download should return download_rounded', () {
      expect(ApIcon.download, Icons.download_rounded);
    });

    test('directionsBus should return directions_bus', () {
      expect(ApIcon.directionsBus, Icons.directions_bus);
    });

    test('classIcon should return class_', () {
      expect(ApIcon.classIcon, Icons.class_);
    });

    test('assignment should return assignment', () {
      expect(ApIcon.assignment, Icons.assignment);
    });

    test('accountCircle should return account_circle', () {
      expect(ApIcon.accountCircle, Icons.account_circle);
    });

    test('school should return school', () {
      expect(ApIcon.school, Icons.school);
    });

    test('apps should return apps', () {
      expect(ApIcon.apps, Icons.apps);
    });

    test('calendarToday should return calendar_today', () {
      expect(ApIcon.calendarToday, Icons.calendar_today);
    });

    test('edit should return edit', () {
      expect(ApIcon.edit, Icons.edit);
    });

    test('dateRange should return date_range', () {
      expect(ApIcon.dateRange, Icons.date_range);
    });

    test('info should return info', () {
      expect(ApIcon.info, Icons.info);
    });

    test('face should return face', () {
      expect(ApIcon.face, Icons.face);
    });

    test('settings should return settings', () {
      expect(ApIcon.settings, Icons.settings);
    });

    test('powerSettingsNew should return power_settings_new', () {
      expect(ApIcon.powerSettingsNew, Icons.power_settings_new);
    });

    test('permIdentity should return perm_identity', () {
      expect(ApIcon.permIdentity, Icons.perm_identity);
    });

    test('accessTime should return access_time', () {
      expect(ApIcon.accessTime, Icons.access_time);
    });

    test('error should return error', () {
      expect(ApIcon.error, Icons.error);
    });

    test('phone should return phone', () {
      expect(ApIcon.phone, Icons.phone);
    });

    test('cancel should return cancel', () {
      expect(ApIcon.cancel, Icons.cancel);
    });

    test('check should return check', () {
      expect(ApIcon.check, Icons.check);
    });

    test('person should return person', () {
      expect(ApIcon.person, Icons.person);
    });

    test('exitToApp should return exit_to_app', () {
      expect(ApIcon.exitToApp, Icons.exit_to_app);
    });

    test('warning should return warning', () {
      expect(ApIcon.warning, Icons.warning);
    });

    test('folder should return folder', () {
      expect(ApIcon.folder, Icons.folder);
    });

    test('home should return home', () {
      expect(ApIcon.home, Icons.home);
    });

    test('map should return map', () {
      expect(ApIcon.map, Icons.map);
    });

    test('room should return room', () {
      expect(ApIcon.room, Icons.room);
    });
  });
}
