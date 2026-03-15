import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/config/constants.dart';
import 'package:ap_common_example/pages/home_page.dart';
import 'package:ap_common_example/utils/app_localizations.dart';
import 'package:ap_common_example/widgets/share_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  ThemeData? themeData;
  Uint8List? pictureBytes;
  bool offlineLogin = false;
  bool hasBusViolationRecords = false;

  ThemeMode themeMode = ThemeMode.system;
  int currentColorIndex = 0;
  Color? customColor;
  Locale? locale;

  void logout() {
    setState(() {
      offlineLogin = false;
      pictureBytes = null;
    });
  }

  @override
  void initState() {
    themeMode = ThemeMode.values[
        PreferenceUtil.instance.getInt(Constants.PREF_THEME_MODE_INDEX, 0)];
    currentColorIndex =
        PreferenceUtil.instance.getInt(ApTheme.PREF_COLOR_INDEX, 0);
    final int customColorValue =
        PreferenceUtil.instance.getInt(ApTheme.PREF_CUSTOM_COLOR, 0);
    if (currentColorIndex == ApTheme.customColorIndex &&
        customColorValue != 0) {
      customColor = Color(customColorValue);
    }
    WidgetsBinding.instance.addObserver(this);
    Future<void>.microtask(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarContrastEnforced: true,
          systemNavigationBarColor: Colors.transparent,
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {});
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return ShareDataWidget(
      data: this,
      child: ApTheme(
        themeMode: themeMode,
        currentColorIndex: currentColorIndex,
        customColor: customColor,
        preferences: PreferenceUtil.instance,
        child: Builder(
          builder: (BuildContext context) {
            final Color seedColor = ApTheme.of(context).seedColor;
            return MaterialApp(
              localeResolutionCallback:
                  (Locale? locale, Iterable<Locale> supportedLocales) {
                final String languageCode = PreferenceUtil.instance.getString(
                  Constants.PREF_LANGUAGE_CODE,
                  ApSupportLanguageConstants.system,
                );
                if (languageCode == ApSupportLanguageConstants.system) {
                  return this.locale =
                      ApLocalizations.delegate.isSupported(locale!)
                          ? locale
                          : const Locale('en');
                } else {
                  return this.locale = Locale(
                    languageCode,
                    languageCode == ApSupportLanguageConstants.zh ? 'TW' : null,
                  );
                }
              },
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context).appName,
              debugShowCheckedModeBanner: false,
              routes: <String, WidgetBuilder>{
                Navigator.defaultRouteName: (BuildContext context) =>
                    HomePage(),
                AboutUsPage.routerName: (BuildContext context) =>
                    HomePageState.aboutPage(context),
                AnnouncementHomePage.routerName: (BuildContext context) =>
                    const AnnouncementHomePage(),
              },
              theme: ApTheme.light(seedColor),
              darkTheme: ApTheme.dark(seedColor),
              themeMode: themeMode,
              locale: locale,
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                apLocalizationsDelegate,
                appDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: ApLocalizations.delegate.supportedLocales,
            );
          },
        ),
      ),
    );
  }

  void update() {
    setState(() {});
  }

  void loadTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  void loadThemeColor(int index, Color? custom) {
    setState(() {
      currentColorIndex = index;
      customColor = custom;
    });
  }

  void loadLocale(Locale locale) {
    debugPrint('loadLocale $locale');
    setState(() {
      this.locale = locale;
      appDelegate.load(locale);
      ApLocalizations.load(locale);
    });
  }
}
