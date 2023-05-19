import 'dart:math';

import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/dialog_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:ap_common_example/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class NotificationUtilsTestPage extends StatefulWidget {
  @override
  _NotificationUtilsTestPageState createState() =>
      _NotificationUtilsTestPageState();
}

class _NotificationUtilsTestPageState extends State<NotificationUtilsTestPage> {
  late AppLocalizations app;

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
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '基本顯示',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Divider(height: 0.0),
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
            subtitle: const Text('NotificationUtils.show'),
          ),
          const Divider(height: 0.0),
          const Padding(
            padding: EdgeInsets.all(8.0),
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
                  const Duration(seconds: 5),
                ),
              );
            },
            title: Text(app.showInFiveSeconds),
            subtitle: const Text('NotificationUtils.schedule'),
          ),
          const Divider(height: 0.0),
          const Padding(
            padding: EdgeInsets.all(8.0),
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
              final TimeOfDay? dayOfTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: time.hour,
                  minute: time.minute,
                ),
              );
              if (dayOfTime != null) setState(() => time = dayOfTime);
            },
            title: Text(app.setTimeOfDay),
          ),
          ListTile(
            onTap: () {
              final int id = Random().nextInt(10000);
              NotificationUtils.scheduleWeeklyNotify(
                id: id,
                androidChannelId: '1',
                androidChannelDescription: 'Schedule Weekly Notify',
                title: app.scheduleWeeklyNotifyTitle,
                content: sprintf(
                  app.scheduleWeeklyNotifyContent,
                  <String>[
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
                <String>[
                  ApLocalizations.of(context).weekdays[day.value - 1],
                  time.format(context),
                ],
              ),
            ),
            subtitle: const Text('NotificationUtils.scheduleWeeklyNotify'),
          ),
          const Divider(height: 0.0),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '其他功能',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            onTap: () async {
              final bool? result = await NotificationUtils.requestPermissions();
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
            subtitle: const Text(
                'NotificationUtils.requestPermissions (iOS & macOS limit)',),
          ),
          ListTile(
            onTap: () async {
              final List<PendingNotificationRequest> list =
                  await NotificationUtils.getPendingNotificationList();
              showDialog(
                context: context,
                builder: (_) => SimpleOptionDialog(
                  title: app.getPendingNotificationList,
                  items: <String>[
                    for (PendingNotificationRequest item in list)
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
            subtitle:
                const Text('NotificationUtils.getPendingNotificationList'),
          ),
          const Divider(height: 0.0),
          ListTile(
            onTap: () {
              NotificationUtils.cancelAll();
            },
            title: Text(app.cancelAll),
            subtitle: const Text('NotificationUtils.cancelAll'),
          ),
        ],
      ),
    );
  }
}
