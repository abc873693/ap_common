import 'dart:async';
import 'dart:io';

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum HomeState { loading, finish, error, empty, offline }

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

  bool get isTablet =>
      MediaQuery.of(context).size.shortestSide >= 680;

  @override
  void initState() {
    if (widget.tabs != null) {
      _tabNavigatorKeys =
          List<GlobalKey<NavigatorState>>.generate(
        widget.tabs!.length,
        (_) => GlobalKey<NavigatorState>(),
      );
    }
    setTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
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
            _tabNavigatorKeys[_currentTabIndex]
                .currentState;
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
        child: isTablet
            ? _buildTabletTabScaffold()
            : _buildMobileTabScaffold(),
      ),
    );
  }

  Widget _buildMobileTabScaffold() {
    final ColorScheme colors =
        Theme.of(context).colorScheme;
    return Scaffold(
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
      extendBody: true,
      body: _buildTabBody(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          12,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(28),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: colors.shadow.withValues(
                alpha: 0.08,
              ),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: NavigationBar(
            elevation: 0,
            height: 56,
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            selectedIndex: _currentTabIndex,
            onDestinationSelected: (int index) {
              setState(
                () => _currentTabIndex = index,
              );
            },
            destinations: widget.tabs!
                .map(
                  (HomeTab tab) =>
                      NavigationDestination(
                    icon: tab.icon,
                    selectedIcon: tab.activeIcon,
                    label: tab.label,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletTabScaffold() {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _currentTabIndex,
            onDestinationSelected: (int index) {
              setState(() => _currentTabIndex = index);
            },
            labelType: NavigationRailLabelType.all,
            destinations: widget.tabs!
                .map(
                  (HomeTab tab) =>
                      NavigationRailDestination(
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

  Widget _buildTabBody() {
    return IndexedStack(
      index: _currentTabIndex,
      children: List<Widget>.generate(
        widget.tabs!.length,
        (int index) => Navigator(
          key: _tabNavigatorKeys[index],
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute<void>(
              builder: widget.tabs![index].builder,
              settings: settings,
            );
          },
        ),
      ),
    );
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
