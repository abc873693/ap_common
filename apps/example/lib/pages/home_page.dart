import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/config/constants.dart';
import 'package:ap_common_example/pages/diolog_utils_page.dart';
import 'package:ap_common_example/pages/login_page.dart';
import 'package:ap_common_example/pages/notification_utils_page.dart';
import 'package:ap_common_example/pages/setting_page.dart';
import 'package:ap_common_example/pages/shcool_info_page.dart';
import 'package:ap_common_example/pages/study/course_page.dart';
import 'package:ap_common_example/pages/study/score_page.dart';
import 'package:ap_common_example/pages/user_info_page.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:ap_common_example/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const String routerName = '/home';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<HomePageScaffoldState> _homeKey =
      GlobalKey<HomePageScaffoldState>();

  bool get isTablet => MediaQuery.of(context).size.shortestSide > 680;

  HomeState state = HomeState.loading;

  late AppLocalizations app;
  late ApLocalizations ap;

  Map<String, List<Announcement>>? newsMap;

  Widget? content;

  List<Announcement> announcements = <Announcement>[];

  bool isLogin = false;
  bool displayPicture = true;
  bool isStudyExpanded = false;
  bool isBusExpanded = false;
  bool isLeaveExpanded = false;

  UserInfo? userInfo;

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

  static Widget aboutPage(BuildContext context, {String? assetImage}) {
    return AboutUsPage(
      assetImage: assetImage ?? ImageAssets.kuasap2,
      githubName: 'NKUST-ITC',
      email: 'abc873693@gmail.com',
      appLicense: AppLocalizations.of(context).aboutOpenSourceContent,
      fbFanPageId: '735951703168873',
      fbFanPageUrl: 'https://www.facebook.com/NKUST.ITC/',
      githubUrl: 'https://github.com/NKUST-ITC',
    );
  }

  @override
  void initState() {
    _getAnnouncements();
    if (PreferenceUtil.instance.getBool(Constants.PREF_AUTO_LOGIN, false)) {
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
          icon: const Icon(Icons.fiber_new_rounded),
          tooltip: ap.announcementReviewSystem,
          onPressed: () {
            ApUtils.pushCupertinoStyle(
              context,
              const AnnouncementHomePage(),
            );
          },
        ),
      ],
      content: content,
      drawer: ApDrawer(
        userInfo: userInfo,
        displayPicture: PreferenceUtil.instance
            .getBool(Constants.PREF_DISPLAY_PICTURE, true),
        imageAsset: drawerIcon,
        onTapHeader: () {
          if (isLogin) {
            if (userInfo != null) {
              ApUtils.pushCupertinoStyle(
                context,
                UserInfoPage(userInfo: userInfo),
              );
            }
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
            onExpansionChanged: (bool bool) {
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
          if (NotificationUtil.instance.isSupport)
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
                await PreferenceUtil.instance
                    .setBool(Constants.PREF_AUTO_LOGIN, false);
                isLogin = false;
                userInfo = null;
                content = null;
                if (!context.mounted) return;
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
      bottomNavigationBarItems: <Widget>[
        NavigationDestination(
          icon: Icon(ApIcon.face),
          label: ap.about,
        ),
        NavigationDestination(
          icon: Icon(ApIcon.classIcon),
          label: ap.course,
        ),
        NavigationDestination(
          icon: Icon(ApIcon.assignment),
          label: ap.score,
        ),
      ],
    );
  }

  Future<void> onTabTapped(int index) async {
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
    } else {
      UiUtil.instance.showToast(context, ap.notLogin);
    }
  }

  Future<void> _getAnnouncements() async {
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
      tags: <String>[],
      callback: GeneralCallback<List<Announcement>>(
        onFailure: (_) => setState(() => state = HomeState.error),
        onError: (_) => setState(() => state = HomeState.error),
        onSuccess: (List<Announcement> data) {
          announcements = data;
          setState(() {
            if (announcements.isEmpty) {
              state = HomeState.empty;
            } else {
              state = HomeState.finish;
            }
          });
        },
      ),
    );
  }

  Future<void> _getUserInfo() async {
    final String rawString = await rootBundle.loadString(FileAssets.userInfo);
    final UserInfo userInfo = UserInfo.fromRawJson(rawString);
    setState(() {
      this.userInfo = userInfo;
    });
    if (PreferenceUtil.instance.getBool(Constants.PREF_DISPLAY_PICTURE, true)) {
      _getUserPicture();
    }
  }

  Future<void> _getUserPicture() async {
    try {
      if (userInfo?.pictureUrl == null) return;
      final http.Response response =
          await http.get(Uri.parse(userInfo!.pictureUrl!));
      if (!response.body.contains('html')) {
        if (mounted) {
          setState(() {
            userInfo!.pictureBytes = response.bodyBytes;
          });
        }
//        CacheUtils.savePictureData(response.bodyBytes);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _login() async {
    await Future<void>.delayed(const Duration(microseconds: 30));
    // var username = PreferenceUtil.instance.getString(Constants.PREF_USERNAME, '');
    // ignore: lines_longer_than_80_chars
    // var password = PreferenceUtil.instance.getStringSecurity(Constants.PREF_PASSWORD, '');
    //to login
    isLogin = true;
    PreferenceUtil.instance.setBool(Constants.PREF_IS_OFFLINE_LOGIN, false);
    _getUserInfo();
    if (state != HomeState.finish) {
      _getAnnouncements();
    }
    _homeKey.currentState!.showBasicHint(text: ap.loginSuccess);
  }

  Future<void> openLoginPage() async {
    final bool? result = await Navigator.of(context).push(
      MaterialPageRoute<bool>(
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

  Future<void> checkLogin() async {
    await Future<void>.delayed(const Duration(microseconds: 30));
    if (isLogin) {
      _homeKey.currentState!.hideSnackBar();
    } else {
      //ignore: use_build_context_synchronously
      if (!mounted) return;
      _homeKey.currentState!
          .showSnackBar(
            text: ApLocalizations.of(context).notLogin,
            actionText: ApLocalizations.of(context).login,
            onSnackBarTapped: openLoginPage,
          )!
          .closed
          .then(
        (SnackBarClosedReason reason) {
          checkLogin();
        },
      );
    }
  }

  void _openPage(Widget page, {bool needLogin = false}) {
    if (!isTablet) Navigator.of(context).pop();
    if (needLogin && !isLogin) {
      UiUtil.instance.showToast(
        context,
        ApLocalizations.of(context).notLoginHint,
      );
    } else {
      if (isTablet) {
        setState(() => content = page);
      } else {
        ApUtils.pushCupertinoStyle(context, page);
      }
    }
  }
}
