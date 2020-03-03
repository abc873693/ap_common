import 'package:flutter/material.dart';

import 'ap_colors.dart';

class ApTheme {
  static const String DARK = 'dark';
  static const String LIGHT = 'light';

  static String code = ApTheme.LIGHT;

  static ThemeData get data {
    switch (ApTheme.code) {
      case ApTheme.DARK:
        return dark;
      case ApTheme.LIGHT:
      default:
        return light;
    }
  }

  static double get drawerIconOpacity {
    switch (ApTheme.code) {
      case ApTheme.DARK:
        return 0.75;
      case ApTheme.LIGHT:
      default:
        return 1.0;
    }
  }

  static ThemeData get light => ThemeData(
        //platform: TargetPlatform.iOS,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          color: ApColors.blue,
        ),
        accentColor: ApColors.blueText,
        unselectedWidgetColor: ApColors.grey,
        backgroundColor: Colors.black12,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        //platform: TargetPlatform.iOS,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ApColors.onyx,
        accentColor: ApColors.blueAccent,
        unselectedWidgetColor: ApColors.grey,
        backgroundColor: Colors.black12,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      );
}
