import 'dart:math';

import 'package:ap_common/ap_common.dart';
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

  int weekday = DateTime.now().weekday;
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
              NotificationUtil.instance.show(
                id: 1,
                androidChannelId: '1',
                androidChannelDescription: 'Test',
                title: app.testTitle,
                content: app.testContent,
              );
            },
            title: Text(app.showNow),
            subtitle: const Text('NotificationUtil.instance.show'),
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
              NotificationUtil.instance.schedule(
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
            subtitle: const Text('NotificationUtil.instance.schedule'),
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
                  index: weekday - 1,
                  onSelected: (int index) {
                    setState(() => weekday = index + 1);
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
              NotificationUtil.instance.scheduleWeeklyNotify(
                id: id,
                androidChannelId: '1',
                androidChannelDescription: 'Schedule Weekly Notify',
                title: app.scheduleWeeklyNotifyTitle,
                content: sprintf(
                  app.scheduleWeeklyNotifyContent,
                  <String>[
                    ApLocalizations.of(context).weekdaysCourse[weekday - 1],
                    time.format(context),
                  ],
                ),
                weekday: weekday,
                time: TimeOfDay(
                  hour: time.hour,
                  minute: time.minute,
                ),
              );
            },
            title: Text(
              sprintf(
                app.scheduleWeeklyNotifyContent,
                <String>[
                  ApLocalizations.of(context).weekdaysCourse[weekday - 1],
                  time.format(context),
                ],
              ),
            ),
            subtitle:
                const Text('NotificationUtil.instance.scheduleWeeklyNotify'),
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
              final bool? result =
                  await NotificationUtil.instance.requestPermissions();
              if (result != null) {
                //ignore: use_build_context_synchronously
                if (!context.mounted) return;
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
              'NotificationUtil.instance.requestPermissions (iOS & macOS limit)',
            ),
          ),
          // ListTile(
          //   onTap: () async {
          //     final List<PendingNotificationRequest> list =
          //         await NotificationUtil.instance.getPendingNotificationList();
          //     //ignore: use_build_context_synchronously
          //     if (!context.mounted) return;
          //     showDialog(
          //       context: context,
          //       builder: (_) => SimpleOptionDialog(
          //         title: app.getPendingNotificationList,
          //         items: <String>[
          //           for (final PendingNotificationRequest item in list)
          //             'id = ${item.id}, ' +
          //                 'title = ${item.title}\n body = ${item.body}',
          //         ],
          //         index: -1,
          //         onSelected: (int index) {
          //           NotificationUtil.instance
          //               .cancelCourseNotify(id: list[index].id);
          //         },
          //       ),
          //     );
          //   },
          //   title: Text(app.getPendingNotificationList),
          //   subtitle: const Text(
          //       'NotificationUtil.instance.getPendingNotificationList'),
          // ),
          const Divider(height: 0.0),
          ListTile(
            onTap: () {
              NotificationUtil.instance.cancelAll();
            },
            title: Text(app.cancelAll),
            subtitle: const Text('NotificationUtil.instance.cancelAll'),
          ),
        ],
      ),
    );
  }
}
