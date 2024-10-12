import 'dart:developer';
import 'dart:io';

import 'package:ap_common_firebase/src/utils/firebase_utils.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:firebase_messaging/firebase_messaging.dart';

const int notifyId = 9919;
const String notifyAndroidChannelId = '1000';
const String androidChannelDescription = 'FCM';

class FirebaseMessagingUtils {
  FirebaseMessagingUtils() {
    if (isSupported) {
      messaging = FirebaseMessaging.instance;
    }
  }

  static FirebaseMessagingUtils? _instance;

  //ignore: prefer_constructors_over_static_methods
  static FirebaseMessagingUtils get instance {
    return _instance ??= FirebaseMessagingUtils();
  }

  static bool get isSupported =>
      kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS;

  Future<bool> isBrowserSupported() async {
    return FirebaseMessaging.instance.isSupported();
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
        debugPrint('onMessage: $message');
        NotificationUtil.instance.show(
          id: notifyId,
          androidChannelId: notifyAndroidChannelId,
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
      debugPrint('onMessageOpenedApp: $message');
      await navigateToItemDetail(
        message,
        onClick,
        customOnClickAction,
      );
    });
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      debugPrint('onBackgroundMessage: $message');
      await navigateToItemDetail(
        message,
        onClick,
        customOnClickAction,
      );
    });
    final NotificationSettings? value = await messaging?.requestPermission();
    if (value?.authorizationStatus == AuthorizationStatus.authorized) {
      messaging?.getToken(vapidKey: vapidKey).then((String? token) {
        if (token != null && kDebugMode) {
          log('Push Messaging token: $token', name: 'firebase');
        }
      });
      AnalyticsUtil.instance.setUserProperty(
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
    final Map<String, dynamic> data = message.data;
    if (customOnClickAction) {
      onClick?.call(message);
    } else if (data['type'] == '1') {
      launchUrl(
        Uri.parse(data['url'] as String),
      );
    } else {
      onClick?.call(message);
    }
  }
}
