import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: ApTheme.of(context).blueText,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class SettingSwitch extends StatelessWidget {
  const SettingSwitch({
    super.key,
    required this.text,
    required this.subText,
    required this.value,
    required this.onChanged,
  });

  final String text;
  final String subText;
  final bool value;
  final void Function(bool) onChanged;

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
  const SettingItem({
    super.key,
    required this.text,
    required this.subText,
    this.onTap,
  });

  final String text;
  final String subText;
  final Function()? onTap;

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
  const CheckCourseNotifyItem({super.key, this.tag});

  final String? tag;

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = ApLocalizations.of(context);
    return SettingItem(
      text: ap.courseNotify,
      subText: ap.courseNotifySubTitle,
      onTap: () {
        final CourseNotifyData notifyData = tag == null
            ? CourseNotifyData.loadCurrent()
            : CourseNotifyData.load(tag);
        if (NotificationUtil.instance.isSupport) {
          if (notifyData.data.isNotEmpty) {
            showDialog(
              context: context,
              builder: (_) => SimpleOptionDialog(
                title: ap.courseNotify,
                items: <String>[
                  for (final CourseNotify notify in notifyData.data)
                    '${ap.weekdaysCourse[notify.weekdayIndex]} ' +
                        '${notify.startTime} ${notify.title}',
                ],
                index: -1,
                onSelected: (int index) {
                  NotificationUtil.instance.cancelNotify(
                    id: notifyData.data[index].id,
                  );
                  notifyData.data.removeAt(index);
                  notifyData.save();
                  UiUtil.instance.showToast(context, ap.cancelNotifySuccess);
                },
              ),
            );
          } else {
            UiUtil.instance.showToast(context, ap.courseNotifyEmpty);
          }
        } else {
          UiUtil.instance.showToast(context, ap.platformError);
        }
      },
    );
  }
}

class ClearAllNotifyItem extends StatelessWidget {
  const ClearAllNotifyItem({super.key, this.tag});

  final String? tag;

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = ApLocalizations.of(context);
    return SettingItem(
      text: ap.cancelAllNotify,
      subText: ap.cancelAllNotifySubTitle,
      onTap: () {
        if (NotificationUtil.instance.isSupport) {
          NotificationUtil.instance.cancelAll();
          final CourseNotifyData notifyData = tag == null
              ? CourseNotifyData.loadCurrent()
              : CourseNotifyData.load(tag);
          notifyData.data.clear();
          notifyData.save();
          UiUtil.instance.showToast(context, ap.cancelNotifySuccess);
        } else {
          UiUtil.instance.showToast(context, ap.platformError);
        }
      },
    );
  }
}

class ChangeLanguageItem extends StatelessWidget {
  const ChangeLanguageItem({
    super.key,
    required this.onChange,
    this.textList,
  });

  final Function(Locale locale) onChange;
  final List<String>? textList;

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = ApLocalizations.of(context);
    final List<String> languageTextList = textList ??
        <String>[
          ApLocalizations.of(context).systemLanguage,
          ApLocalizations.of(context).traditionalChinese,
          ApLocalizations.of(context).english,
        ];
    final String code = PreferenceUtil.instance.getString(
      ApConstants.prefLanguageCode,
      ApSupportLanguageConstants.system,
    );
    final int languageIndex = ApSupportLanguageExtension.fromCode(code);
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
                  final List<Locale> locales =
                      WidgetsBinding.instance.platformDispatcher.locales;
                  if (locales.isEmpty) {
                    locale = const Locale('en');
                  } else {
                    locale = locales.first;
                  }
                  locale = ApLocalizations.delegate.isSupported(locale)
                      ? locale
                      : const Locale('en');
                default:
                  locale = Locale(
                    code,
                    code == ApSupportLanguageConstants.zh ? 'TW' : null,
                  );
                  break;
              }
              onChange.call(locale);
              PreferenceUtil.instance
                  .setString(ApConstants.prefLanguageCode, code);
              AnalyticsUtil.instance.logEvent(
                'change_language',
                parameters: <String, String>{'code': code},
              );
              AnalyticsUtil.instance.setUserProperty(
                AnalyticsConstants.language,
                locale.toLanguageTag(),
              );
            },
          ),
        );
        AnalyticsUtil.instance.logEvent('language_setting_click');
      },
    );
  }
}

class ChangeThemeModeItem extends StatelessWidget {
  const ChangeThemeModeItem({
    super.key,
    required this.onChange,
    this.textList,
  });

  final Function(ThemeMode themeMode) onChange;
  final List<String>? textList;

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = ApLocalizations.of(context);
    final List<String> themeTextList = <String>[
      ApLocalizations.of(context).systemTheme,
      ApLocalizations.of(context).light,
      ApLocalizations.of(context).dark,
    ];
    final int themeModeIndex = ApTheme.of(context).themeMode.index;
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
              final ThemeMode mode = ThemeMode.values[index];
              onChange.call(mode);
              PreferenceUtil.instance
                  .setInt(ApConstants.prefThemeModeIndex, index);
              AnalyticsUtil.instance.logEvent(
                'change_theme',
                parameters: <String, String>{
                  'code': mode.toString(),
                },
              );
              // AnalyticsUtils.instance?.logThemeEvent(mode);
            },
          ),
        );
        AnalyticsUtil.instance.logEvent('theme_mode_setting_click');
      },
    );
  }
}

class ChangeIconStyleItem extends StatelessWidget {
  const ChangeIconStyleItem({
    super.key,
    required this.onChange,
  });

  final Function(String code) onChange;

  @override
  Widget build(BuildContext context) {
    final int iconStyleIndex = ApIcon.index;
    final ApLocalizations ap = ApLocalizations.of(context);
    return SettingItem(
      text: ap.iconStyle,
      subText: ap.iconText,
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SimpleOptionDialog(
            title: ap.theme,
            items: <String>[
              ap.outlined,
              ap.filled,
            ],
            index: iconStyleIndex,
            onSelected: (int index) {
              final String code = ApIcon.values[index];
              ApIcon.code = code;
              PreferenceUtil.instance
                  .setString(ApConstants.prefIconStyleCode, code);
              onChange.call(code);
              AnalyticsUtil.instance.logEvent(
                'change_icon_style',
                parameters: <String, String>{'code': code},
              );
            },
          ),
        );
        AnalyticsUtil.instance.logEvent('icon_style_setting_click');
      },
    );
  }
}
