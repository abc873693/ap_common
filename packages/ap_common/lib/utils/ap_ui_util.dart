import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/toast.dart';
import 'package:flutter/material.dart';

class ApUiUtil {
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
