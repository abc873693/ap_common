import 'dart:math';

import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/utils/app_localizations.dart';
import 'package:flutter/material.dart';


class NotificationUtilsTestPage extends StatefulWidget {
  @override
  _NotificationUtilsTestPageState createState() =>
      _NotificationUtilsTestPageState();
}

class _NotificationUtilsTestPageState extends State<NotificationUtilsTestPage> {
  int weekday = DateTime.now().weekday;
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appT.localNotificationTest),
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
                title: appT.testTitle,
                content: appT.testContent,
              );
            },
            title: Text(appT.showNow),
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
                title: appT.testTitle,
                content: appT.testContent,
                dateTime: DateTime.now().add(
                  const Duration(seconds: 5),
                ),
              );
            },
            title: Text(appT.showInFiveSeconds),
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
                  title: appT.setWeekDay,
                  items: t.weekdays,
                  index: weekday - 1,
                  onSelected: (int index) {
                    setState(() => weekday = index + 1);
                  },
                ),
              );
            },
            title: Text(
              appT.setWeekDay,
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
            title: Text(appT.setTimeOfDay),
          ),
          ListTile(
            onTap: () {
              final int id = Random().nextInt(10000);
              NotificationUtil.instance.scheduleWeeklyNotify(
                id: id,
                androidChannelId: '1',
                androidChannelDescription: 'Schedule Weekly Notify',
                title: appT.scheduleWeeklyNotifyTitle,
                content: appT.scheduleWeeklyNotifyContent(
                  arg1: t.weekdaysCourse[weekday - 1],
                  arg2: time.format(context),
                ),
                weekday: weekday,
                time: TimeOfDay(
                  hour: time.hour,
                  minute: time.minute,
                ),
              );
            },
            title: Text(
              appT.scheduleWeeklyNotifyContent(
                arg1: t.weekdaysCourse[weekday - 1],
                arg2: time.format(context),
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
                  title: appT.requestPermission,
                  content: result
                      ? t.updateSuccess
                      : t.loginFail,
                );
              }
            },
            title: Text(appT.requestPermission),
            subtitle: const Text(
              'NotificationUtil.instance.requestPermissions '
              '(iOS & macOS limit)',
            ),
          ),
          // ListTile(
          //   onTap: () async {
          //     final List<PendingNotificationRequest> list =
          //         await NotificationUtil.instance
          //             .getPendingNotificationList();
          //     //ignore: use_build_context_synchronously
          //     if (!context.mounted) return;
          //     showDialog(
          //       context: context,
          //       builder: (_) => SimpleOptionDialog(
          //         title: appT.getPendingNotificationList,
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
          //   title: Text(appT.getPendingNotificationList),
          //   subtitle: const Text(
          //       'NotificationUtil.instance.getPendingNotificationList'),
          // ),
          const Divider(height: 0.0),
          ListTile(
            onTap: () {
              NotificationUtil.instance.cancelAll();
            },
            title: Text(appT.cancelAll),
            subtitle: const Text('NotificationUtil.instance.cancelAll'),
          ),
        ],
      ),
    );
  }
}
