import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A floating toolbar inspired by Apple iOS 26 Liquid Glass.
///
/// Renders two capsule-shaped glass groups (leading and
/// trailing) that float below the status bar, overlaying
/// content. Use inside a [Stack].
///
/// Widgets placed in [leading] and [trailing] should **not**
/// have their own glass layer — the toolbar capsule provides
/// the glass effect. Use plain [IconButton] or [Text].
class GlassFloatingToolbar extends StatelessWidget {
  const GlassFloatingToolbar({
    super.key,
    this.leading = const <Widget>[],
    this.trailing = const <Widget>[],
  });

  /// Widgets on the left capsule.
  final List<Widget> leading;

  /// Widgets on the right capsule.
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    final double topPadding =
        MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 6,
      left: 16,
      right: 16,
      child: Row(
        children: <Widget>[
          if (leading.isNotEmpty)
            GlassCard(
              useOwnLayer: true,
              height: 38,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              shape:
                  const LiquidRoundedSuperellipse(
                borderRadius: 19,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: leading,
              ),
            ),
          const Spacer(),
          if (trailing.isNotEmpty)
            GlassCard(
              useOwnLayer: true,
              height: 38,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              shape:
                  const LiquidRoundedSuperellipse(
                borderRadius: 19,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: trailing,
              ),
            ),
        ],
      ),
    );
  }
}
