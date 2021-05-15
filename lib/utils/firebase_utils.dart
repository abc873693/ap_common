import 'dart:async';
import 'dart:io';

import 'package:ap_common/config/analytics_constants.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/crashlytics_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common_firebase/utils/firebase_analytics_utils.dart';
import 'package:ap_common_firebase/utils/firebase_crashlytics_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:firebase_analytics/firebase_analytics.dart';
export 'package:firebase_analytics/observer.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';
export 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseUtils {
  static const NOTIFY_ID = 9919;
  static const NOTIFY_ANDROID_CHANNEL_ID = '1000';
  static String androidChannelDescription = 'FCM';

  static bool get isSupportCore =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

  static bool get isSupportAnalytics =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS);

  static bool get isSupportCloudMessage =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

  static bool get isSupportCrashlytics =>
      (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS));

  static bool get isSupportRemoteConfig =>
      (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS));

  static FirebaseAnalytics? init() {
    if (isSupportCrashlytics)
      CrashlyticsUtils.instance = FirebaseCrashlyticsUtils.instance;
    if (isSupportAnalytics) {
      AnalyticsUtils.instance = FirebaseAnalyticsUtils.instance;
      return FirebaseAnalyticsUtils.instance.analytics;
    }
    return null;
  }

  static initFcm({
    Function(RemoteMessage)? onClick,
    String? vapidKey,
    bool customOnClickAction = false,
  }) async {
    if (!isSupportCloudMessage) return;
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await Future.delayed(Duration(seconds: 2));
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
    firebaseMessaging
        .requestPermission(
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
    firebaseMessaging.getToken(vapidKey: vapidKey).then((String? token) {
      if (token != null && kDebugMode) {
        print("Push Messaging token: $token");
      }
    });
  }

  static Future<void> navigateToItemDetail(
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
