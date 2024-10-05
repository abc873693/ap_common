import 'dart:async';
import 'dart:io';

import 'package:ap_common_core/ap_common_core.dart';
import 'package:ap_common_firebase/utils/firebase_utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseCrashlyticsUtils extends CrashlyticsUtil {
  FirebaseCrashlyticsUtils() {
    if (isSupported) crashlytics = FirebaseCrashlytics.instance;
  }

  static FirebaseCrashlyticsUtils? _instance;

  //ignore: prefer_constructors_over_static_methods
  static FirebaseCrashlyticsUtils get instance {
    return _instance ??= FirebaseCrashlyticsUtils();
  }

  static bool get isSupported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

  FirebaseCrashlytics? crashlytics;

  @override
  Future<void> log(String message) async {
    await crashlytics?.log(message);
  }

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace stack, {
    dynamic reason,
    Iterable<Object>? information,
    bool? printDetails,
  }) async {
    information ??= const <Object>[];
    await crashlytics?.recordError(
      exception,
      stack,
      reason: reason,
      information: information,
      printDetails: printDetails,
    );
  }

  @override
  Future<void> setCustomKey(String key, Object value) async {
    await crashlytics?.setCustomKey(key, value);
  }

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    await crashlytics?.setCrashlyticsCollectionEnabled(enabled);
  }
}
