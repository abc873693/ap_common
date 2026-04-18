import 'package:flutter/widgets.dart';

/// Role hint for a [HomeTab], used by [HomePageScaffold] to pick
/// the right visual treatment.
///
/// Mirrors the iOS 26 tab role concept. `standard` tabs render as
/// icon + label; `search` tabs render as a search pill.
enum HomeTabRole { standard, search }

/// Defines a tab for [HomePageScaffold] bottom tab navigation.
///
/// When [HomePageScaffold.tabs] is provided, each [HomeTab] becomes
/// a destination in the bottom navigation bar (mobile) or
/// [NavigationRail] (tablet). The [builder] creates the tab's root
/// page inside its own [Navigator].
class HomeTab {
  /// Creates a tab destination.
  const HomeTab({
    required this.icon,
    required this.label,
    required this.builder,
    this.activeIcon,
    this.role = HomeTabRole.standard,
  });

  /// Icon for the navigation destination.
  final Widget icon;

  /// Icon shown when this tab is selected.
  final Widget? activeIcon;

  /// Text label for the navigation destination. For [HomeTabRole.search]
  /// tabs, this is also used as the search pill placeholder.
  final String label;

  /// Builds the root page for this tab.
  ///
  /// The widget is placed inside a per-tab [Navigator], so it can
  /// push sub-pages without affecting other tabs.
  final WidgetBuilder builder;

  /// Role hint that influences how this tab is rendered.
  final HomeTabRole role;
}
