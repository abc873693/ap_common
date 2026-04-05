import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/glass_theme_bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A convenience wrapper around [MaterialApp] that applies both
/// [ApTheme] and [GlassTheme] setup.
///
/// This is the glass-enhanced equivalent of [ApApp]. It:
/// - Applies [GlassTheme] bridged from [ApTheme] seed colors
/// - Manages theme mode, locale, and color preferences
///
/// **Important:**
/// - Call [LiquidGlassWidgets.initialize] in `main()` and wrap
///   with [LiquidGlassWidgets.wrap] at the `runApp` level.
/// - Do NOT wrap with [TranslationProvider] externally — this
///   widget already includes one. Nesting two providers of the
///   same locale type causes a duplicate GlobalKey crash.
///
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await LiquidGlassWidgets.initialize();
///   runApp(LiquidGlassWidgets.wrap(const MyApp()));
/// }
///
/// class MyApp extends StatelessWidget {
///   const MyApp({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // No TranslationProvider needed here.
///     return LiquidGlassApApp(
///       home: const GlassHomePage(),
///     );
///   }
/// }
/// ```
class LiquidGlassApApp extends StatefulWidget {
  const LiquidGlassApApp({
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
    this.quality = GlassQuality.standard,
    this.glassSettings,
  });

  /// The default route widget.
  final Widget? home;

  /// Named routes.
  final Map<String, WidgetBuilder> routes;

  /// Callback to generate the app title.
  final GenerateAppTitle? onGenerateTitle;

  /// Extra localization delegates.
  final List<LocalizationsDelegate<dynamic>>
      additionalLocalizationsDelegates;

  /// The initial theme mode.
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

  /// Glass rendering quality.
  final GlassQuality quality;

  /// Optional glass effect settings (thickness, blur, specular).
  final LiquidGlassSettings? glassSettings;

  /// Find the nearest [LiquidGlassApAppState] in the widget tree.
  static LiquidGlassApAppState of(BuildContext context) {
    final _LiquidGlassApAppScope? scope = context
        .dependOnInheritedWidgetOfExactType<_LiquidGlassApAppScope>();
    assert(scope != null, 'No LiquidGlassApApp found in context');
    return scope!.state;
  }

  @override
  State<LiquidGlassApApp> createState() => LiquidGlassApAppState();
}

class LiquidGlassApAppState extends State<LiquidGlassApApp>
    with WidgetsBindingObserver {
  late ThemeMode _themeMode;
  int _currentColorIndex = 0;
  Color? _customColor;

  ThemeMode get themeMode => _themeMode;

  @override
  void initState() {
    super.initState();
    final int themeIndex = PreferenceUtil.instance.getInt(
      widget.themeModePreferenceKey,
      0,
    );
    _themeMode =
        themeIndex >= 0 && themeIndex < ThemeMode.values.length
            ? ThemeMode.values[themeIndex]
            : ThemeMode.system;
    _currentColorIndex = PreferenceUtil.instance.getInt(
      ApTheme.PREF_COLOR_INDEX,
      0,
    );
    final int customColorValue = PreferenceUtil.instance.getInt(
      ApTheme.PREF_CUSTOM_COLOR,
      0,
    );
    if (_currentColorIndex == ApTheme.customColorIndex &&
        customColorValue != 0) {
      _customColor = Color(customColorValue);
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
  }

  Future<void> _initLocale() async {
    final String languageCode = PreferenceUtil.instance.getString(
      widget.languageCodePreferenceKey,
      ApSupportLanguageConstants.system,
    );
    if (languageCode == ApSupportLanguageConstants.system) {
      await useApDeviceLocale();
    } else {
      final Locale locale = Locale(
        languageCode,
        languageCode == ApSupportLanguageConstants.zh ? 'TW' : null,
      );
      await setApLocaleFromFlutter(locale);
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

  /// Change the app's theme mode.
  void setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  /// Change the app's locale.
  void setLocale(Locale locale) {
    setApLocaleFromFlutter(locale);
    setState(() {});
  }

  /// Change the app's theme color.
  void setThemeColor(int index, Color? custom) {
    setState(() {
      _currentColorIndex = index;
      _customColor = custom;
    });
  }

  /// Force a rebuild.
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _LiquidGlassApAppScope(
      state: this,
      child: ApTheme(
        themeMode: _themeMode,
        currentColorIndex: _currentColorIndex,
        customColor: _customColor,
        preferences: PreferenceUtil.instance,
        child: Builder(
          builder: (BuildContext context) {
            final Color seedColor =
                ApTheme.of(context).seedColor;
            final GlassThemeData glassThemeData =
                GlassThemeBridge.fromContext(context);
            return TranslationProvider(
              child: Builder(
                builder: (BuildContext context) {
                  return GlassTheme(
                    data: glassThemeData,
                    child: MaterialApp(
                      home: widget.home,
                      onGenerateTitle:
                          widget.onGenerateTitle,
                      debugShowCheckedModeBanner: widget
                          .debugShowCheckedModeBanner,
                      routes: widget.routes,
                      onGenerateRoute:
                          widget.onGenerateRoute,
                      theme: ApTheme.light(seedColor),
                      darkTheme:
                          ApTheme.dark(seedColor),
                      themeMode: _themeMode,
                      locale: TranslationProvider.of(
                        context,
                      ).flutterLocale,
                      navigatorObservers:
                          widget.navigatorObservers,
                      supportedLocales:
                          AppLocaleUtils
                              .supportedLocales,
                      localizationsDelegates:
                          <LocalizationsDelegate<
                            dynamic
                          >>[
                        ...widget
                            .additionalLocalizationsDelegates,
                        GlobalMaterialLocalizations
                            .delegate,
                        GlobalWidgetsLocalizations
                            .delegate,
                        GlobalCupertinoLocalizations
                            .delegate,
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LiquidGlassApAppScope extends InheritedWidget {
  const _LiquidGlassApAppScope({
    required this.state,
    required super.child,
  });

  final LiquidGlassApAppState state;

  @override
  bool updateShouldNotify(_LiquidGlassApAppScope oldWidget) => true;
}
