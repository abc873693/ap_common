import 'package:ap_common/api/announcement_helper.dart';
import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/models/user_info.dart';
import 'package:ap_common/pages/announcement/home_page.dart';
import 'package:ap_common/pages/announcement_content_page.dart';
import 'package:ap_common/pages/about_us_page.dart';
import 'package:ap_common/pages/open_source_page.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/scaffold/home_page_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:ap_common/widgets/ap_drawer.dart';
import 'package:ap_common_example/pages/diolog_utils_page.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../res/assets.dart';
import '../utils/app_localizations.dart';
import 'notification_utils_page.dart';
import 'setting_page.dart';
import 'shcool_info_page.dart';
import 'user_info_page.dart';
import 'login_page.dart';
import 'study/course_page.dart';
import 'study/score_page.dart';

class HomePage extends StatefulWidget {
  static const String routerName = "/home";

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<HomePageScaffoldState> _homeKey =
      GlobalKey<HomePageScaffoldState>();

  bool get isTablet => MediaQuery.of(context).size.shortestSide > 680;

  var state = HomeState.loading;

  AppLocalizations app;
  ApLocalizations ap;

  Map<String, List<Announcement>> newsMap;

  Widget content;

  List<Announcement> announcements;

  var isLogin = false;
  bool displayPicture = true;
  bool isStudyExpanded = false;
  bool isBusExpanded = false;
  bool isLeaveExpanded = false;

  UserInfo userInfo;

  TextStyle get _defaultStyle => TextStyle(
        color: ApTheme.of(context).grey,
        fontSize: 16.0,
      );

  String get drawerIcon {
    switch (ApTheme.of(context).brightness) {
      case Brightness.light:
        return ImageAssets.drawerIconLight;
      case Brightness.dark:
      default:
        return ImageAssets.drawerIconDark;
    }
  }

  static aboutPage(BuildContext context, {String assetImage}) {
    return AboutUsPage(
      assetImage: assetImage ?? ImageAssets.kuasap2,
      githubName: 'NKUST-ITC',
      email: 'abc873693@gmail.com',
      appLicense: AppLocalizations.of(context).aboutOpenSourceContent,
      fbFanPageId: '735951703168873',
      fbFanPageUrl: 'https://www.facebook.com/NKUST.ITC/',
      githubUrl: 'https://github.com/NKUST-ITC',
      actions: <Widget>[
        IconButton(
          icon: Icon(ApIcon.codeIcon),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OpenSourcePage(),
              ),
            );
          },
        )
      ],
    );
  }

  @override
  void initState() {
    _getAnnouncements();
    if (Preferences.getBool(Constants.PREF_AUTO_LOGIN, false)) {
      _login();
    } else {
      checkLogin();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    app = AppLocalizations.of(context);
    ap = ApLocalizations.of(context);
    return HomePageScaffold(
      title: app.appName,
      key: _homeKey,
      state: state,
      announcements: announcements,
      isLogin: isLogin,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.fiber_new_rounded),
          tooltip: ap.announcementReviewSystem,
          onPressed: () {
            ApUtils.pushCupertinoStyle(
              context,
              AnnouncementHomePage(),
            );
          },
        ),
      ],
      content: content,
      drawer: ApDrawer(
        userInfo: userInfo,
        displayPicture:
            Preferences.getBool(Constants.PREF_DISPLAY_PICTURE, true),
        imageAsset: drawerIcon,
        onTapHeader: () {
          if (isLogin) {
            if (userInfo != null)
              ApUtils.pushCupertinoStyle(
                context,
                UserInfoPage(userInfo: userInfo),
              );
          } else {
            if (!isTablet) Navigator.of(context).pop();
            openLoginPage();
          }
        },
        widgets: <Widget>[
          if (isTablet)
            DrawerItem(
              icon: ApIcon.home,
              title: ap.home,
              onTap: () => setState(() => content = null),
            ),
          ExpansionTile(
            initiallyExpanded: isStudyExpanded,
            onExpansionChanged: (bool) {
              setState(() {
                isStudyExpanded = bool;
              });
            },
            leading: Icon(
              ApIcon.school,
              color: isStudyExpanded
                  ? ApTheme.of(context).blueAccent
                  : ApTheme.of(context).grey,
            ),
            title: Text(ap.courseInfo, style: _defaultStyle),
            children: <Widget>[
              DrawerSubItem(
                icon: ApIcon.classIcon,
                title: ap.course,
                onTap: () => _openPage(
                  CoursePage(),
                  needLogin: true,
                ),
              ),
              DrawerSubItem(
                icon: ApIcon.assignment,
                title: ap.score,
                onTap: () => _openPage(
                  ScorePage(),
                  needLogin: true,
                ),
              ),
//              DrawerSubItem(
//                icon: ApIcon.room,
//                title: ap.classroomCourseTableSearch,
//                page: RoomListPage(),
//              ),
            ],
          ),
          DrawerItem(
            icon: ApIcon.info,
            title: ap.schoolInfo,
            onTap: () => _openPage(
              SchoolInfoPage(),
            ),
          ),
          if (NotificationUtils.isSupport)
            DrawerItem(
              icon: ApIcon.dateRange,
              title: app.localNotificationTest,
              onTap: () => _openPage(
                NotificationUtilsTestPage(),
              ),
            ),
          DrawerItem(
            icon: ApIcon.check,
            title: app.dialogUtilTest,
            onTap: () => _openPage(
              DialogUtilsTestPage(),
            ),
          ),
          DrawerItem(
            icon: ApIcon.face,
            title: ap.about,
            onTap: () => _openPage(
              aboutPage(context, assetImage: ImageAssets.sectionJiangong),
            ),
          ),
          DrawerItem(
            icon: ApIcon.settings,
            title: ap.settings,
            onTap: () => _openPage(
              SettingPage(),
            ),
          ),
          if (isLogin)
            DrawerItem(
              icon: ApIcon.powerSettingsNew,
              title: ap.logout,
              onTap: () async {
                await Preferences.setBool(Constants.PREF_AUTO_LOGIN, false);
                isLogin = false;
                userInfo = null;
                content = null;
                if (!isTablet) Navigator.of(context).pop();
                checkLogin();
              },
            ),
        ],
      ),
      onImageTapped: (Announcement announcement) {
        ApUtils.pushCupertinoStyle(
          context,
          AnnouncementContentPage(announcement: announcement),
        );
      },
      onTabTapped: onTabTapped,
      bottomNavigationBarItems: [
        BottomNavigationBarItem(
          icon: Icon(ApIcon.face),
          label: ap.about,
        ),
        BottomNavigationBarItem(
          icon: Icon(ApIcon.classIcon),
          label: ap.course,
        ),
        BottomNavigationBarItem(
          icon: Icon(ApIcon.assignment),
          label: ap.score,
        ),
      ],
    );
  }

  void onTabTapped(int index) async {
    if (isLogin) {
      switch (index) {
        case 0:
          ApUtils.pushCupertinoStyle(
            context,
            aboutPage(
              context,
              assetImage: ImageAssets.sectionJiangong,
            ),
          );
          break;
        case 1:
          ApUtils.pushCupertinoStyle(context, CoursePage());
          break;
        case 2:
          ApUtils.pushCupertinoStyle(context, ScorePage());
          break;
      }
    } else
      ApUtils.showToast(context, ap.notLogin);
  }

  _getAnnouncements() async {
    // GitHubHelper.instance.getAnnouncement(
    //   gitHubUsername: 'abc873693',
    //   hashCode: 'a8e048d24f892ce95a633aa5966c030a',
    //   tag: 'nkust',
    //   callback: GeneralCallback(
    //     onFailure: (_) => setState(() => state = HomeState.error),
    //     onError: (_) => setState(() => state = HomeState.error),
    //     onSuccess: (Map<String, List<Announcement>> data) {
    //       newsMap = data;
    //       setState(() {
    //         if (announcements == null || announcements.length == 0)
    //           state = HomeState.empty;
    //         else {
    //           newsMap.forEach((_, data) {
    //             data.sort((a, b) {
    //               return b.weight.compareTo(a.weight);
    //             });
    //           });
    //           state = HomeState.finish;
    //         }
    //       });
    //     },
    //   ),
    // );
    AnnouncementHelper.instance.getAnnouncements(
      tags: [],
      callback: GeneralCallback(
        onFailure: (_) => setState(() => state = HomeState.error),
        onError: (_) => setState(() => state = HomeState.error),
        onSuccess: (List<Announcement> data) {
          announcements = data;
          setState(() {
            if (announcements == null || announcements.length == 0)
              state = HomeState.empty;
            else {
              newsMap?.forEach((_, data) {
                data.sort((a, b) {
                  return b.weight.compareTo(a.weight);
                });
              });
              state = HomeState.finish;
            }
          });
        },
      ),
    );
  }

  _getUserInfo() async {
    String rawString = await rootBundle.loadString(FileAssets.userInfo);
    var userInfo = UserInfo.fromRawJson(rawString);
    setState(() {
      this.userInfo = userInfo;
    });
    if (Preferences.getBool(Constants.PREF_DISPLAY_PICTURE, true))
      _getUserPicture();
  }

  _getUserPicture() async {
    try {
      if ((userInfo?.pictureUrl) == null) return;
      var response = await http.get(userInfo.pictureUrl);
      if (!response.body.contains('html')) {
        if (mounted) {
          setState(() {
            userInfo.pictureBytes = response.bodyBytes;
          });
        }
//        CacheUtils.savePictureData(response.bodyBytes);
      }
    } catch (e) {
      throw e;
    }
  }

  Future _login() async {
    await Future.delayed(Duration(microseconds: 30));
    // var username = Preferences.getString(Constants.PREF_USERNAME, '');
    // var password = Preferences.getStringSecurity(Constants.PREF_PASSWORD, '');
    //to login
    isLogin = true;
    Preferences.setBool(Constants.PREF_IS_OFFLINE_LOGIN, false);
    _getUserInfo();
    if (state != HomeState.finish) {
      _getAnnouncements();
    }
    _homeKey.currentState.showBasicHint(text: ap.loginSuccess);
  }

  Future openLoginPage() async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LoginPage(),
      ),
    );
    checkLogin();
    if (result ?? false) {
      _getUserInfo();
      if (state != HomeState.finish) {
        _getAnnouncements();
      }
      setState(() {
        isLogin = true;
      });
    }
  }

  void checkLogin() async {
    await Future.delayed(Duration(microseconds: 30));
    if (isLogin) {
      _homeKey.currentState.hideSnackBar();
    } else {
      _homeKey.currentState
          .showSnackBar(
            text: ApLocalizations.of(context).notLogin,
            actionText: ApLocalizations.of(context).login,
            onSnackBarTapped: openLoginPage,
          )
          .closed
          .then(
        (SnackBarClosedReason reason) {
          checkLogin();
        },
      );
    }
  }

  _openPage(Widget page, {needLogin = false}) {
    if (!isTablet) Navigator.of(context).pop();
    if (needLogin && !isLogin)
      ApUtils.showToast(
        context,
        ApLocalizations.of(context).notLoginHint,
      );
    else {
      if (isTablet) {
        setState(() => content = page);
      } else
        ApUtils.pushCupertinoStyle(context, page);
    }
  }
}
