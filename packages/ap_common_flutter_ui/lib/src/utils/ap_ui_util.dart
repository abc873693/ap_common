import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:ap_common_flutter_ui/src/utils/toast.dart';
import 'package:flutter/material.dart';

class ApUiUtil extends UiUtil {
  @override
  void showToast(
    BuildContext context,
    String? message, {
    int? gravity,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    Toast.show(
      message,
      context,
      duration: Toast.lengthLong,
      gravity: gravity ?? Toast.bottom,
      textStyle: TextStyle(
        color: colorScheme.onInverseSurface,
      ),
      backgroundColor: colorScheme.inverseSurface,
    );
  }
}
