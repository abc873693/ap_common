import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/config/constants.dart';
import 'package:ap_common_example/widgets/share_data_widget.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  static const String routerName = '/setting';

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late ApLocalizations ap;

  String? appVersion;
  bool busNotify = false;
  bool courseNotify = false;
  bool displayPicture = true;
  bool isOffline = false;

  bool autoSendEvent = false;

  @override
  void initState() {
    _getPreference();
    if (DateTime.now().millisecondsSinceEpoch % 5 == 0) {
      ApUtils.showAppReviewDialog(context, Constants.PLAY_STORE_URL);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ap = ApLocalizations.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(ap.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SettingTitle(text: ap.notificationItem),
            const CheckCourseNotifyItem(),
            const ClearAllNotifyItem(),
            const Divider(
              color: Colors.grey,
              height: 0.5,
            ),
            SettingTitle(text: ap.otherSettings),
            SettingSwitch(
              text: ap.headPhotoSetting,
              subText: ap.headPhotoSettingSubTitle,
              value: displayPicture,
              onChanged: (bool b) {
                setState(() {
                  displayPicture = !displayPicture;
                });
                PreferenceUtil.instance.setBool(
                  Constants.PREF_DISPLAY_PICTURE,
                  displayPicture,
                );
              },
            ),
            ChangeLanguageItem(
              onChange: (Locale locale) {
                ShareDataWidget.of(context)!.data!.loadLocale(locale);
              },
            ),
            ChangeThemeModeItem(
              onChange: (ThemeMode themeMode) {
                ShareDataWidget.of(context)!.data!.loadTheme(themeMode);
              },
            ),
            ChangeIconStyleItem(
              onChange: (String code) {
                ShareDataWidget.of(context)!.data!.update();
              },
            ),
            const Divider(
              color: Colors.grey,
              height: 0.5,
            ),
            SettingTitle(text: ap.otherInfo),
            SettingItem(
              text: ap.feedback,
              subText: ap.feedbackViaFacebook,
              onTap: () {
                ApUtils.launchFbFansPage(context, Constants.FANS_PAGE_ID);
              },
            ),
            SettingItem(
              text: ap.appVersion,
              subText: 'v$appVersion',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getPreference() async {
    // PackageInfo? packageInfo;
    // if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS)) {
    //   packageInfo = await PackageInfo.fromPlatform();
    // }
    setState(() {
      isOffline = PreferenceUtil.instance
          .getBool(Constants.PREF_IS_OFFLINE_LOGIN, false);
      appVersion = '3.4.2';
      courseNotify =
          PreferenceUtil.instance.getBool(Constants.PREF_COURSE_NOTIFY, false);
      displayPicture =
          PreferenceUtil.instance.getBool(Constants.PREF_DISPLAY_PICTURE, true);
      busNotify =
          PreferenceUtil.instance.getBool(Constants.PREF_BUS_NOTIFY, false);
    });
  }
}
