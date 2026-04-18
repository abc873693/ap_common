import 'package:flutter/material.dart';

/// A swappable color palette for course cards.
///
/// Provides a fixed-length list of 12 distinct colors used by
/// [CourseScaffold], [CourseContent], [CourseEditSheet], and the
/// home dashboard widgets. Text drawn on top of course cards uses
/// [foregroundColor] directly — it does **not** vary per card based
/// on luminance, so every card in the same palette has the same
/// readable text color.
///
/// Apps inject a palette via [ThemeData.extensions]:
///
/// ```dart
/// MaterialApp(
///   theme: ThemeData.light().copyWith(
///     extensions: <ThemeExtension<dynamic>>[
///       CoursePaletteTheme.appleSystem,
///     ],
///   ),
/// );
/// ```
///
/// Or via [ApApp] / [ApTheme] which accept a [coursePalette] argument.
///
/// Palettes can carry an optional [dark] counterpart. When the app is
/// rendered in [Brightness.dark], [of] auto-resolves to that variant so
/// apps only need to register the light palette once.
@immutable
class CoursePaletteTheme extends ThemeExtension<CoursePaletteTheme> {
  const CoursePaletteTheme({
    required this.id,
    required this.name,
    required this.colors,
    required this.foregroundColor,
    this.dark,
  });

  /// The expected length of [colors]. All built-in palettes honor this
  /// so existing `Course.colorIndex` values stay visually stable when
  /// apps swap palettes. Custom palettes should match this length, but
  /// [colorAt] wraps with modulo so a shorter list still renders.
  static const int paletteLength = 12;

  /// Preference key used by [CourseScaffold]'s built-in palette picker
  /// to persist the user's choice across app launches.
  static const String preferenceKey = 'ap_common.course_palette_id';

  /// A stable identifier, useful for persisting the active palette
  /// or bridging to native widgets via SharedPreferences.
  final String id;

  /// Human-readable display name shown in palette pickers.
  final String name;

  /// The 12 course colors.
  final List<Color> colors;

  /// Text / icon color drawn on top of any course card.
  final Color foregroundColor;

  /// Optional dark-mode counterpart. When provided and the ambient
  /// [Brightness] is dark, [of] / [resolvedFor] return this variant
  /// instead of the light colors. The dark variant itself should not
  /// set [dark] — only the light palette does.
  final CoursePaletteTheme? dark;

  /// Resolve the palette from [BuildContext], falling back to
  /// [material] when no [CoursePaletteTheme] is registered. Honors the
  /// ambient [Brightness] by returning the [dark] variant when set.
  static CoursePaletteTheme of(BuildContext context) {
    final CoursePaletteTheme ext =
        Theme.of(context).extension<CoursePaletteTheme>() ?? material;
    return ext.resolvedFor(context);
  }

  /// Look up a built-in palette by [id]. Returns [material] if no
  /// match, so callers can safely pass persisted ids that may have
  /// been removed between app versions.
  static CoursePaletteTheme fromId(String? id) {
    for (final CoursePaletteTheme p in builtIn) {
      if (p.id == id) return p;
    }
    return material;
  }

  /// Return [dark] when the ambient brightness is dark and a dark
  /// variant exists; otherwise return this palette unchanged.
  CoursePaletteTheme resolvedFor(BuildContext context) {
    final CoursePaletteTheme? darkVariant = dark;
    if (darkVariant != null &&
        Theme.of(context).brightness == Brightness.dark) {
      return darkVariant;
    }
    return this;
  }

  /// Pick the color at [index], wrapping around if out of range.
  Color colorAt(int index) => colors[index.abs() % colors.length];

  /// Material Design 400 shade — matches the legacy `courseColors`
  /// constant, so existing `Course.colorIndex` values keep the same
  /// visual when no palette is injected.
  static const CoursePaletteTheme material = CoursePaletteTheme(
    id: 'material400',
    name: 'Material',
    colors: <Color>[
      Color(0xFF5C6BC0), // Indigo
      Color(0xFF26A69A), // Teal
      Color(0xFFEF5350), // Red
      Color(0xFFAB47BC), // Purple
      Color(0xFF42A5F5), // Blue
      Color(0xFFFF7043), // Deep Orange
      Color(0xFF66BB6A), // Green
      Color(0xFFFFCA28), // Amber
      Color(0xFF8D6E63), // Brown
      Color(0xFF78909C), // Blue Grey
      Color(0xFFEC407A), // Pink
      Color(0xFF7E57C2), // Deep Purple
    ],
    foregroundColor: Colors.white,
  );

  /// iOS System Colors (light variant) — higher saturation, feels
  /// native on Apple platforms. Pairs with [_appleSystemDark] in dark
  /// mode via the [dark] field.
  static const CoursePaletteTheme appleSystem = CoursePaletteTheme(
    id: 'appleSystem',
    name: 'Apple System',
    colors: <Color>[
      Color(0xFFFF3B30), // Red
      Color(0xFFFF9500), // Orange
      Color(0xFFFFCC00), // Yellow
      Color(0xFF34C759), // Green
      Color(0xFF00C7BE), // Mint
      Color(0xFF30B0C7), // Teal
      Color(0xFF32ADE6), // Cyan
      Color(0xFF007AFF), // Blue
      Color(0xFF5856D6), // Indigo
      Color(0xFFAF52DE), // Purple
      Color(0xFFFF2D55), // Pink
      Color(0xFFA2845E), // Brown
    ],
    foregroundColor: Colors.white,
    dark: _appleSystemDark,
  );

  /// iOS System Colors dark-mode hex values (stable from iOS 13
  /// through iOS 26). Registered as the [dark] counterpart of
  /// [appleSystem]; not meant to be used on its own.
  static const CoursePaletteTheme _appleSystemDark = CoursePaletteTheme(
    id: 'appleSystemDark',
    name: 'Apple System (Dark)',
    colors: <Color>[
      Color(0xFFFF453A), // Red
      Color(0xFFFF9F0A), // Orange
      Color(0xFFFFD60A), // Yellow
      Color(0xFF30D158), // Green
      Color(0xFF63E6E2), // Mint
      Color(0xFF40CBE0), // Teal
      Color(0xFF64D2FF), // Cyan
      Color(0xFF0A84FF), // Blue
      Color(0xFF5E5CE6), // Indigo
      Color(0xFFBF5AF2), // Purple
      Color(0xFFFF375F), // Pink
      Color(0xFFAC8E68), // Brown
    ],
    foregroundColor: Colors.white,
  );

  /// Muted pastel palette inspired by Google Calendar — softer on
  /// the eyes for long-form schedule reading.
  static const CoursePaletteTheme pastel = CoursePaletteTheme(
    id: 'pastel',
    name: 'Pastel',
    colors: <Color>[
      Color(0xFFD94F4C), // Tomato
      Color(0xFFE68C3E), // Tangerine
      Color(0xFFCBA84A), // Banana
      Color(0xFF7EB26D), // Sage
      Color(0xFF3E8B5B), // Basil
      Color(0xFF4A9DBF), // Peacock
      Color(0xFF5A7CC9), // Blueberry
      Color(0xFF8589C8), // Lavender
      Color(0xFF8A4A95), // Grape
      Color(0xFFE07C7C), // Flamingo
      Color(0xFF7D7D7D), // Graphite
      Color(0xFFA6786A), // Cocoa
    ],
    foregroundColor: Colors.white,
  );

  /// All built-in palettes shown in pickers, in display order. Dark
  /// variants are intentionally omitted — they are surfaced only via
  /// the [dark] field on their light parent.
  static const List<CoursePaletteTheme> builtIn = <CoursePaletteTheme>[
    material,
    appleSystem,
    pastel,
  ];

  @override
  CoursePaletteTheme copyWith({
    String? id,
    String? name,
    List<Color>? colors,
    Color? foregroundColor,
    CoursePaletteTheme? dark,
  }) {
    return CoursePaletteTheme(
      id: id ?? this.id,
      name: name ?? this.name,
      colors: colors ?? this.colors,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      dark: dark ?? this.dark,
    );
  }

  @override
  CoursePaletteTheme lerp(CoursePaletteTheme? other, double t) {
    if (other == null) return this;
    // Both palettes are expected to be length [paletteLength] — use the
    // shorter of the two as a safety net if a custom palette violates that.
    final int len = colors.length < other.colors.length
        ? colors.length
        : other.colors.length;
    final List<Color> lerped = <Color>[
      for (int i = 0; i < len; i++)
        Color.lerp(colors[i], other.colors[i], t) ?? colors[i],
    ];
    final bool pickOther = t >= 0.5;
    return CoursePaletteTheme(
      id: pickOther ? other.id : id,
      name: pickOther ? other.name : name,
      colors: lerped,
      foregroundColor:
          Color.lerp(foregroundColor, other.foregroundColor, t) ??
              foregroundColor,
      dark: pickOther ? other.dark : dark,
    );
  }
}
