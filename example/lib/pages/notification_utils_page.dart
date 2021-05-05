import 'dart:math';

import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/dialog_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../utils/app_localizations.dart';

class NotificationUtilsTestPage extends StatefulWidget {
  @override
  _NotificationUtilsTestPageState createState() =>
      _NotificationUtilsTestPageState();
}

class _NotificationUtilsTestPageState extends State<NotificationUtilsTestPage> {
  AppLocalizations app;

  Day day = NotificationUtils.getDay(DateTime.now().weekday - 1);
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    app = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(app.localNotificationTest),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '基本顯示',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Divider(height: 0.0),
          ListTile(
            onTap: () {
              NotificationUtils.show(
                id: 1,
                androidChannelId: '1',
                androidChannelDescription: 'Test',
                title: app.testTitle,
                content: app.testContent,
              );
            },
            title: Text(app.showNow),
            subtitle: Text('NotificationUtils.show'),
          ),
          Divider(height: 0.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '定時顯示',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            onTap: () {
              NotificationUtils.schedule(
                id: 2,
                androidChannelId: '1',
                androidChannelDescription: 'Test',
                title: app.testTitle,
                content: app.testContent,
                dateTime: DateTime.now().add(
                  Duration(seconds: 5),
                ),
              );
            },
            title: Text(app.showInFiveSeconds),
            subtitle: Text('NotificationUtils.schedule'),
          ),
          Divider(height: 0.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '設定每週通知',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => SimpleOptionDialog(
                  title: app.setWeekDay,
                  items: ApLocalizations.of(context).weekdays,
                  index: day.value - 1,
                  onSelected: (int index) {
                    setState(() => day = Day(index + 1));
                  },
                ),
              );
            },
            title: Text(
              app.setWeekDay,
            ),
          ),
          ListTile(
            onTap: () async {
              var dayOfTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: time.hour,
                  minute: time.minute,
                ),
              );
              if (dayOfTime != null) setState(() => this.time = dayOfTime);
            },
            title: Text(app.setTimeOfDay),
          ),
          ListTile(
            onTap: () {
              int id = Random().nextInt(10000);
              NotificationUtils.scheduleWeeklyNotify(
                id: id,
                androidChannelId: '1',
                androidChannelDescription: 'Schedule Weekly Notify',
                title: app.scheduleWeeklyNotifyTitle,
                content: sprintf(
                  app.scheduleWeeklyNotifyContent,
                  [
                    ApLocalizations.of(context).weekdays[day.value - 1],
                    time.format(context),
                  ],
                ),
                day: day,
                time: Time(time.hour, time.minute),
              );
            },
            title: Text(
              sprintf(
                app.scheduleWeeklyNotifyContent,
                [
                  ApLocalizations.of(context).weekdays[day.value - 1],
                  time.format(context),
                ],
              ),
            ),
            subtitle: Text('NotificationUtils.scheduleWeeklyNotify'),
          ),
          Divider(height: 0.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '其他功能',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            onTap: () async {
              var result = await NotificationUtils.requestPermissions();
              if (result != null) {
                DialogUtils.showDefault(
                  context: context,
                  title: app.requestPermission,
                  content: result
                      ? ApLocalizations.of(context).updateSuccess
                      : ApLocalizations.of(context).loginFail,
                );
              }
            },
            title: Text(app.requestPermission),
            subtitle: Text(
                'NotificationUtils.requestPermissions (iOS & macOS limit)'),
          ),
          ListTile(
            onTap: () async {
              var list = await NotificationUtils.getPendingNotificationList();
              showDialog(
                context: context,
                builder: (_) => SimpleOptionDialog(
                  title: app.getPendingNotificationList,
                  items: [
                    for (var item in list)
                      'id = ${item.id}, '
                          'title = ${item.title}\n body = ${item.body}'
                  ],
                  index: -1,
                  onSelected: (int index) {
                    NotificationUtils.cancelCourseNotify(id: list[index].id);
                  },
                ),
              );
            },
            title: Text(app.getPendingNotificationList),
            subtitle: Text('NotificationUtils.getPendingNotificationList'),
          ),
          Divider(height: 0.0),
          ListTile(
            onTap: () {
              NotificationUtils.cancelAll();
            },
            title: Text(app.cancelAll),
            subtitle: Text('NotificationUtils.cancelAll'),
          ),
        ],
      ),
    );
  }
}
