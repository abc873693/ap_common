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
          FlatButton(
            onPressed: () async {
              var result = await FlutterLocalNotificationsPlugin()
                  .resolvePlatformSpecificImplementation<
                      MacOSFlutterLocalNotificationsPlugin>()
                  ?.requestPermissions(
                    alert: true,
                    badge: true,
                    sound: true,
                  );
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
            child: Text(app.requestPermission),
          ),
          FlatButton(
            onPressed: () {
              NotificationUtils.show(
                id: 1,
                androidChannelId: '1',
                androidChannelDescription: 'Test',
                title: app.testTitle,
                content: app.testContent,
              );
            },
            child: Text(app.showNow),
          ),
          FlatButton(
            onPressed: () {
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
            child: Text(app.showInFiveSeconds),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {
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
                child: Text(
                  app.setWeekDay,
                ),
              ),
              FlatButton(
                onPressed: () async {
                  var dayOfTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: time.hour,
                      minute: time.minute,
                    ),
                  );
                  if (dayOfTime != null) setState(() => this.time = dayOfTime);
                },
                child: Text(app.setTimeOfDay),
              ),
            ],
          ),
          FlatButton(
            onPressed: () {
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
            child: Text(
              sprintf(
                app.scheduleWeeklyNotifyContent,
                [
                  ApLocalizations.of(context).weekdays[day.value - 1],
                  time.format(context),
                ],
              ),
            ),
          ),
          FlatButton(
            onPressed: () async {
              var list = await NotificationUtils.getPendingNotificationList();
              showDialog(
                context: context,
                builder: (_) => SimpleOptionDialog(
                  title: app.getPendingNotificationList,
                  items: [
                    for (var item in list)
                      'id = ${item.id}, title = ${item.title}\n body = ${item.body}'
                  ],
                  index: -1,
                  onSelected: (int index) {
                    NotificationUtils.cancelCourseNotify(id: list[index].id);
                  },
                ),
              );
            },
            child: Text(app.getPendingNotificationList),
          ),
          FlatButton(
            onPressed: () {
              NotificationUtils.cancelAll();
            },
            child: Text(app.cancelAll),
          ),
        ],
      ),
    );
  }
}
