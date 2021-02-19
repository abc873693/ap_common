import 'dart:io';

import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:ap_common/widgets/setting_page_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../config/constants.dart';
import '../widgets/share_data_widget.dart';

class SettingPage extends StatefulWidget {
  static const String routerName = "/setting";

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ApLocalizations ap;

  String appVersion;
  bool busNotify = false, courseNotify = false, displayPicture = true;
  bool isOffline = false;

  var autoSendEvent = false;

  @override
  void initState() {
    _getPreference();
    if (DateTime.now().millisecondsSinceEpoch % 5 == 0)
      ApUtils.showAppReviewDialog(context, Constants.PLAY_STORE_URL);
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
        backgroundColor: ApTheme.of(context).blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SettingTitle(text: ap.notificationItem),
            CheckCourseNotifyItem(),
            ClearAllNotifyItem(),
            Divider(
              color: Colors.grey,
              height: 0.5,
            ),
            SettingTitle(text: ap.otherSettings),
            SettingSwitch(
              text: ap.headPhotoSetting,
              subText: ap.headPhotoSettingSubTitle,
              value: displayPicture,
              onChanged: (b) {
                setState(() {
                  displayPicture = !displayPicture;
                });
                Preferences.setBool(
                    Constants.PREF_DISPLAY_PICTURE, displayPicture);
              },
            ),
            ChangeLanguageItem(
              onChange: (locale) {
                ShareDataWidget.of(context).data.loadLocale(locale);
              },
            ),
            ChangeThemeModeItem(
              onChange: (themeMode) {
                ShareDataWidget.of(context).data.loadTheme(themeMode);
              },
            ),
            ChangeIconStyleItem(
              onChange: (String code) {
                ShareDataWidget.of(context).data.update();
              },
            ),
            Divider(
              color: Colors.grey,
              height: 0.5,
            ),
            SettingTitle(text: ap.otherInfo),
            SettingItem(
                text: ap.feedback,
                subText: ap.feedbackViaFacebook,
                onTap: () {
                  ApUtils.launchFbFansPage(context, Constants.FANS_PAGE_ID);
                }),
            SettingItem(
                text: ap.appVersion, subText: "v$appVersion", onTap: () {}),
          ],
        ),
      ),
    );
  }

  _getPreference() async {
    PackageInfo packageInfo;
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS))
      packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      isOffline = Preferences.getBool(Constants.PREF_IS_OFFLINE_LOGIN, false);
      appVersion = packageInfo?.version ?? '3.4.2';
      courseNotify = Preferences.getBool(Constants.PREF_COURSE_NOTIFY, false);
      displayPicture =
          Preferences.getBool(Constants.PREF_DISPLAY_PICTURE, true);
      busNotify = Preferences.getBool(Constants.PREF_BUS_NOTIFY, false);
    });
  }
}
