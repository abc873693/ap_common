import 'package:ap_common/resources/ap_assets.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:flutter/material.dart';

import 'ap_colors.dart';

export 'package:cupertino_back_gesture/cupertino_back_gesture.dart';

class ApTheme extends InheritedWidget {
  final ThemeMode themeMode;

  ApTheme(
    this.themeMode, {
    required Widget child,
    BackGestureWidth? backGestureWidth,
  }) : super(
          child: BackGestureWidthTheme(
            backGestureWidth:
                backGestureWidth as double Function(Size Function())? ??
                    BackGestureWidth.fraction(1 / 2),
            child: child,
          ),
        );

  static ApTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  @override
  bool updateShouldNotify(ApTheme oldWidget) {
    return true;
  }

  // ignore: constant_identifier_names
  static const String DARK = 'dark';

  // ignore: constant_identifier_names
  static const String LIGHT = 'light';

  // ignore: constant_identifier_names
  static const String SYSTEM = 'system';

  static String code = ApTheme.LIGHT;

  Brightness get brightness {
    switch (themeMode) {
      case ThemeMode.system:
        return WidgetsBinding.instance!.window.platformBrightness;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
      default:
        return Brightness.dark;
    }
  }

  Color get blue {
    switch (brightness) {
      case Brightness.light:
        return ApColors.blue500;
      case Brightness.dark:
      default:
        return ApColors.blueDark;
    }
  }

  Color get blueText {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.grey100;
      case Brightness.light:
      default:
        return ApColors.blue500;
    }
  }

  Color get blueAccent {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.blue300;
      case Brightness.light:
      default:
        return ApColors.blue500;
    }
  }

  Color get semesterText {
    switch (brightness) {
      case Brightness.dark:
        return const Color(0xffffffff);
      case Brightness.light:
      default:
        return ApColors.blue500;
    }
  }

  Color get grey {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.grey200;
      case Brightness.light:
      default:
        return ApColors.grey500;
    }
  }

  Color get greyText {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.grey200;
      case Brightness.light:
      default:
        return ApColors.grey500;
    }
  }

  Color get disabled {
    switch (brightness) {
      case Brightness.dark:
        return const Color(0xFF424242);
      case Brightness.light:
      default:
        return const Color(0xFFBDBDBD);
    }
  }

  Color get calendarTileSelect {
    switch (brightness) {
      case Brightness.dark:
        return const Color(0xff000000);
      case Brightness.light:
      default:
        return const Color(0xffffffff);
    }
  }

  Color get yellow {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.yellow200;
      case Brightness.light:
      default:
        return ApColors.yellow500;
    }
  }

  Color get red {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.red200;
      case Brightness.light:
      default:
        return ApColors.red500;
    }
  }

  Color get green {
    switch (brightness) {
      case Brightness.light:
        return Colors.green;
      case Brightness.dark:
      default:
        return Colors.green[300]!;
    }
  }

  Color get bottomNavigationSelect {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.grey100;
      case Brightness.light:
      default:
        return const Color(0xff737373);
    }
  }

  Color get segmentControlUnSelect {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.onyx;
      case Brightness.light:
      default:
        return const Color(0xffffffff);
    }
  }

  Color get snackBarActionTextColor {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.yellow500;
      case Brightness.light:
      default:
        return ApColors.yellow500;
    }
  }

  Color get toastBackground {
    switch (brightness) {
      case Brightness.light:
        return const Color(0xAA000000);
      case Brightness.dark:
      default:
        return const Color(0xAAFFFFFF);
    }
  }

  Color get toastText {
    switch (brightness) {
      case Brightness.light:
        return Colors.white;
      case Brightness.dark:
      default:
        return Colors.black;
    }
  }

  double get drawerIconOpacity {
    switch (brightness) {
      case Brightness.dark:
        return 0.75;
      case Brightness.light:
      default:
        return 1.0;
    }
  }

  String get dashLine {
    switch (brightness) {
      case Brightness.light:
        return ApImageAssets.dashLineLight;
      case Brightness.dark:
      default:
        return ApImageAssets.dashLineDarkTheme;
    }
  }

  String get drawerBackground {
    switch (brightness) {
      case Brightness.light:
        return ApImageAssets.drawerBackgroundLight;
      case Brightness.dark:
      default:
        return ApImageAssets.drawerBackgroundDarkTheme;
    }
  }

  Color get courseBorder {
    switch (brightness) {
      case Brightness.dark:
        return ApColors.charade;
      case Brightness.light:
      default:
        return ApColors.solitude;
    }
  }

  Color get courseText {
    switch (brightness) {
      case Brightness.dark:
        return Colors.black87;
      case Brightness.light:
      default:
        return Colors.white;
    }
  }

  Color get courseListTabletBackground {
    switch (brightness) {
      case Brightness.dark:
        return Colors.black12;
      case Brightness.light:
      default:
        return Colors.white;
    }
  }

  Color get barCode {
    switch (brightness) {
      case Brightness.dark:
        return Colors.white;
      case Brightness.light:
      default:
        return Colors.black;
    }
  }

  Color get background {
    switch (brightness) {
      case Brightness.dark:
        return const Color(0xff121212);
      case Brightness.light:
      default:
        return Colors.white;
    }
  }

  static ThemeData get light => ThemeData(
        //platform: TargetPlatform.iOS,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          color: ApColors.blue500,
        ),
        pageTransitionsTheme: _pageTransitionsTheme,
        accentColor: ApColors.blue500,
        unselectedWidgetColor: ApColors.grey500,
        backgroundColor: Colors.black12,
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: ApColors.blue200,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData get dark => ThemeData(
        //platform: TargetPlatform.iOS,
        brightness: Brightness.dark,
        pageTransitionsTheme: _pageTransitionsTheme,
        appBarTheme: const AppBarTheme(
          color: ApColors.blueDark,
        ),
        scaffoldBackgroundColor: ApColors.onyx,
        accentColor: ApColors.blue300,
        unselectedWidgetColor: ApColors.grey200,
        backgroundColor: Colors.black12,
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: ApColors.blue200,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}

const _pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android:
        CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    TargetPlatform.macOS:
        CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    TargetPlatform.windows:
        CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    TargetPlatform.linux:
        CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    TargetPlatform.fuchsia:
        CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
  },
);
