import 'dart:io';

import 'package:ap_common/models/ap_support_language.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:ap_common/widgets/dialog_option.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:ap_common/widgets/setting_page_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../config/constants.dart';
import '../models/item.dart';
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
    final languageTextList = [
      ApLocalizations.of(context).systemLanguage,
      ApLocalizations.of(context).traditionalChinese,
      ApLocalizations.of(context).english,
    ];
    final themeTextList = [
      ApLocalizations.of(context).systemTheme,
      ApLocalizations.of(context).light,
      ApLocalizations.of(context).dark,
    ];
    final code = Preferences.getString(
        Constants.PREF_LANGUAGE_CODE, ApSupportLanguageConstants.SYSTEM);
    final languageIndex = ApSupportLanguageExtension.fromCode(code);
    final themeModeIndex = ApTheme.of(context).themeMode.index;
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
            SettingItem(
              text: ap.language,
              subText: languageTextList[languageIndex],
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => SimpleOptionDialog(
                    title: ap.language,
                    items: languageTextList,
                    index: languageIndex,
                    onSelected: (int index) async {
                      Locale locale;
                      String code = ApSupportLanguage.values[index].code;
                      switch (index) {
                        case 0:
                          locale = Localizations.localeOf(context);
                          break;
                        default:
                          locale = Locale(
                            code,
                            code == ApSupportLanguageConstants.ZH ? 'TW' : null,
                          );
                          break;
                      }
                      Preferences.setString(Constants.PREF_LANGUAGE_CODE, code);
                      ShareDataWidget.of(context).data.loadLocale(locale);
//                      FirebaseAnalyticsUtils.instance.logAction(
//                        'change_language',
//                        code,
//                      );
//                      FirebaseAnalyticsUtils.instance.setUserProperty(
//                        FirebaseConstants.LANGUAGE,
//                        AppLocalizations.locale.languageCode,
//                      );
                    },
                  ),
                );
              },
            ),
            SettingItem(
              text: ap.iconStyle,
              subText: ap.iconText,
              onTap: () {
                showDialog<int>(
                  context: context,
                  builder: (_) => SimpleDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      title: Text(ap.iconStyle),
                      children: [
                        for (var item in [
                          Item(ap.outlined, ApIcon.OUTLINED),
                          Item(ap.filled, ApIcon.FILLED),
                        ])
                          DialogOption(
                              text: item.text,
                              check: ApIcon.code == item.value,
                              onPressed: () {
                                setState(() {
                                  ApIcon.code = item.value;
                                });
                                Preferences.setString(
                                    Constants.PREF_ICON_STYLE_CODE, item.value);
                                Navigator.pop(context);
                              }),
                      ]),
                ).then<void>((int position) {});
              },
            ),
            SettingItem(
              text: ap.theme,
              subText: themeTextList[themeModeIndex],
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => SimpleOptionDialog(
                    title: ap.theme,
                    items: themeTextList,
                    index: themeModeIndex,
                    onSelected: (int index) {
                      Preferences.getInt(
                        Constants.PREF_THEME_MODE_INDEX,
                        index,
                      );
                      ShareDataWidget.of(context)
                          .data
                          .update(ThemeMode.values[index]);
                      Preferences.setInt(
                          Constants.PREF_THEME_MODE_INDEX, index);
//                      FirebaseAnalyticsUtils.instance.logAction(
//                        'change_theme',
//                        ThemeMode.values[index].toString(),
//                      );
                    },
                  ),
                );
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
