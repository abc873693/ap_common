import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Bridges [ApTheme] seed colors to [GlassThemeData].
///
/// This ensures glass widgets use settings that complement the
/// current AP theme configuration.
///
/// ```dart
/// GlassTheme(
///   data: GlassThemeBridge.fromContext(context),
///   child: child,
/// )
/// ```
class GlassThemeBridge {
  const GlassThemeBridge._();

  /// Creates a [GlassThemeData] aligned with the current theme.
  ///
  /// Uses [GlassQuality.standard] for broad compatibility.
  /// Override via [LiquidGlassSettings] for per-widget control.
  static GlassThemeData fromContext(
    BuildContext context,
  ) {
    return const GlassThemeData(
      light: GlassThemeVariant(
        quality: GlassQuality.standard,
      ),
      dark: GlassThemeVariant(
        quality: GlassQuality.standard,
      ),
    );
  }

  /// Creates a [GlassThemeData] with custom settings.
  static GlassThemeData withSettings({
    LiquidGlassSettings? lightSettings,
    LiquidGlassSettings? darkSettings,
    GlassQuality quality = GlassQuality.standard,
  }) {
    return GlassThemeData(
      light: GlassThemeVariant(
        settings: lightSettings,
        quality: quality,
      ),
      dark: GlassThemeVariant(
        settings: darkSettings,
        quality: quality,
      ),
    );
  }
}
