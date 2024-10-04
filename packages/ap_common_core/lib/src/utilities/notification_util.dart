import 'package:ap_common_core/injector.dart';

abstract class NotificationUtil {
  static NotificationUtil get instance => injector.get<NotificationUtil>();

  static bool get isSupport => true;

  static const String androidResourceName = '@drawable/ic_stat_name';

  // Notification ID
  static const int bus = 100;
  static const int course = 101;
  static const int fcm = 200;

  Future<void> show({
    required int id,
    required String androidChannelId,
    required String androidChannelDescription,
    required String title,
    required String content,
    bool enableVibration = true,
    String androidResourceIcon = androidResourceName,
    void Function()? onSelectNotification,
  }) async {}

  // Future<void> scheduleWeeklyNotify({
  //   required int id,
  //   required String androidChannelId,
  //   required String androidChannelDescription,
  //   required int weekday,
  //   required TimeOfDay time,
  //   required String title,
  //   required String content,
  //   String androidResourceIcon = androidResourceName,
  //   void Function()? onSelectNotification,
  // }) async {
  //
  // }

  Future<void> schedule({
    required int id,
    required String androidChannelId,
    required String androidChannelDescription,
    required DateTime dateTime,
    required String title,
    required String content,
    String androidResourceIcon = androidResourceName,
    void Function()? onSelectNotification,
  }) async {}

  Future<bool?> requestPermissions({
    bool sound = true,
    bool alert = true,
    bool badge = true,
  });

  Future<void> cancelNotify({
    required int id,
  });

  Future<void> cancelAll();
}
