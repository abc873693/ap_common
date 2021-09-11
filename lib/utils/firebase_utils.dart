import 'dart:io';

import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/crashlytics_utils.dart';
import 'package:ap_common_firebase/utils/firebase_analytics_utils.dart';
import 'package:ap_common_firebase/utils/firebase_crashlytics_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import 'firebase_performance_utils.dart';

export 'package:firebase_analytics/firebase_analytics.dart';
export 'package:firebase_analytics/observer.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';
export 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseUtils {
  static FirebaseAnalytics? init() {
    if (FirebaseCrashlyticsUtils.isSupported)
      CrashlyticsUtils.instance = FirebaseCrashlyticsUtils.instance;
    if (FirebaseAnalyticsUtils.isSupported) {
      AnalyticsUtils.instance = FirebaseAnalyticsUtils.instance;
      return FirebaseAnalyticsUtils.instance.analytics;
    }
    FirebasePerformancesUtils.instance.init();
    return null;
  }

  static bool get isSupportCore =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS);
}
