import 'dart:async';
import 'dart:io';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_performance/firebase_performance.dart';

class FirebasePerformancesUtils {
  static FirebasePerformancesUtils? _instance;

  static FirebasePerformancesUtils get instance {
    return _instance ??= FirebasePerformancesUtils();
  }

  FirebasePerformancesUtils() {
    if (isSupported) performance = FirebasePerformance.instance;
  }

  FirebasePerformance? performance;

  static bool get isSupported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  Trace? newTrace(String name) {
    return performance?.newTrace(name);
  }

  HttpMetric? newHttpMetric(String url, HttpMethod httpMethod) {
    return performance?.newHttpMetric(url, httpMethod);
  }
}
