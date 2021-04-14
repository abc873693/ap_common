import 'dart:async';

import 'package:ap_common_firebase/utils/firebase_utils.dart';
import 'package:ap_common/utils/crashlytics_utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

export 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseCrashlyticsUtils extends CrashlyticsUtils {
  static FirebaseCrashlyticsUtils? _instance;
  FirebaseCrashlytics? crashlytics;

  static FirebaseCrashlyticsUtils get instance {
    return _instance ??= FirebaseCrashlyticsUtils();
  }

  FirebaseCrashlyticsUtils() {
    if (FirebaseUtils.isSupportCrashlytics)
      crashlytics = FirebaseCrashlytics.instance;
  }

  @override
  Future<void> log(String message) async {
    await crashlytics?.log(message);
  }

  @override
  Future<void> recordError(
    exception,
    StackTrace stack, {
    reason,
    Iterable<DiagnosticsNode>? information,
    bool? printDetails,
  }) async {
    await crashlytics?.recordError(
      exception,
      stack,
      reason: reason,
      information: information!,
      printDetails: printDetails,
    );
  }
}
