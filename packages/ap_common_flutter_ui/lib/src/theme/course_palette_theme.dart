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
@immutable
class CoursePaletteTheme extends ThemeExtension<CoursePaletteTheme> {
  const CoursePaletteTheme({
    required this.id,
    required this.colors,
    required this.foregroundColor,
  });

  /// The expected length of [colors]. All built-in palettes honor this
  /// so existing `Course.colorIndex` values stay visually stable when
  /// apps swap palettes. Custom palettes should match this length, but
  /// [colorAt] wraps with modulo so a shorter list still renders.
  static const int paletteLength = 12;

  /// A stable identifier, useful for persisting the active palette
  /// or bridging to native widgets via SharedPreferences.
  final String id;

  /// The 12 course colors.
  final List<Color> colors;

  /// Text / icon color drawn on top of any course card.
  final Color foregroundColor;

  /// Resolve the palette from [BuildContext], falling back to
  /// [material] when no [CoursePaletteTheme] is registered.
  static CoursePaletteTheme of(BuildContext context) {
    return Theme.of(context).extension<CoursePaletteTheme>() ?? material;
  }

  /// Pick the color at [index], wrapping around if out of range.
  Color colorAt(int index) => colors[index.abs() % colors.length];

  /// Material Design 400 shade — matches the legacy `courseColors`
  /// constant, so existing `Course.colorIndex` values keep the same
  /// visual when no palette is injected.
  static const CoursePaletteTheme material = CoursePaletteTheme(
    id: 'material400',
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
  /// native on Apple platforms.
  static const CoursePaletteTheme appleSystem = CoursePaletteTheme(
    id: 'appleSystem',
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
  );

  /// Muted pastel palette inspired by Google Calendar — softer on
  /// the eyes for long-form schedule reading.
  static const CoursePaletteTheme pastel = CoursePaletteTheme(
    id: 'pastel',
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

  /// All built-in palettes, in display order.
  static const List<CoursePaletteTheme> builtIn = <CoursePaletteTheme>[
    material,
    appleSystem,
    pastel,
  ];

  @override
  CoursePaletteTheme copyWith({
    String? id,
    List<Color>? colors,
    Color? foregroundColor,
  }) {
    return CoursePaletteTheme(
      id: id ?? this.id,
      colors: colors ?? this.colors,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  @override
  CoursePaletteTheme lerp(CoursePaletteTheme? other, double t) {
    if (other == null) return this;
    // Palettes always have the same length (paletteLength).
    final List<Color> lerped = <Color>[
      for (int i = 0; i < colors.length; i++)
        Color.lerp(colors[i], other.colors[i], t) ?? colors[i],
    ];
    return CoursePaletteTheme(
      id: t < 0.5 ? id : other.id,
      colors: lerped,
      foregroundColor:
          Color.lerp(foregroundColor, other.foregroundColor, t) ??
              foregroundColor,
    );
  }
}
