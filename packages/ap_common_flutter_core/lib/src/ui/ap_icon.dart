import 'package:flutter/material.dart';

class ApIcon {
  static const String outlined = 'outlined';
  static const String filled = 'filled';

  static const List<String> values = <String>[
    outlined,
    filled,
  ];

  static String code = ApIcon.outlined;

  static int get index {
    return values.indexOf(code);
  }

  static IconData get share {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.share;
      case ApIcon.outlined:
      default:
        return Icons.share_outlined;
    }
  }

  static IconData get print {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.print;
      case ApIcon.outlined:
      default:
        return Icons.print_outlined;
    }
  }

  static IconData get search {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.search;
      case ApIcon.outlined:
      default:
        return Icons.search_outlined;
    }
  }

  static IconData get locationOn {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.location_on;
      case ApIcon.outlined:
      default:
        return Icons.location_on_outlined;
    }
  }

  static IconData get download {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.download_rounded;
      case ApIcon.outlined:
      default:
        return Icons.download_outlined;
    }
  }

  static IconData get directionsBus {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.directions_bus;
      case ApIcon.outlined:
      default:
        return Icons.directions_bus_outlined;
    }
  }

  static IconData get classIcon {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.class_;
      case ApIcon.outlined:
      default:
        return Icons.class_outlined;
    }
  }

  static IconData get assignment {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.assignment;
      case ApIcon.outlined:
      default:
        return Icons.assignment_outlined;
    }
  }

  static IconData get accountCircle {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.account_circle;
      case ApIcon.outlined:
      default:
        return Icons.account_circle_outlined;
    }
  }

  static IconData get school {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.school;
      case ApIcon.outlined:
      default:
        return Icons.school_outlined;
    }
  }

  static IconData get apps {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.apps;
      case ApIcon.outlined:
      default:
        return Icons.apps_outlined;
    }
  }

  static IconData get calendarToday {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.calendar_today;
      case ApIcon.outlined:
      default:
        return Icons.calendar_today_outlined;
    }
  }

  static IconData get edit {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.edit;
      case ApIcon.outlined:
      default:
        return Icons.edit_outlined;
    }
  }

  static IconData get dateRange {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.date_range;
      case ApIcon.outlined:
      default:
        return Icons.date_range_outlined;
    }
  }

  static IconData get info {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.info;
      case ApIcon.outlined:
      default:
        return Icons.info_outline;
    }
  }

  static IconData get face {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.face;
      case ApIcon.outlined:
      default:
        return Icons.face_outlined;
    }
  }

  static IconData get settings {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.settings;
      case ApIcon.outlined:
      default:
        return Icons.settings_outlined;
    }
  }

  static IconData get powerSettingsNew {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.power_settings_new;
      case ApIcon.outlined:
      default:
        return Icons.power_settings_new_outlined;
    }
  }

  static IconData get permIdentity {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.perm_identity;
      case ApIcon.outlined:
      default:
        return Icons.perm_identity_outlined;
    }
  }

  static IconData get accessTime {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.access_time;
      case ApIcon.outlined:
      default:
        return Icons.access_time_outlined;
    }
  }

  static IconData get keyboardArrowDown {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.keyboard_arrow_down;
      case ApIcon.outlined:
      default:
        return Icons.keyboard_arrow_down_outlined;
    }
  }

  static IconData get offlineBolt {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.offline_bolt;
      case ApIcon.outlined:
      default:
        return Icons.offline_bolt_outlined;
    }
  }

  static IconData get error {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.error;
      case ApIcon.outlined:
      default:
        return Icons.error_outline_outlined;
    }
  }

  static IconData get fiberNew {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.fiber_new;
      case ApIcon.outlined:
      default:
        return Icons.fiber_new_outlined;
    }
  }

  static IconData get phone {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.phone;
      case ApIcon.outlined:
      default:
        return Icons.phone_outlined;
    }
  }

  static IconData get codeIcon {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.code;
      case ApIcon.outlined:
      default:
        return Icons.code_outlined;
    }
  }

  static IconData get cancel {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.cancel;
      case ApIcon.outlined:
      default:
        return Icons.cancel_outlined;
    }
  }

  static IconData get check {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.check;
      case ApIcon.outlined:
      default:
        return Icons.check_outlined;
    }
  }

  static IconData get arrowDropUp {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.arrow_drop_up;
      case ApIcon.outlined:
      default:
        return Icons.arrow_drop_up_outlined;
    }
  }

  static IconData get arrowDropDown {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.arrow_drop_down;
      case ApIcon.outlined:
      default:
        return Icons.arrow_drop_down_outlined;
    }
  }

  static IconData get chevronLeft {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.chevron_left;
      case ApIcon.outlined:
      default:
        return Icons.chevron_left_outlined;
    }
  }

  static IconData get chevronRight {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.chevron_right;
      case ApIcon.outlined:
      default:
        return Icons.chevron_right_outlined;
    }
  }

  static IconData get person {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.person;
      case ApIcon.outlined:
      default:
        return Icons.person_outlined;
    }
  }

  static IconData get exitToApp {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.exit_to_app;
      case ApIcon.outlined:
      default:
        return Icons.exit_to_app_outlined;
    }
  }

  static IconData get warning {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.warning;
      case ApIcon.outlined:
      default:
        return Icons.warning_outlined;
    }
  }

  static IconData get folder {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.folder;
      case ApIcon.outlined:
      default:
        return Icons.folder_outlined;
    }
  }

  static IconData get insertDriveFile {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.insert_drive_file;
      case ApIcon.outlined:
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  static IconData get collectionsBookmark {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.collections_bookmark;
      case ApIcon.outlined:
      default:
        return Icons.collections_bookmark_outlined;
    }
  }

  static IconData get accessibilityNew {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.accessibility_new;
      case ApIcon.outlined:
      default:
        return Icons.accessibility_new;
    }
  }

  static IconData get monetizationOn {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.monetization_on;
      case ApIcon.outlined:
      default:
        return Icons.monetization_on_outlined;
    }
  }

  static IconData get map {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.map;
      case ApIcon.outlined:
      default:
        return Icons.map_outlined;
    }
  }

  static IconData get navigation {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.navigation;
      case ApIcon.outlined:
      default:
        return Icons.navigation_outlined;
    }
  }

  static IconData get room {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.room;
      case ApIcon.outlined:
      default:
        return Icons.room_outlined;
    }
  }

  static IconData get home {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return Icons.home;
      case ApIcon.outlined:
      default:
        return Icons.home_outlined;
    }
  }
}
