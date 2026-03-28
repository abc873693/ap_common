import 'package:ap_common/ap_common.dart'
    hide TranslationProvider, LocaleSettings, AppLocaleUtils, AppLocale;
import 'package:ap_common_flutter_core/src/l10n/strings.g.dart'
    as ap_l10n;
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
    _initLocale();
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

  Future<void> _initLocale() async {
    final String languageCode = PreferenceUtil.instance.getString(
      Constants.PREF_LANGUAGE_CODE,
      ApSupportLanguageConstants.system,
    );
    if (languageCode == ApSupportLanguageConstants.system) {
      await useApDeviceLocale();
      await LocaleSettings.useDeviceLocale();
    } else {
      final locale = Locale(
        languageCode,
        languageCode == ApSupportLanguageConstants.zh ? 'TW' : null,
      );
      await setApLocaleFromFlutter(locale);
      final appLocale = AppLocaleUtils.instance.parseLocaleParts(
        languageCode: locale.languageCode,
        scriptCode: locale.scriptCode,
        countryCode: locale.countryCode,
      );
      await LocaleSettings.setLocale(appLocale);
    }
    if (mounted) setState(() {});
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
            return TranslationProvider(
              child: Builder(
                builder: (BuildContext context) {
                  return MaterialApp(
                    onGenerateTitle: (BuildContext context) => app.appName,
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
                    locale: TranslationProvider.of(context).flutterLocale,
                    supportedLocales: AppLocaleUtils.supportedLocales,
                    localizationsDelegates:
                        const <LocalizationsDelegate<dynamic>>[
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                  );
                },
              ),
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
    // Sync ap_common library locale
    setApLocaleFromFlutter(locale);
    // Sync example app locale
    final appLocale = AppLocaleUtils.instance.parseLocaleParts(
      languageCode: locale.languageCode,
      scriptCode: locale.scriptCode,
      countryCode: locale.countryCode,
    );
    LocaleSettings.setLocale(appLocale);
  }
}
