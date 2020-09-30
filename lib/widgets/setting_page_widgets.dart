import 'package:ap_common/models/course_notify_data.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:flutter/material.dart';

import 'option_dialog.dart';

class SettingTitle extends StatelessWidget {
  final String text;

  const SettingTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        text,
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
  final Function onChanged;

  const SettingSwitch({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
      subtitle: Text(
        subText,
        style: TextStyle(fontSize: 14.0, color: ApTheme.of(context).greyText),
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
  final Function onTap;

  const SettingItem({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 16.0),
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
  final String tag;

  const CheckCourseNotifyItem({Key key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = ApLocalizations.of(context);
    return SettingItem(
      text: ap.courseNotify,
      subText: ap.courseNotifySubTitle,
      onTap: () {
        CourseNotifyData notifyData = tag == null
            ? CourseNotifyData.loadCurrent()
            : CourseNotifyData.load(tag);
        if (NotificationUtils.isSupport) {
          if (notifyData != null && notifyData.data.length != 0) {
            showDialog(
              context: context,
              builder: (_) => SimpleOptionDialog(
                title: ap.courseNotify ?? '',
                items: [
                  for (var notify in notifyData.data)
                    '${ap.weekdaysCourse[notify.weeklyIndex]} ${notify.startTime} ${notify.title}',
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
          } else
            ApUtils.showToast(context, ap.courseNotifyEmpty);
        } else
          ApUtils.showToast(context, ap.platformError);
      },
    );
  }
}

class ClearAllNotifyItem extends StatelessWidget {
  final String tag;

  const ClearAllNotifyItem({Key key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = ApLocalizations.of(context);
    return SettingItem(
      text: ap.cancelAllNotify,
      subText: ap.cancelAllNotifySubTitle,
      onTap: () {
        if (NotificationUtils.isSupport) {
          NotificationUtils.cancelAll();
          CourseNotifyData notifyData = tag == null
              ? CourseNotifyData.loadCurrent()
              : CourseNotifyData.load(tag);
          notifyData.data.clear();
          notifyData.save();
          ApUtils.showToast(context, ap.cancelNotifySuccess);
        } else
          ApUtils.showToast(context, ap.platformError);
      },
    );
  }
}
