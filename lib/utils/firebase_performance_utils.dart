import 'dart:io';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_performance/firebase_performance.dart';

class FirebasePerformancesUtils {
  static FirebasePerformancesUtils? _instance;

  static FirebasePerformancesUtils get instance {
    return _instance ??= FirebasePerformancesUtils();
  }

  static bool get isSupported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  FirebasePerformancesUtils() {
    if (isSupported) performance = FirebasePerformance.instance;
  }

  FirebasePerformance? performance;

  Trace? newTrace(String name) {
    return performance?.newTrace(name);
  }

  HttpMetric? newHttpMetric(String url, HttpMethod httpMethod) {
    return performance?.newHttpMetric(url, httpMethod);
  }
}
