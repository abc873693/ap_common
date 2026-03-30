import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/config/constants.dart';
import 'package:ap_common_example/pages/diolog_utils_page.dart';
import 'package:ap_common_example/pages/login_page.dart';
import 'package:ap_common_example/pages/notification_utils_page.dart';
import 'package:ap_common_example/pages/school_info_page.dart';
import 'package:ap_common_example/pages/setting_page.dart';
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

  Map<String, List<Announcement>>? newsMap;

  Widget? content;

  List<Announcement> announcements = <Announcement>[];

  bool isLogin = false;
  bool displayPicture = true;
  bool isStudyExpanded = false;

  UserInfo? userInfo;

  String get drawerIcon {
    switch (ApTheme.of(context).brightness) {
      case Brightness.light:
        return ImageAssets.drawerIconLight;
      case Brightness.dark:
        return ImageAssets.drawerIconDark;
    }
  }

  static Widget aboutPage(BuildContext context, {String? assetImage}) {
    return AboutUsPage(
      assetImage: assetImage ?? ImageAssets.kuasap2,
      githubName: 'NKUST-ITC',
      email: 'abc873693@gmail.com',
      appLicense: context.app.aboutOpenSourceContent,
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
    return HomePageScaffold(
      title: context.app.appName,
      key: _homeKey,
      state: state,
      announcements: announcements,
      isLogin: isLogin,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.fiber_new_rounded),
          tooltip: context.ap.announcementReviewSystem,
          onPressed: () {
            ApUtils.pushCupertinoStyle(
              context,
              const AnnouncementHomePage(),
            );
          },
        ),
      ],
      content: content,
      drawer: _buildDrawer(),
      onImageTapped: (Announcement announcement) {
        ApUtils.pushCupertinoStyle(
          context,
          AnnouncementContentPage(announcement: announcement),
        );
      },
      onTabTapped: onTabTapped,
      bottomNavigationBarItems: <NavigationDestination>[
        NavigationDestination(
          icon: Icon(ApIcon.home),
          label: context.ap.home,
        ),
        NavigationDestination(
          icon: Icon(ApIcon.classIcon),
          label: context.ap.course,
        ),
        NavigationDestination(
          icon: Icon(ApIcon.assignment),
          label: context.ap.score,
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ApDrawer(
      userInfo: userInfo,
      displayPicture: PreferenceUtil.instance.getBool(
        Constants.PREF_DISPLAY_PICTURE,
        true,
      ),
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
          DrawerMenuItem(
            icon: ApIcon.home,
            title: context.ap.home,
            onTap: () => setState(() => content = null),
          ),
        _buildStudySection(),
        DrawerMenuItem(
          icon: ApIcon.info,
          title: context.ap.schoolInfo,
          onTap: () => _openPage(
            SchoolInfoPage(),
          ),
        ),
        if (NotificationUtil.instance.isSupport)
          DrawerMenuItem(
            icon: ApIcon.dateRange,
            title: context.app.localNotificationTest,
            onTap: () => _openPage(
              NotificationUtilsTestPage(),
            ),
          ),
        DrawerMenuItem(
          icon: ApIcon.check,
          title: context.app.dialogUtilTest,
          onTap: () => _openPage(
            DialogUtilsTestPage(),
          ),
        ),
        DrawerMenuItem(
          icon: ApIcon.face,
          title: context.ap.about,
          onTap: () => _openPage(
            aboutPage(context, assetImage: ImageAssets.sectionJiangong),
          ),
        ),
        DrawerMenuItem(
          icon: ApIcon.settings,
          title: context.ap.settings,
          onTap: () => _openPage(
            SettingPage(),
          ),
        ),
        if (isLogin) ...<Widget>[
          const DrawerDivider(),
          DrawerMenuItem(
            icon: ApIcon.powerSettingsNew,
            title: context.ap.logout,
            iconColor: colorScheme.error,
            onTap: () async {
              await PreferenceUtil.instance
                  .setBool(Constants.PREF_AUTO_LOGIN, false);
              isLogin = false;
              userInfo = null;
              content = null;
              if (!mounted) return;
              if (!isTablet) Navigator.of(context).pop();
              checkLogin();
            },
          ),
        ],
      ],
    );
  }

  Widget _buildStudySection() {
    return DrawerMenuSection(
      icon: ApIcon.school,
      title: context.ap.courseInfo,
      initiallyExpanded: isStudyExpanded,
      onExpansionChanged: (bool value) {
        setState(() {
          isStudyExpanded = value;
        });
      },
      children: <DrawerSubMenuItem>[
        DrawerSubMenuItem(
          icon: ApIcon.classIcon,
          title: context.ap.course,
          onTap: () => _openPage(
            CoursePage(),
            needLogin: true,
          ),
        ),
        DrawerSubMenuItem(
          icon: ApIcon.assignment,
          title: context.ap.score,
          onTap: () => _openPage(
            ScorePage(),
            needLogin: true,
          ),
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
        case 1:
          ApUtils.pushCupertinoStyle(context, CoursePage());
        case 2:
          ApUtils.pushCupertinoStyle(context, ScorePage());
      }
    } else {
      UiUtil.instance.showToast(context, context.ap.notLogin);
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
            userInfo = userInfo!.copyWith(pictureBytes: response.bodyBytes);
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
    // var username = PreferenceUtil.instance.getString(
    //   Constants.PREF_USERNAME,
    //   '',
    // );
    // ignore: lines_longer_than_80_chars
    // var password = PreferenceUtil.instance.getStringSecurity(
    //   Constants.PREF_PASSWORD,
    //   '',
    // );
    //to login
    isLogin = true;
    PreferenceUtil.instance.setBool(Constants.PREF_IS_OFFLINE_LOGIN, false);
    _getUserInfo();
    if (state != HomeState.finish) {
      _getAnnouncements();
    }
    if (!mounted) return;
    _homeKey.currentState!.showBasicHint(text: context.ap.loginSuccess);
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
            text: context.ap.notLogin,
            actionText: context.ap.login,
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
        context.ap.notLoginHint,
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
