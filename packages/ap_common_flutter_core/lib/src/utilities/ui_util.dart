import 'package:ap_common_core/injector.dart';
import 'package:flutter/widgets.dart';

abstract class UiUtil {
  static UiUtil get instance => injector.get<UiUtil>();

  void showToast(
    BuildContext context,
    String message, {
    int? gravity,
  });
}
