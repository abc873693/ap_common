import 'dart:math' as math;

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Apple standard light angle: 135° (upper-left light source).
const double _kLightAngle = 0.75 * math.pi;

/// Bridges [ApTheme] seed colors to [GlassThemeData].
///
/// Maps the current [ColorScheme] to [GlassGlowColors] and
/// configures [LiquidGlassSettings] following Apple's Liquid
/// Glass design guidelines (consistent light angle, appropriate
/// glass tint per brightness, etc.).
///
/// ```dart
/// GlassTheme(
///   data: GlassThemeBridge.fromContext(context),
///   child: child,
/// )
/// ```
class GlassThemeBridge {
  const GlassThemeBridge._();

  /// Creates a [GlassThemeData] aligned with the current
  /// [ApTheme] / [ColorScheme].
  ///
  /// Uses [GlassQuality.standard] for broad compatibility.
  /// Override via [LiquidGlassSettings] for per-widget control.
  static GlassThemeData fromContext(
    BuildContext context,
  ) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return GlassThemeData(
      light: GlassThemeVariant(
        quality: GlassQuality.standard,
        settings: const LiquidGlassSettings(
          glassColor: Color.fromRGBO(
            255,
            255,
            255,
            0.12,
          ),
          thickness: 30,
          blur: 3,
          lightAngle: _kLightAngle,
          lightIntensity: 2.0,
          refractiveIndex: 0.7,
        ),
        glowColors: GlassGlowColors(
          primary: colorScheme.primary,
          secondary: colorScheme.secondary,
          success: const Color(0xFF34C759),
          warning: const Color(0xFFFF9500),
          danger: colorScheme.error,
          info: const Color(0xFF5AC8FA),
        ),
      ),
      dark: GlassThemeVariant(
        quality: GlassQuality.standard,
        settings: const LiquidGlassSettings(
          glassColor: Color.fromRGBO(
            255,
            255,
            255,
            0.08,
          ),
          thickness: 40,
          lightAngle: _kLightAngle,
          lightIntensity: 1.5,
          refractiveIndex: 0.7,
        ),
        glowColors: GlassGlowColors(
          primary: colorScheme.primary,
          secondary: colorScheme.secondary,
          success: const Color(0xFF30D158),
          warning: const Color(0xFFFF9F0A),
          danger: colorScheme.error,
          info: const Color(0xFF64D2FF),
        ),
      ),
    );
  }

  /// Creates a [GlassThemeData] with custom settings while
  /// still bridging [GlassGlowColors] from the [ColorScheme].
  static GlassThemeData withSettings({
    required BuildContext context,
    LiquidGlassSettings? lightSettings,
    LiquidGlassSettings? darkSettings,
    GlassQuality quality = GlassQuality.standard,
  }) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final GlassGlowColors glowColors = GlassGlowColors(
      primary: colorScheme.primary,
      secondary: colorScheme.secondary,
      success: const Color(0xFF34C759),
      warning: const Color(0xFFFF9500),
      danger: colorScheme.error,
      info: const Color(0xFF5AC8FA),
    );

    return GlassThemeData(
      light: GlassThemeVariant(
        settings: lightSettings,
        quality: quality,
        glowColors: glowColors,
      ),
      dark: GlassThemeVariant(
        settings: darkSettings,
        quality: quality,
        glowColors: glowColors,
      ),
    );
  }
}
