import 'package:flutter/widgets.dart';

/// Defines a tab for [HomePageScaffold] bottom tab navigation.
///
/// When [HomePageScaffold.tabs] is provided, each [HomeTab] becomes
/// a destination in the bottom [NavigationBar] (mobile) or
/// [NavigationRail] (tablet). The [builder] creates the tab's root
/// page inside its own [Navigator].
class HomeTab {
  /// Creates a tab destination.
  const HomeTab({
    required this.icon,
    required this.label,
    required this.builder,
    this.activeIcon,
  });

  /// Icon for the navigation destination.
  final Widget icon;

  /// Icon shown when this tab is selected.
  final Widget? activeIcon;

  /// Text label for the navigation destination.
  final String label;

  /// Builds the root page for this tab.
  ///
  /// The widget is placed inside a per-tab [Navigator], so it can
  /// push sub-pages without affecting other tabs.
  final WidgetBuilder builder;
}
