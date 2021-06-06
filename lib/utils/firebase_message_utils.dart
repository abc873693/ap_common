import 'dart:io';

import 'package:ap_common/config/analytics_constants.dart';
import 'package:ap_common/utils/cloud_message_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common_firebase/utils/firebase_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_analytics_utils.dart';

export 'package:ap_common/utils/cloud_message_utils.dart';
export 'package:firebase_messaging/firebase_messaging.dart';

const NOTIFY_ID = 9919;
const NOTIFY_ANDROID_CHANNEL_ID = '1000';
const androidChannelDescription = 'FCM';

class FirebaseMessagingUtils {
  static FirebaseMessagingUtils? _instance;

  static FirebaseMessagingUtils get instance {
    return _instance ??= FirebaseMessagingUtils();
  }

  static bool get isSupported =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS) &&
      FirebaseMessaging.instance.isSupported();

  FirebaseMessagingUtils() {
    if (isSupported) {
      messaging = FirebaseMessaging.instance;
    }
  }

  FirebaseMessaging? messaging;

  Future<void> init({
    Function(RemoteMessage)? onClick,
    String? vapidKey,
    bool customOnClickAction = false,
  }) async {
    if (!FirebaseMessagingUtils.isSupported) return;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        debugPrint("onMessage: $message");
        NotificationUtils.show(
          id: NOTIFY_ID,
          androidChannelId: NOTIFY_ANDROID_CHANNEL_ID,
          androidChannelDescription: androidChannelDescription,
          title: message.notification!.title ?? '',
          content: message.notification!.body ?? '',
          onSelectNotification: () async {
            await navigateToItemDetail(
              message,
              onClick,
              customOnClickAction,
            );
          },
        );
        message.save();
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint("onMessageOpenedApp: $message");
      await navigateToItemDetail(
        message,
        onClick,
        customOnClickAction,
      );
    });
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      debugPrint("onBackgroundMessage: $message");
      await navigateToItemDetail(
        message,
        onClick,
        customOnClickAction,
      );
      message.save();
    });
    messaging
        ?.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        )
        .then(
          (value) => FirebaseAnalyticsUtils.instance.setUserProperty(
            AnalyticsConstants.hasEnableNotification,
            (value.authorizationStatus == AuthorizationStatus.authorized)
                .toString(),
          ),
        );
    messaging?.getToken(vapidKey: vapidKey).then((String? token) {
      if (token != null && kDebugMode) {
        print("Push Messaging token: $token");
      }
    });
  }

  Future<void> navigateToItemDetail(
    RemoteMessage message,
    Function(RemoteMessage)? onClick,
    bool customOnClickAction,
  ) async {
    final data = message.data;
    if (customOnClickAction) {
      onClick?.call(message);
    } else if (data['type'] == "1") {
      launch(data['url']);
    } else {
      onClick?.call(message);
    }
  }
}

extension RemoteMessageExtension on RemoteMessage {
  CloudMessage get cloudMessage {
    final notification = this.notification!;
    String? imageUrl;
    if (!kIsWeb && Platform.isAndroid) {
      imageUrl = notification.android?.imageUrl;
    } else if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      imageUrl = notification.apple?.imageUrl;
    }
    return CloudMessage(
      title: notification.title ?? '',
      dateTime: sentTime ?? DateTime.now(),
      content: notification.body ?? '',
      url: data['url'],
      imageUrl: imageUrl,
      data: data,
    );
  }

  void save() {
    try {
      CloudMessageUtils.instance.box.add(cloudMessage);
    } on HiveError catch (_) {
      debugPrint('Not initial hive, please use ApHiveHelper.init() in main()');
    }
  }
}
