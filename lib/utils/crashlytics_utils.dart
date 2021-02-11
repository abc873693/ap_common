import 'package:flutter/material.dart';

abstract class CrashlyticsUtils {
  static CrashlyticsUtils instance;

  Future<void> recordError(
    dynamic exception,
    StackTrace stack, {
    dynamic reason,
    Iterable<DiagnosticsNode> information,
    bool printDetails,
  });

  Future<void> log(String message);
}
