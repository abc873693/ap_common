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

  static FirebaseAnalytics init({
    String vapidKey,
  }) {
    if (isSupportCloudMessage) initFcm(vapidKey: vapidKey);
    if (isSupportCrashlytics)
      CrashlyticsUtils.instance = FirebaseCrashlyticsUtils.instance;
    if (isSupportAnalytics) {
      AnalyticsUtils.instance = FirebaseAnalyticsUtils.instance;
      return FirebaseAnalyticsUtils.analytics;
    }
    return null;
  }

  static initFcm({
    Function(dynamic) onClick,
    String vapidKey,
  }) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await Future.delayed(Duration(seconds: 2));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        debugPrint("onMessage: $message");
        NotificationUtils.show(
          id: NOTIFY_ID,
          androidChannelId: NOTIFY_ANDROID_CHANNEL_ID,
          androidChannelDescription: androidChannelDescription,
          title: message.notification.title ?? '',
          content: message.notification.body ?? '',
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp: $message");
      if (Platform.isAndroid)
        navigateToItemDetail(message.data, onClick);
      else if (Platform.isIOS) navigateToItemDetail(message, onClick);
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      debugPrint("onBackgroundMessage: $message");
      if (Platform.isAndroid) {
        await navigateToItemDetail(message.data, onClick);
      } else if (Platform.isIOS) await navigateToItemDetail(message, onClick);
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
            AnalyticsConstants.HAS_ENABLE_NOTIFICATION,
            (value.authorizationStatus == AuthorizationStatus.authorized)
                .toString(),
          ),
        );
    firebaseMessaging.getToken(vapidKey: vapidKey).then((String token) {
      if (token != null && kDebugMode) {
        print("Push Messaging token: $token");
      }
    });
  }

  static Future<void> navigateToItemDetail(
    message,
    Function(dynamic) onClick,
  ) async {
    if (message['type'] == "1") {
      launch(message['url']);
    } else {
      if (onClick != null) onClick(message);
    }
  }
}
