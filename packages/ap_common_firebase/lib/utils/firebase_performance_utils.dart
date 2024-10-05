import 'dart:io';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_performance/firebase_performance.dart';

class FirebasePerformancesUtils {
  FirebasePerformancesUtils() {
    if (isSupported) {
      performance = FirebasePerformance.instance;
    }
  }
  static FirebasePerformancesUtils? _instance;

  //ignore: prefer_constructors_over_static_methods
  static FirebasePerformancesUtils get instance {
    return _instance ??= FirebasePerformancesUtils();
  }

  static bool get isSupported => kIsWeb || Platform.isAndroid || Platform.isIOS;

  FirebasePerformance? performance;

  void init() {
    performance?.setPerformanceCollectionEnabled(!kDebugMode);
  }

  Trace? newTrace(String name) {
    return performance?.newTrace(name);
  }

  HttpMetric? newHttpMetric(String url, HttpMethod httpMethod) {
    return performance?.newHttpMetric(url, httpMethod);
  }
}
