import 'dart:io';

import 'package:ap_common_firebase/src/utils/firebase_analytics_utils.dart';
import 'package:ap_common_firebase/src/utils/firebase_crashlytics_utils.dart';
import 'package:ap_common_firebase/src/utils/firebase_performance_utils.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_analytics/firebase_analytics.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';
export 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseUtils {
  static FirebaseAnalytics? init() {
    registerApCommonService(
      analytics: FirebaseAnalyticsUtils(),
      crashlytics: FirebaseCrashlyticsUtils(),
    );
    FirebasePerformancesUtils.instance.init();
    return null;
  }

  static bool get isSupportCore =>
      kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS;
}
