import 'package:ap_common/models/course_notify_data.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

export 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  static const ANDROID_RESOURCE_NAME = '@drawable/ic_stat_name';

  // Notification ID
  static const int BUS = 100;
  static const int COURSE = 101;
  static const int FCM = 200;

  //For taiwan week order
  static Day getDay(int weekIndex) {
    if (weekIndex == 6)
      return Day.Sunday;
    else
      return Day(weekIndex + 2);
  }

  static Time parseTime(String text, {beforeMinutes = 0}) {
    var formatter = DateFormat('HH:mm', 'zh');
    DateTime dateTime = formatter.parse(text).add(
          Duration(minutes: -beforeMinutes),
        );
    return Time(dateTime.hour, dateTime.minute);
  }

  static Future<void> show({
    @required id,
    @required String androidChannelId,
    @required String androidChannelDescription,
    @required String title,
    @required String content,
    bool enableVibration = true,
  }) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelDescription,
      androidChannelDescription,
      icon: ANDROID_RESOURCE_NAME,
      importance: Importance.Max,
      enableVibration: enableVibration,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      content,
      platformChannelSpecifics,
      payload: content,
    );
  }

  static Future<void> scheduleCourseNotify({
    @required BuildContext context,
    @required CourseNotify courseNotify,
    @required Day day,
    bool enableVibration = true,
    int beforeMinutes = 10,
  }) async {
    final ap = ApLocalizations.of(context);
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$COURSE',
      ap.courseNotify,
      ap.courseNotify,
      icon: ANDROID_RESOURCE_NAME,
      importance: Importance.Max,
      enableVibration: enableVibration,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    final time =
        parseTime(courseNotify.startTime, beforeMinutes: beforeMinutes);
    String content = sprintf(ap.courseNotifyContent, [
      courseNotify.title,
      courseNotify.location.isEmpty
          ? ap.courseNotifyUnknown
          : courseNotify.location
    ]);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      courseNotify.id,
      ap.courseNotify,
      content,
      getDay(courseNotify.weeklyIndex),
      time,
      platformChannelSpecifics,
      payload: content,
    );
  }

  static Future<void> scheduleWeeklyNotify({
    @required id,
    @required String androidChannelId,
    @required String androidChannelDescription,
    @required Day day,
    @required Time time,
    @required String title,
    @required String content,
  }) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelDescription,
      androidChannelDescription,
      largeIcon: DrawableResourceAndroidBitmap(ANDROID_RESOURCE_NAME),
      importance: Importance.Max,
      enableVibration: false,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      id,
      title,
      content,
      day,
      time,
      platformChannelSpecifics,
      payload: content,
    );
  }

  static Future<void> schedule({
    @required id,
    @required String androidChannelId,
    @required String androidChannelDescription,
    @required DateTime dateTime,
    @required String title,
    @required String content,
    int beforeMinutes = 10,
  }) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannelId,
      androidChannelDescription,
      androidChannelDescription,
      largeIcon: DrawableResourceAndroidBitmap(ANDROID_RESOURCE_NAME),
      importance: Importance.Max,
      enableVibration: false,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    dateTime = dateTime.add(
      Duration(minutes: -beforeMinutes),
    );
    await flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      content,
      dateTime,
      platformChannelSpecifics,
      payload: content,
    );
  }

  static Future<void> cancelCourseNotify({
    @required int id,
  }) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
