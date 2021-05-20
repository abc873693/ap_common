import 'dart:io';

import 'package:ap_common_firebase/utils/firebase_utils.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingUtils {
  static FirebaseMessagingUtils? _instance;

  static FirebaseMessagingUtils get instance {
    return _instance ??= FirebaseMessagingUtils();
  }

  FirebaseMessagingUtils() {
    if (isSupported) messaging = FirebaseMessaging.instance;
  }

  FirebaseMessaging? messaging;

  static bool get isSupported =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS) &&
      FirebaseMessaging.instance.isSupported();
}
