import 'dart:async';
import 'dart:io';

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass-enhanced version of [HomePageScaffold].
///
/// Replaces the Material [AppBar] with [GlassAppBar] and the
/// [NavigationBar] with [GlassBottomBar] while preserving all
/// original functionality (announcement carousel, responsive
/// layout, etc.).
class GlassHomePageScaffold extends StatefulWidget {
  const GlassHomePageScaffold({
    super.key,
    required this.state,
    required this.announcements,
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
    this.autoPlayDuration =
        const Duration(milliseconds: 5000),
  });

  /// Creates from a [DataState<List<Announcement>>].
  GlassHomePageScaffold.fromDataState({
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
    this.autoPlayDuration =
        const Duration(milliseconds: 5000),
  })  : state = dataState.when(
          loading: () => HomeState.loading,
          loaded: (_, __) => HomeState.finish,
          error: (_) => HomeState.error,
          empty: (_) => HomeState.empty,
        ),
        announcements =
            dataState.dataOrNull ?? <Announcement>[];

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

  @override
  GlassHomePageScaffoldState createState() =>
      GlassHomePageScaffoldState();
}

class GlassHomePageScaffoldState
    extends State<GlassHomePageScaffold> {
  final GlobalKey<ScaffoldMessengerState>
      _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  PageController? pageController;
  int _currentNewsIndex = 0;
  Timer? _timer;

  bool get isTablet =>
      MediaQuery.of(context).size.shortestSide >= 680;

  @override
  void initState() {
    _setTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          extendBodyBehindAppBar: true,
          appBar: isTablet
              ? null
              : GlassAppBar(
                  title: Text(widget.title ?? ''),
                  actions: widget.actions,
                ),
          drawer: isTablet ? null : widget.drawer,
          floatingActionButton:
              widget.floatingActionButton,
          body: Row(
            children: <Widget>[
              if (isTablet) widget.drawer!,
              Expanded(
                child: (isTablet &&
                        widget.content != null)
                    ? widget.content!
                    : OrientationBuilder(
                        builder:
                            (_, Orientation orientation) {
                          return Container(
                            padding:
                                EdgeInsets.symmetric(
                              vertical: orientation ==
                                      Orientation.portrait
                                  ? 32.0
                                  : 4.0,
                            ),
                            alignment: Alignment.center,
                            child:
                                _homeBody(orientation),
                          );
                        },
                      ),
              ),
            ],
          ),
          bottomNavigationBar:
              (widget.bottomNavigationBarItems == null ||
                      isTablet)
                  ? null
                  : NavigationBar(
                      elevation: 12.0,
                      height: 56,
                      indicatorColor:
                          const Color(0x00000000),
                      onDestinationSelected:
                          widget.onTabTapped,
                      destinations: widget
                          .bottomNavigationBarItems!,
                    ),
        ),
      ),
    );
  }

  void _setTimer() {
    if (widget.autoPlay) {
      _timer = Timer.periodic(
        widget.autoPlayDuration,
        (Timer timer) {
          if (widget.state == HomeState.finish &&
              widget.announcements.length > 1 &&
              pageController!.hasClients) {
            setState(() {
              _currentNewsIndex++;
              if (_currentNewsIndex >=
                  widget.announcements.length) {
                _currentNewsIndex = 0;
              }
              pageController?.animateToPage(
                _currentNewsIndex,
                duration:
                    const Duration(milliseconds: 500),
                curve: Curves.easeOutQuint,
              );
            });
          }
        },
      );
    }
  }

  Widget _newsImage(
    Announcement announcement,
    Orientation orientation,
    bool active,
  ) {
    return GestureDetector(
      onTap: () {
        widget.onImageTapped?.call(announcement);
        AnalyticsUtil.instance
            .logEvent('announcement_image_click');
      },
      onTapDown: (TapDownDetails detail) {
        _timer?.cancel();
      },
      onTapUp: (TapUpDetails detail) {
        _setTimer();
      },
      onTapCancel: () {
        _setTimer();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height *
              (active ? 0.05 : 0.15),
          horizontal:
              MediaQuery.of(context).size.width * 0.02,
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

  Widget _homeBody(Orientation orientation) {
    double viewportFraction = 0.65;
    if (orientation == Orientation.landscape) {
      viewportFraction = 0.5;
    }
    pageController = PageController(
      viewportFraction: viewportFraction,
    );
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: ApConstants.tagAnnouncementTitle,
              child: Material(
                color: const Color(0x00000000),
                child: Text(
                  widget
                      .announcements[_currentNewsIndex]
                      .title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Hero(
              tag: ApConstants.tagAnnouncementIcon,
              child: Icon(Icons.arrow_drop_down),
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.announcements.length,
                itemBuilder: (
                  BuildContext context,
                  int currentIndex,
                ) {
                  final bool active =
                      currentIndex == _currentNewsIndex;
                  return _newsImage(
                    widget.announcements[currentIndex],
                    orientation,
                    active,
                  );
                },
              ),
            ),
            SizedBox(
              height:
                  orientation == Orientation.portrait
                      ? 16.0
                      : 4.0,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                  fontSize: 24.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${widget.announcements.length >= 10 && _currentNewsIndex < 9 ? '0' : ''}'
                        '${_currentNewsIndex + 1}',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' / ${widget.announcements.length}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height:
                  orientation == Orientation.portrait
                      ? 24.0
                      : 0.0,
            ),
          ],
        );
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

  void _showLogoutDialog() {
    final ApLocalizations l10n = context.ap;
    showDialog(
      context: context,
      builder: (BuildContext context) => YesNoDialog(
        title: l10n.closeAppTitle,
        contentWidget: Text(
          l10n.closeAppHint,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant,
          ),
        ),
        leftActionText: l10n.cancel,
        rightActionText: l10n.confirm,
        rightActionFunction: () {
          AnalyticsUtil.instance
              .logEvent('logout_dialog_confirm');
          SystemNavigator.pop();
        },
      ),
    );
    AnalyticsUtil.instance
        .logEvent('logout_dialog_open');
  }

  /// Hide the current snack bar.
  void hideSnackBar() {
    _scaffoldMessengerKey.currentState
        ?.hideCurrentSnackBar();
  }

  /// Show a short hint snack bar.
  void showBasicHint({required String text}) {
    showSnackBar(
      text: text,
      duration: const Duration(seconds: 2),
    );
  }

  /// Show a snack bar with optional action.
  ScaffoldFeatureController<SnackBar,
      SnackBarClosedReason>?
      showSnackBar({
    required String text,
    String? actionText,
    Function()? onSnackBarTapped,
    Duration? duration,
  }) {
    return _scaffoldMessengerKey.currentState
        ?.showSnackBar(
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
