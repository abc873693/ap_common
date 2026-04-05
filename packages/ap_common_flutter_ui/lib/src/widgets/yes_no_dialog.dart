import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    super.key,
    this.title,
    this.contentWidget,
    this.contentWidgetPadding,
    this.leftActionText,
    this.rightActionText,
    this.leftActionFunction,
    this.rightActionFunction,
  });

  final String? title;
  final Widget? contentWidget;
  final EdgeInsetsGeometry? contentWidgetPadding;
  final String? leftActionText;
  final String? rightActionText;
  final VoidCallback? leftActionFunction;
  final VoidCallback? rightActionFunction;

  static void showSample(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => YesNoDialog(
          title: 'Reservation Success',
          contentWidget: Text(
            'Date: 2017/09/05\nPickup: Campus A\nTime: 08:20',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
          leftActionText: context.ap.cancel,
          rightActionText: context.ap.confirm,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      content: contentWidget != null
          ? Padding(
              padding: contentWidgetPadding ?? EdgeInsets.zero,
              child: contentWidget,
            )
          : null,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            leftActionFunction?.call();
          },
          child: Text(
            leftActionText ?? context.ap.confirm,
          ),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            rightActionFunction?.call();
          },
          child: Text(
            rightActionText ?? context.ap.cancel,
          ),
        ),
      ],
    );
  }
}
