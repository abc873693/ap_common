import 'package:ap_common/config/analytics_constants.dart';
import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/course_notify_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/material.dart';

import 'option_dialog.dart';

export 'package:package_info_plus/package_info_plus.dart';

class SettingTitle extends StatelessWidget {
  final String? text;

  const SettingTitle({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        text!,
        style: TextStyle(color: ApTheme.of(context).blueText, fontSize: 14.0),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class SettingSwitch extends StatelessWidget {
  final String text;
  final String subText;
  final bool value;
  final void Function(bool) onChanged;

  const SettingSwitch({
    Key? key,
    required this.text,
    required this.subText,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        text,
        style: const TextStyle(fontSize: 16.0),
      ),
      subtitle: Text(
        subText,
        style: TextStyle(
          fontSize: 14.0,
          color: ApTheme.of(context).greyText,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: ApTheme.of(context).blueAccent,
    );
  }
}

class SettingItem extends StatelessWidget {
  final String text;
  final String subText;
  final Function()? onTap;

  const SettingItem({
    Key? key,
    required this.text,
    required this.subText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(fontSize: 16.0),
      ),
      subtitle: Text(
        subText,
        style: TextStyle(fontSize: 14.0, color: ApTheme.of(context).greyText),
      ),
      onTap: onTap,
    );
  }
}

class CheckCourseNotifyItem extends StatelessWidget {
  final String? tag;

  const CheckCourseNotifyItem({Key? key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = ApLocalizations.of(context);
    return SettingItem(
      text: ap.courseNotify,
      subText: ap.courseNotifySubTitle,
      onTap: () {
        final CourseNotifyData notifyData = tag == null
            ? CourseNotifyData.loadCurrent()
            : CourseNotifyData.load(tag);
        if (NotificationUtils.isSupport) {
          if (notifyData.data.isNotEmpty) {
            showDialog(
              context: context,
              builder: (_) => SimpleOptionDialog(
                title: ap.courseNotify,
                items: [
                  for (var notify in notifyData.data)
                    '${ap.weekdaysCourse[notify.weekdayIndex]} '
                        '${notify.startTime} ${notify.title}',
                ],
                index: -1,
                onSelected: (index) {
                  NotificationUtils.cancelCourseNotify(
                    id: notifyData.data[index].id,
                  );
                  notifyData.data.removeAt(index);
                  notifyData.save();
                  ApUtils.showToast(context, ap.cancelNotifySuccess);
                },
              ),
            );
          } else {
            ApUtils.showToast(context, ap.courseNotifyEmpty);
          }
        } else {
          ApUtils.showToast(context, ap.platformError);
        }
      },
    );
  }
}

class ClearAllNotifyItem extends StatelessWidget {
  final String? tag;

  const ClearAllNotifyItem({Key? key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = ApLocalizations.of(context);
    return SettingItem(
      text: ap.cancelAllNotify,
      subText: ap.cancelAllNotifySubTitle,
      onTap: () {
        if (NotificationUtils.isSupport) {
          NotificationUtils.cancelAll();
          final CourseNotifyData notifyData = tag == null
              ? CourseNotifyData.loadCurrent()
              : CourseNotifyData.load(tag);
          notifyData.data.clear();
          notifyData.save();
          ApUtils.showToast(context, ap.cancelNotifySuccess);
        } else {
          ApUtils.showToast(context, ap.platformError);
        }
      },
    );
  }
}

class ChangeLanguageItem extends StatelessWidget {
  final Function(Locale locale) onChange;
  final List<String>? textList;

  const ChangeLanguageItem({
    Key? key,
    required this.onChange,
    this.textList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = ApLocalizations.of(context);
    final languageTextList = textList ??
        [
          ApLocalizations.of(context).systemLanguage,
          ApLocalizations.of(context).traditionalChinese,
          ApLocalizations.of(context).english,
        ];
    final code = Preferences.getString(
        ApConstants.prefLanguageCode, ApSupportLanguageConstants.system);
    final languageIndex = ApSupportLanguageExtension.fromCode(code);
    return SettingItem(
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
              final String code = ApSupportLanguage.values[index].code;
              switch (index) {
                case 0:
                  final List<Locale>? locales =
                      WidgetsBinding.instance?.window.locales;
                  if (locales == null || locales.isEmpty) {
                    locale = const Locale('en');
                  } else {
                    locale = locales.first;
                  }
                  locale = ApLocalizations.delegate.isSupported(locale)
                      ? locale
                      : const Locale('en');
                  break;
                default:
                  locale = Locale(
                    code,
                    code == ApSupportLanguageConstants.zh ? 'TW' : null,
                  );
                  break;
              }
              onChange.call(locale);
              Preferences.setString(ApConstants.prefLanguageCode, code);
              AnalyticsUtils.instance?.logEvent(
                'change_language',
                parameters: {'code': code},
              );
              AnalyticsUtils.instance?.setUserProperty(
                AnalyticsConstants.language,
                locale.toLanguageTag(),
              );
            },
          ),
        );
        AnalyticsUtils.instance?.logEvent('language_setting_click');
      },
    );
  }
}

class ChangeThemeModeItem extends StatelessWidget {
  final Function(ThemeMode themeMode) onChange;
  final List<String>? textList;

  const ChangeThemeModeItem({
    Key? key,
    required this.onChange,
    this.textList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = ApLocalizations.of(context);
    final themeTextList = [
      ApLocalizations.of(context).systemTheme,
      ApLocalizations.of(context).light,
      ApLocalizations.of(context).dark,
    ];
    final themeModeIndex = ApTheme.of(context).themeMode.index;
    return SettingItem(
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
              final mode = ThemeMode.values[index];
              onChange.call(mode);
              Preferences.setInt(ApConstants.prefThemeModeIndex, index);
              AnalyticsUtils.instance?.logEvent(
                'change_theme',
                parameters: {
                  'code': mode.toString(),
                },
              );
              AnalyticsUtils.instance?.logThemeEvent(mode);
            },
          ),
        );
        AnalyticsUtils.instance?.logEvent('theme_mode_setting_click');
      },
    );
  }
}

class ChangeIconStyleItem extends StatelessWidget {
  final Function(String code) onChange;

  const ChangeIconStyleItem({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconStyleIndex = ApIcon.index;
    final ap = ApLocalizations.of(context);
    return SettingItem(
      text: ap.iconStyle,
      subText: ap.iconText,
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SimpleOptionDialog(
            title: ap.theme,
            items: [
              ap.outlined,
              ap.filled,
            ],
            index: iconStyleIndex,
            onSelected: (int index) {
              final code = ApIcon.values[index];
              ApIcon.code = code;
              Preferences.setString(ApConstants.prefIconStyleCode, code);
              onChange.call(code);
              AnalyticsUtils.instance?.logEvent(
                'change_icon_style',
                parameters: {'code': code},
              );
            },
          ),
        );
        AnalyticsUtils.instance?.logEvent('icon_style_setting_click');
      },
    );
  }
}
