import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Shows a [GlassDialog] with a single action button.
///
/// This is the glass-enhanced equivalent of [DefaultDialog].
Future<void> showGlassDefaultDialog({
  required BuildContext context,
  required String title,
  required Widget contentWidget,
  required String actionText,
  required VoidCallback actionFunction,
}) {
  return GlassDialog.show(
    context: context,
    title: title,
    content: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height * 0.5,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        child: contentWidget,
      ),
    ),
    actions: <GlassDialogAction>[
      GlassDialogAction(
        label: actionText,
        onPressed: actionFunction,
      ),
    ],
  );
}

/// Shows a [GlassDialog] with two action buttons (yes/no).
///
/// This is the glass-enhanced equivalent of [YesNoDialog].
Future<void> showGlassYesNoDialog({
  required BuildContext context,
  String? title,
  Widget? contentWidget,
  String? leftActionText,
  String? rightActionText,
  VoidCallback? leftActionFunction,
  VoidCallback? rightActionFunction,
}) {
  final ApLocalizations ap = context.ap;
  return GlassDialog.show(
    context: context,
    title: title,
    content: contentWidget,
    actions: <GlassDialogAction>[
      GlassDialogAction(
        label: leftActionText ?? ap.confirm,
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .pop();
          leftActionFunction?.call();
        },
      ),
      GlassDialogAction(
        label: rightActionText ?? ap.cancel,
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .pop();
          rightActionFunction?.call();
        },
      ),
    ],
  );
}
