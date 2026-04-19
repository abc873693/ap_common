import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum HomeState { loading, finish, error, empty, offline }

/// Equal width per tab item in the floating tab bar. Sized to fit
/// 4-character CJK labels comfortably.
const double _kTabItemWidth = 64.0;

class HomePageScaffold extends StatefulWidget {
  const HomePageScaffold({
    super.key,
    this.state = HomeState.loading,
    this.announcements = const <Announcement>[],
    this.isLogin = false,
    this.actions,
    this.onTabTapped,
    this.bottomNavigationBarItems,
    this.drawer,
    this.content,
    this.floatingActionButton,
    this.title,
    this.onImageTapped,
    this.autoPlay = true,
    this.autoPlayDuration = const Duration(milliseconds: 5000),
    this.dashboardWidgets,
    this.carouselHeight,
    this.tabs,
    this.enableHaptics = true,
    this.showDrawerOnMobileWhenTabbed = false,
    this.minimizeTabBarOnScroll = true,
  });

  /// Creates a [HomePageScaffold] from a [DataState<List<Announcement>>].
  ///
  /// ```dart
  /// HomePageScaffold.fromDataState(
  ///   dataState: DataLoaded(announcements),
  ///   isLogin: true,
  ///   drawer: myDrawer,
  /// )
  /// ```
  HomePageScaffold.fromDataState({
    super.key,
    required DataState<List<Announcement>> dataState,
    required this.isLogin,
    this.actions,
    this.onTabTapped,
    this.bottomNavigationBarItems,
    this.drawer,
    this.content,
    this.floatingActionButton,
    this.title,
    this.onImageTapped,
    this.autoPlay = true,
    this.autoPlayDuration = const Duration(milliseconds: 5000),
    this.dashboardWidgets,
    this.carouselHeight,
    this.tabs,
    this.enableHaptics = true,
    this.showDrawerOnMobileWhenTabbed = false,
    this.minimizeTabBarOnScroll = true,
  })  : state = dataState.when(
          loading: () => HomeState.loading,
          loaded: (_, __) => HomeState.finish,
          error: (_) => HomeState.error,
          empty: (_) => HomeState.empty,
        ),
        announcements = dataState.dataOrNull ?? <Announcement>[];

  final HomeState state;
  final String? title;
  final List<Announcement> announcements;
  final List<Widget>? actions;
  final List<Widget>? bottomNavigationBarItems;

  final Function(int index)? onTabTapped;
  final Function(Announcement announcement)? onImageTapped;

  final Widget? drawer;
  final Widget? content;
  final Widget? floatingActionButton;

  final bool isLogin;
  final bool autoPlay;
  final Duration autoPlayDuration;

  /// Additional widgets displayed below the carousel in a scrollable
  /// dashboard layout. When provided, the carousel is given a fixed
  /// height and the entire content area becomes scrollable.
  ///
  /// When `null`, the original full-screen carousel layout is used.
  final List<Widget>? dashboardWidgets;

  /// Fixed height for the carousel when [dashboardWidgets] is set.
  /// Defaults to 260 in portrait and 180 in landscape.
  final double? carouselHeight;

  /// Tab definitions for bottom tab navigation mode.
  ///
  /// When non-null, the scaffold uses [IndexedStack] with per-tab
  /// [Navigator]s instead of the default drawer-based layout.
  final List<HomeTab>? tabs;

  /// Play a haptic tick when switching tabs. Default: true.
  final bool enableHaptics;

  /// Show the drawer on mobile while in tabs mode.
  ///
  /// Default: false. Modern tabbed apps (Telegram, Instagram) hide
  /// the drawer on mobile in favour of tab-only navigation; the drawer
  /// is still shown on tablet as a sidebar.
  final bool showDrawerOnMobileWhenTabbed;

  /// Slide the floating tab bar out of view on downward scroll and
  /// bring it back on upward scroll (iOS 26 tab bar minimize).
  /// Default: true.
  final bool minimizeTabBarOnScroll;

  @override
  HomePageScaffoldState createState() => HomePageScaffoldState();
}

class HomePageScaffoldState extends State<HomePageScaffold> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  PageController? pageController;

  int _currentNewsIndex = 0;

  Timer? _timer;

  int _currentTabIndex = 0;
  List<GlobalKey<NavigatorState>> _tabNavigatorKeys =
      <GlobalKey<NavigatorState>>[];
  List<ScrollController> _tabScrollControllers = <ScrollController>[];
  List<NavigatorObserver> _tabNavigatorObservers = <NavigatorObserver>[];

  bool _navBarVisible = true;
  double _scrollBuffer = 0.0;

  /// Incremented when any tab's Navigator has an active [PopupRoute]
  /// (modal bottom sheet, dialog, popup menu). Hides the floating tab
  /// bar so it doesn't overlap the modal content.
  int _popupRouteDepth = 0;

  /// Null means follow the adaptive default (expanded when width >= 1200).
  bool? _railExtendedOverride;

  bool get isTablet => MediaQuery.of(context).size.shortestSide >= 680;

  bool get _isRailExtended {
    if (_railExtendedOverride != null) return _railExtendedOverride!;
    return MediaQuery.of(context).size.width >= 1200;
  }

  bool get _navBarEffectivelyVisible => _navBarVisible && _popupRouteDepth == 0;

  @override
  void initState() {
    if (widget.tabs != null) {
      _tabNavigatorKeys = List<GlobalKey<NavigatorState>>.generate(
        widget.tabs!.length,
        (_) => GlobalKey<NavigatorState>(),
      );
      _tabScrollControllers = List<ScrollController>.generate(
        widget.tabs!.length,
        (_) => ScrollController(),
      );
      _tabNavigatorObservers = List<NavigatorObserver>.generate(
        widget.tabs!.length,
        (_) => _PopupRouteAwareObserver(
          onPopupPushed: _onPopupPushed,
          onPopupRemoved: _onPopupRemoved,
        ),
      );
    }
    setTimer();
    super.initState();
  }

  void _onPopupPushed() {
    if (!mounted) return;
    setState(() => _popupRouteDepth++);
  }

  void _onPopupRemoved() {
    if (!mounted) return;
    setState(() {
      _popupRouteDepth = (_popupRouteDepth - 1).clamp(0, 1 << 20);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final ScrollController controller in _tabScrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs != null && widget.tabs!.isNotEmpty) {
      return _buildTabMode();
    }
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) {
        if (Platform.isAndroid) {
          _showLogoutDialog();
        } else {
          SystemNavigator.pop();
        }
      },
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          appBar: isTablet
              ? null
              : AppBar(
                  title: Text(widget.title ?? ''),
                  actions: widget.actions,
                ),
          drawer: isTablet ? null : widget.drawer,
          floatingActionButton: widget.floatingActionButton,
          body: Row(
            children: <Widget>[
              if (isTablet) widget.drawer!,
              Expanded(
                child: (isTablet && widget.content != null)
                    ? widget.content!
                    : OrientationBuilder(
                        builder: (_, Orientation orientation) {
                          final bool hasDash =
                              widget.dashboardWidgets != null &&
                                  widget.dashboardWidgets!.isNotEmpty;
                          final double vPad =
                              orientation == Orientation.portrait
                                  ? (hasDash ? 12.0 : 32.0)
                                  : 4.0;
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: vPad,
                            ),
                            alignment: Alignment.center,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: KeyedSubtree(
                                key: ValueKey<HomeState>(widget.state),
                                child: _homebody(orientation),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          bottomNavigationBar:
              (widget.bottomNavigationBarItems == null || isTablet)
                  ? null
                  : NavigationBar(
                      elevation: 12.0,
                      height: 56,
                      indicatorColor: const Color(0x00000000),
                      onDestinationSelected: widget.onTabTapped,
                      destinations: widget.bottomNavigationBarItems!,
                    ),
        ),
      ),
    );
  }

  void setTimer() {
    if (widget.autoPlay) {
      _timer = Timer.periodic(
        widget.autoPlayDuration,
        (Timer timer) {
          if (widget.state == HomeState.finish &&
              widget.announcements.length > 1 &&
              pageController!.hasClients) {
            setState(() {
              _currentNewsIndex++;
              if (_currentNewsIndex >= widget.announcements.length) {
                _currentNewsIndex = 0;
              }
              pageController?.animateToPage(
                _currentNewsIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutQuint,
              );
            });
          }
        },
      );
    }
  }

  // Original full-screen carousel layout (no dashboard).
  Widget _buildCarouselLayout(Orientation orientation) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildAnnouncementTitle(),
        const Hero(
          tag: ApConstants.tagAnnouncementIcon,
          child: Icon(Icons.arrow_drop_down),
        ),
        Expanded(
          child: _buildPageView(orientation),
        ),
        SizedBox(
          height: orientation == Orientation.portrait ? 16.0 : 4.0,
        ),
        _buildPageIndicator(),
        SizedBox(
          height: orientation == Orientation.portrait ? 24.0 : 0.0,
        ),
      ],
    );
  }

  // Dashboard layout: carousel at fixed height + scrollable widgets.
  Widget _buildDashboardLayout(Orientation orientation) {
    final bool isPortrait = orientation == Orientation.portrait;

    // Split available height 1:1 between dashboard widgets
    // and announcement carousel.
    final double screenHeight = MediaQuery.of(context).size.height;
    // Subtract AppBar(56) + BottomNav(56) + StatusBar(~44)
    // + spacing/indicators(~60)
    final double available = screenHeight - 56 - 56 - 44 - 60;
    final double halfH = widget.carouselHeight ??
        (isPortrait
            ? (available * 0.5).clamp(180.0, 350.0)
            : (available * 0.5).clamp(120.0, 200.0));

    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        // Dashboard widgets
        SizedBox(
          height: halfH,
          child: ListView(
            padding: EdgeInsets.zero,
            children: widget.dashboardWidgets!,
          ),
        ),
        // Carousel section
        SizedBox(
          height: halfH,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _buildPageView(orientation),
              ),
              _buildAnnouncementTitle(),
              const SizedBox(height: 4),
              _buildPageIndicator(),
            ],
          ),
        ),
        SizedBox(
          height: isPortrait ? 16.0 : 8.0,
        ),
      ],
    );
  }

  Widget _buildAnnouncementTitle() {
    return Hero(
      tag: ApConstants.tagAnnouncementTitle,
      child: Material(
        color: const Color(0x00000000),
        child: Text(
          widget.announcements[_currentNewsIndex].title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPageView(Orientation orientation) {
    return PageView.builder(
      controller: pageController,
      itemCount: widget.announcements.length,
      itemBuilder: (BuildContext context, int currentIndex) {
        final bool active = currentIndex == _currentNewsIndex;
        return _newsImage(
          widget.announcements[currentIndex],
          orientation,
          active,
        );
      },
    );
  }

  Widget _buildPageIndicator() {
    return Semantics(
      liveRegion: true,
      label:
          // ignore: lines_longer_than_80_chars
          '${_currentNewsIndex + 1} / ${widget.announcements.length}',
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 24.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text:
                  // ignore: lines_longer_than_80_chars
                  '${widget.announcements.length >= 10 && _currentNewsIndex < 9 ? '0' : ''}'
                  '${_currentNewsIndex + 1}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextSpan(
              text: ' / ${widget.announcements.length}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _newsImage(
    Announcement announcement,
    Orientation orientation,
    bool active,
  ) {
    return GestureDetector(
      onTap: () {
        widget.onImageTapped?.call(announcement);
        AnalyticsUtil.instance.logEvent('announcement_image_click');
      },
      onTapDown: (TapDownDetails detail) {
        _timer?.cancel();
      },
      onTapUp: (TapUpDetails detail) {
        setTimer();
      },
      onTapCancel: () {
        setTimer();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * (active ? 0.05 : 0.15),
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        child: Hero(
          tag: announcement.hashCode,
          child: ApNetworkImage(
            url: announcement.imgUrl,
          ),
        ),
      ),
    );
  }

  Widget _homebody(Orientation orientation) {
    double viewportFraction = 0.65;
    if (orientation == Orientation.portrait) {
      viewportFraction = 0.65;
    } else if (orientation == Orientation.landscape) {
      viewportFraction = 0.5;
    }
    pageController = PageController(viewportFraction: viewportFraction);
    pageController!.addListener(() {
      final int next = pageController!.page!.round();
      if (_currentNewsIndex != next) {
        setState(() {
          _currentNewsIndex = next;
        });
      }
    });
    switch (widget.state) {
      case HomeState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case HomeState.finish:
        final bool hasDashboard = widget.dashboardWidgets != null &&
            widget.dashboardWidgets!.isNotEmpty;

        if (hasDashboard) {
          return _buildDashboardLayout(orientation);
        }
        return _buildCarouselLayout(orientation);
      case HomeState.offline:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: context.ap.offlineMode,
        );
      case HomeState.empty:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: context.ap.announcementEmpty,
        );
      case HomeState.error:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: context.ap.somethingError,
        );
    }
  }

  // ─── Tab navigation mode ────────────────────────────────

  Widget _buildTabMode() {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) {
        final NavigatorState? navigator =
            _tabNavigatorKeys[_currentTabIndex].currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
          return;
        }
        if (_currentTabIndex != 0) {
          setState(() => _currentTabIndex = 0);
          return;
        }
        if (Platform.isAndroid) {
          _showLogoutDialog();
        } else {
          SystemNavigator.pop();
        }
      },
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: isTablet ? _buildTabletTabScaffold() : _buildMobileTabScaffold(),
      ),
    );
  }

  Widget _buildMobileTabScaffold() {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: widget.showDrawerOnMobileWhenTabbed ? widget.drawer : null,
      floatingActionButton: widget.floatingActionButton,
      extendBody: true,
      // Body keeps the original MediaQuery so an inner Scaffold's
      // FloatingActionButton stays at the screen's bottom-right, sitting
      // beside the tab bar at roughly the same baseline. This mirrors the
      // iOS 26 Liquid Glass pattern of two floating pills (navigation +
      // trailing action) side-by-side. Modal sheets are handled
      // separately by the PopupRoute observer below.
      body: Stack(
        children: <Widget>[
          _buildTabBody(),
          _buildBottomScrim(colors),
        ],
      ),
      bottomNavigationBar: AnimatedSlide(
        offset: _navBarEffectivelyVisible ? Offset.zero : const Offset(0, 2),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _navBarEffectivelyVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: SafeArea(
            top: false,
            // Match the inner Scaffold's FloatingActionButton baseline
            // (kFloatingActionButtonMargin = 16) so the tab bar pill and
            // the trailing FAB sit on the same horizontal line.
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                heightFactor: 1,
                child: _buildFloatingNavBar(colors),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletTabScaffold() {
    final bool extended = _isRailExtended;
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _currentTabIndex,
            onDestinationSelected: _onTabSelected,
            extended: extended,
            labelType: extended
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            leading: IconButton(
              tooltip: extended ? 'Collapse sidebar' : 'Expand sidebar',
              icon: Icon(
                extended ? Icons.menu_open : Icons.menu,
              ),
              onPressed: () {
                setState(() => _railExtendedOverride = !extended);
              },
            ),
            destinations: widget.tabs!
                .map(
                  (HomeTab tab) => NavigationRailDestination(
                    icon: tab.icon,
                    selectedIcon: tab.activeIcon,
                    label: Text(tab.label),
                  ),
                )
                .toList(),
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          Expanded(child: _buildTabBody()),
        ],
      ),
    );
  }

  /// A gradient scrim layered behind the floating tab bar (and any
  /// trailing FAB) so they remain readable over scrolling content.
  /// Mirrors the iOS Music / Maps pattern where the tab area fades to
  /// a darker tone at the bottom of the screen.
  Widget _buildBottomScrim(ColorScheme colors) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 160,
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: _navBarEffectivelyVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  colors.surface.withValues(alpha: 0),
                  colors.surface.withValues(alpha: 0.55),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingNavBar(ColorScheme colors) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildNavItems(colors),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(
    ColorScheme colors,
  ) {
    return widget.tabs!.asMap().entries.map(
      (MapEntry<int, HomeTab> entry) {
        final int index = entry.key;
        final HomeTab tab = entry.value;
        final bool selected = index == _currentTabIndex;
        return GestureDetector(
          onTap: () => _onTabSelected(index),
          behavior: HitTestBehavior.opaque,
          child: tab.role == HomeTabRole.search
              ? _buildSearchNavItem(tab, selected, colors)
              : _buildStandardNavItem(tab, selected, colors),
        );
      },
    ).toList();
  }

  Widget _buildStandardNavItem(
    HomeTab tab,
    bool selected,
    ColorScheme colors,
  ) {
    return SizedBox(
      width: _kTabItemWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                size: 22,
                color: selected ? colors.primary : colors.onSurfaceVariant,
              ),
              child: selected ? (tab.activeIcon ?? tab.icon) : tab.icon,
            ),
            const SizedBox(height: 2),
            Text(
              tab.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? colors.primary : colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchNavItem(
    HomeTab tab,
    bool selected,
    ColorScheme colors,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: (selected ? colors.primary : colors.onSurfaceVariant)
              .withValues(alpha: selected ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                size: 18,
                color: selected ? colors.primary : colors.onSurfaceVariant,
              ),
              child: selected ? (tab.activeIcon ?? tab.icon) : tab.icon,
            ),
            const SizedBox(width: 6),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: selected ? colors.primary : colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBody() {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: IndexedStack(
        index: _currentTabIndex,
        children: List<Widget>.generate(
          widget.tabs!.length,
          (int index) => PrimaryScrollController(
            controller: _tabScrollControllers[index],
            child: Navigator(
              key: _tabNavigatorKeys[index],
              observers: <NavigatorObserver>[_tabNavigatorObservers[index]],
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute<void>(
                  builder: widget.tabs![index].builder,
                  settings: settings,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTabSelected(int index) async {
    if (widget.enableHaptics) {
      unawaited(HapticFeedback.selectionClick());
    }
    if (index == _currentTabIndex) {
      final NavigatorState? nav = _tabNavigatorKeys[index].currentState;
      if (nav != null && nav.canPop()) {
        nav.popUntil((Route<dynamic> route) => route.isFirst);
        return;
      }
      final ScrollController controller = _tabScrollControllers[index];
      if (controller.hasClients && controller.offset > 0) {
        unawaited(
          controller.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          ),
        );
      }
      return;
    }
    setState(() => _currentTabIndex = index);
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (!widget.minimizeTabBarOnScroll) return false;
    if (notification.metrics.axis != Axis.vertical) return false;
    if (notification is ScrollUpdateNotification) {
      final double delta = notification.scrollDelta ?? 0.0;
      _scrollBuffer += delta;
      if (_scrollBuffer > 24 && _navBarVisible) {
        setState(() => _navBarVisible = false);
        _scrollBuffer = 0;
      } else if (_scrollBuffer < -24 && !_navBarVisible) {
        setState(() => _navBarVisible = true);
        _scrollBuffer = 0;
      }
    } else if (notification is ScrollEndNotification) {
      _scrollBuffer = 0;
    }
    return false;
  }

  void _showLogoutDialog() {
    final ApLocalizations l10n = context.ap;
    showDialog(
      context: context,
      builder: (BuildContext context) => YesNoDialog(
        title: l10n.closeAppTitle,
        contentWidget: Text(
          l10n.closeAppHint,
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        leftActionText: l10n.cancel,
        rightActionText: l10n.confirm,
        rightActionFunction: () {
          AnalyticsUtil.instance.logEvent('logout_dialog_confirm');
          SystemNavigator.pop();
        },
      ),
    );
    AnalyticsUtil.instance.logEvent('logout_dialog_open');
  }

  void hideSnackBar() {
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }

  void showBasicHint({required String text}) {
    showSnackBar(
      text: text,
      duration: const Duration(seconds: 2),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showSnackBar({
    required String text,
    String? actionText,
    Function()? onSnackBarTapped,
    Duration? duration,
  }) {
    return _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: duration ?? const Duration(days: 1),
        action: actionText == null
            ? null
            : SnackBarAction(
                onPressed: onSnackBarTapped!,
                label: actionText,
              ),
      ),
    );
  }
}

/// Notifies [HomePageScaffold] when a [PopupRoute] (modal bottom sheet,
/// dialog, popup menu) is pushed onto or removed from a tab's Navigator,
/// so the floating tab bar can be hidden while the modal is visible.
class _PopupRouteAwareObserver extends NavigatorObserver {
  _PopupRouteAwareObserver({
    required this.onPopupPushed,
    required this.onPopupRemoved,
  });

  final VoidCallback onPopupPushed;
  final VoidCallback onPopupRemoved;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PopupRoute) {
      onPopupPushed();
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PopupRoute) {
      onPopupRemoved();
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PopupRoute) {
      onPopupRemoved();
    }
  }
}
