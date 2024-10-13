import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:ap_common_flutter_ui/src/resources/ap_theme.dart';
import 'package:ap_common_flutter_ui/src/utils/toast.dart';
import 'package:flutter/material.dart';

class ApUiUtil extends UiUtil {
  @override
  void showToast(
    BuildContext context,
    String? message, {
    int? gravity,
  }) {
    Toast.show(
      message,
      context,
      duration: Toast.lengthLong,
      gravity: gravity ?? Toast.bottom,
      textStyle: TextStyle(
        color: ApTheme.of(context).toastText,
      ),
      backgroundColor: ApTheme.of(context).toastBackground,
    );
  }
}
