import 'dart:async';
import 'dart:io';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/generated/l10n.dart';
import 'package:ap_common/widgets/ap_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';

export 'package:ap_common/models/announcement_data.dart';

enum HomeState { loading, finish, error, empty, offline }

class HomePageScaffold extends StatefulWidget {
  final HomeState state;
  final String title;
  final List<Announcement> announcements;
  final List<Widget> actions;
  final List<BottomNavigationBarItem> bottomNavigationBarItems;

  final Function(int index) onTabTapped;
  final Function(Announcement announcement) onImageTapped;

  final Widget drawer;
  final Widget content;
  final Widget floatingActionButton;

  final bool isLogin;
  final bool autoPlay;
  final Duration autoPlayDuration;

  const HomePageScaffold({
    Key key,
    @required this.state,
    @required this.announcements,
    @required this.isLogin,
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
  }) : super(key: key);

  @override
  HomePageScaffoldState createState() => HomePageScaffoldState();
}

class HomePageScaffoldState extends State<HomePageScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ApLocalizations app;

  PageController pageController;

  int _currentNewsIndex = 0;

  Timer _timer;

  bool get isTablet => MediaQuery.of(context).size.shortestSide >= 680;

  @override
  void initState() {
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
    app = ApLocalizations.of(context);
    return WillPopScope(
      child: Row(
        children: [
          if (isTablet) widget.drawer,
          Expanded(
            child: (isTablet && widget.content != null)
                ? widget.content
                : Scaffold(
                    key: _scaffoldKey,
                    appBar: AppBar(
                      title: Text(widget.title ?? ''),
                      backgroundColor: ApTheme.of(context).blue,
                      actions: widget.actions,
                    ),
                    drawer: isTablet ? null : widget.drawer,
                    floatingActionButton: widget.floatingActionButton,
                    body: OrientationBuilder(
                      builder: (_, orientation) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: orientation == Orientation.portrait
                                ? 32.0
                                : 4.0,
                          ),
                          alignment: Alignment.center,
                          child: _homebody(orientation),
                        );
                      },
                    ),
                    bottomNavigationBar:
                        (widget.bottomNavigationBarItems == null || isTablet)
                            ? null
                            : BottomNavigationBar(
                                elevation: 12.0,
                                fixedColor:
                                    ApTheme.of(context).bottomNavigationSelect,
                                unselectedItemColor:
                                    ApTheme.of(context).bottomNavigationSelect,
                                type: BottomNavigationBarType.fixed,
                                selectedFontSize: 12.0,
                                unselectedFontSize: 12.0,
                                selectedIconTheme: IconThemeData(size: 24.0),
                                onTap: widget.onTabTapped,
                                items: widget.bottomNavigationBarItems,
                              ),
                  ),
          ),
        ],
      ),
      onWillPop: () async {
        if (Platform.isAndroid) {
          _showLogoutDialog();
          return false;
        }
        return true;
      },
    );
  }

  setTimer() {
    if (widget.autoPlay)
      _timer = Timer.periodic(
        widget.autoPlayDuration,
        (Timer timer) {
          if (widget.state == HomeState.finish &&
              widget.announcements.length > 1)
            setState(() {
              _currentNewsIndex++;
              if (_currentNewsIndex >= widget.announcements.length)
                _currentNewsIndex = 0;
              pageController.animateToPage(
                _currentNewsIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuint,
              );
            });
        },
      );
  }

  Widget _newsImage(
    Announcement announcement,
    Orientation orientation,
    bool active,
  ) {
    return GestureDetector(
      onTap: () {
        if (widget.onImageTapped != null) widget.onImageTapped(announcement);
      },
      onTapDown: (detail) {
        _timer?.cancel();
      },
      onTapUp: (detail) {
        setTimer();
      },
      onTapCancel: () {
        setTimer();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
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
    pageController.addListener(() {
      int next = pageController.page.round();
      if (_currentNewsIndex != next) {
        setState(() {
          _currentNewsIndex = next;
        });
      }
    });
    switch (widget.state) {
      case HomeState.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case HomeState.finish:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: ApConstants.TAG_ANNOUNCEMENT_TITLE,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.announcements[_currentNewsIndex].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: ApTheme.of(context).grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Hero(
              tag: ApConstants.TAG_ANNOUNCEMENT_ICON,
              child: Icon(Icons.arrow_drop_down),
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.announcements.length,
                itemBuilder: (context, int currentIndex) {
                  bool active = (currentIndex == _currentNewsIndex);
                  return _newsImage(
                    widget.announcements[currentIndex],
                    orientation,
                    active,
                  );
                },
              ),
            ),
            SizedBox(height: orientation == Orientation.portrait ? 16.0 : 4.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style:
                    TextStyle(color: ApTheme.of(context).grey, fontSize: 24.0),
                children: [
                  TextSpan(
                      text:
                          '${widget.announcements.length >= 10 && _currentNewsIndex < 9 ? '0' : ''}'
                          '${_currentNewsIndex + 1}',
                      style: TextStyle(color: ApTheme.of(context).red)),
                  TextSpan(text: ' / ${widget.announcements.length}'),
                ],
              ),
            ),
            SizedBox(height: orientation == Orientation.portrait ? 24.0 : 0.0),
          ],
        );
      case HomeState.offline:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: app.offlineMode,
        );
      case HomeState.error:
      default:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: app.somethingError,
        );
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => YesNoDialog(
        title: app.closeAppTitle,
        contentWidget: Text(
          app.closeAppHint,
          textAlign: TextAlign.center,
          style: TextStyle(color: ApTheme.of(context).greyText),
        ),
        leftActionText: app.cancel,
        rightActionText: app.confirm,
        rightActionFunction: () {
          SystemNavigator.pop();
        },
      ),
    );
  }

  void hideSnackBar() {
    _scaffoldKey.currentState.hideCurrentSnackBar();
  }

  void showBasicHint({@required String text}) {
    showSnackBar(text: text, duration: Duration(seconds: 2));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    @required String text,
    String actionText,
    Function onSnackBarTapped,
    Duration duration,
  }) {
    return _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: duration ?? Duration(days: 1),
        action: actionText == null
            ? null
            : SnackBarAction(
                onPressed: onSnackBarTapped,
                label: actionText,
                textColor: ApTheme.of(context).snackBarActionTextColor,
              ),
      ),
    );
  }
}
