import 'dart:io';

import 'package:ap_common_core/ap_common_core.dart';
import 'package:ap_common_firebase/utils/firebase_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_analytics_utils.dart';

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
      (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

  Future<bool> isBrowserSupported() async {
    return FirebaseMessaging.instance.isSupported();
  }

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
    if (!FirebaseMessagingUtils.isSupported || !(await isBrowserSupported())) {
      return;
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        debugPrint("onMessage: $message");
        NotificationUtil.instance.show(
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
    });
    final value = await messaging?.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (value?.authorizationStatus == AuthorizationStatus.authorized) {
      messaging?.getToken(vapidKey: vapidKey).then((String? token) {
        if (token != null && kDebugMode) {
          print("Push Messaging token: $token");
        }
      });
      FirebaseAnalyticsUtils.instance.setUserProperty(
        AnalyticsConstants.hasEnableNotification,
        (value?.authorizationStatus == AuthorizationStatus.authorized)
            .toString(),
      );
    }
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
      launchUrl(
        Uri.parse(data['url']),
      );
    } else {
      onClick?.call(message);
    }
  }
}
