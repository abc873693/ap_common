import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// A convenience wrapper around [MaterialApp] that handles common setup:
/// - [ApTheme] with light/dark theme support
/// - [ApLocalizations] and custom localization delegates
/// - Theme mode and locale management
/// - Edge-to-edge system UI
///
/// ## Simplified usage:
/// ```dart
/// // main.dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   registerOneForAll(); // from ap_common
///   registerApCommonService();
///   await (PreferenceUtil.instance as ApPreferenceUtil)
///       .init(key: key, iv: iv);
///   runApp(const MyApp());
/// }
///
/// // app.dart
/// class MyApp extends StatefulWidget {
///   const MyApp({super.key});
///   @override
///   State<MyApp> createState() => MyAppState();
/// }
///
/// class MyAppState extends State<MyApp> {
///   @override
///   Widget build(BuildContext context) {
///     return ApApp(
///       home: HomePage(),
///       routes: {
///         '/about': (_) => AboutUsPage(...),
///       },
///       // Optional: add your own localization delegate
///       additionalLocalizationsDelegates: [myAppDelegate],
///       onGenerateTitle: (context) => 'My App',
///     );
///   }
/// }
/// ```
class ApApp extends StatefulWidget {
  const ApApp({
    super.key,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.onGenerateTitle,
    this.additionalLocalizationsDelegates =
        const <LocalizationsDelegate<dynamic>>[],
    this.initialThemeMode = ThemeMode.system,
    this.themeModePreferenceKey = 'pref_theme_mode_index',
    this.languageCodePreferenceKey = 'pref_language_code',
    this.debugShowCheckedModeBanner = false,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.onGenerateRoute,
  });

  /// The default route widget.
  final Widget? home;

  /// Named routes.
  final Map<String, WidgetBuilder> routes;

  /// Callback to generate the app title.
  final GenerateAppTitle? onGenerateTitle;

  /// Extra localization delegates (e.g. your app-specific l10n).
  final List<LocalizationsDelegate<dynamic>> additionalLocalizationsDelegates;

  /// The initial theme mode, read from preferences.
  final ThemeMode initialThemeMode;

  /// Preference key for storing theme mode index.
  final String themeModePreferenceKey;

  /// Preference key for storing language code.
  final String languageCodePreferenceKey;

  /// Whether to show the debug banner.
  final bool debugShowCheckedModeBanner;

  /// Navigator observers.
  final List<NavigatorObserver> navigatorObservers;

  /// Custom route generation.
  final RouteFactory? onGenerateRoute;

  /// Find the nearest [ApAppState] in the widget tree.
  static ApAppState of(BuildContext context) {
    final _ApAppScope? scope =
        context.dependOnInheritedWidgetOfExactType<_ApAppScope>();
    assert(scope != null, 'No ApApp found in context');
    return scope!.state;
  }

  @override
  State<ApApp> createState() => ApAppState();
}

class ApAppState extends State<ApApp> with WidgetsBindingObserver {
  late ThemeMode _themeMode;
  Locale? _locale;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale => _locale;

  @override
  void initState() {
    super.initState();
    _themeMode = ThemeMode.values[
        PreferenceUtil.instance.getInt(widget.themeModePreferenceKey, 0)];
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

  /// Change the app's theme mode.
  void setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  /// Change the app's locale.
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      ApLocalizations.load(locale);
    });
  }

  /// Force a rebuild (e.g. after changing icon style or theme color).
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _ApAppScope(
      state: this,
      child: ApTheme(
        _themeMode,
        child: MaterialApp(
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            final String languageCode = PreferenceUtil.instance.getString(
              widget.languageCodePreferenceKey,
              ApSupportLanguageConstants.system,
            );
            if (languageCode == ApSupportLanguageConstants.system) {
              return _locale = ApLocalizations.delegate.isSupported(locale!)
                  ? locale
                  : const Locale('en');
            } else {
              return _locale = Locale(
                languageCode,
                languageCode == ApSupportLanguageConstants.zh ? 'TW' : null,
              );
            }
          },
          onGenerateTitle: widget.onGenerateTitle,
          debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
          routes: <String, WidgetBuilder>{
            if (widget.home != null)
              Navigator.defaultRouteName: (_) => widget.home!,
            ...widget.routes,
          },
          onGenerateRoute: widget.onGenerateRoute,
          theme: ApTheme.light,
          darkTheme: ApTheme.dark,
          themeMode: _themeMode,
          locale: _locale,
          navigatorObservers: widget.navigatorObservers,
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            apLocalizationsDelegate,
            ...widget.additionalLocalizationsDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: ApLocalizations.delegate.supportedLocales,
        ),
      ),
    );
  }
}

class _ApAppScope extends InheritedWidget {
  const _ApAppScope({required this.state, required super.child});

  final ApAppState state;

  @override
  bool updateShouldNotify(_ApAppScope oldWidget) => true;
}
