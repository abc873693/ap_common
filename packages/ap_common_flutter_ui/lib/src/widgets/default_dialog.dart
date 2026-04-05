import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  const DefaultDialog({
    super.key,
    required this.title,
    required this.contentWidget,
    required this.actionText,
    required this.actionFunction,
    this.contentPadding,
  });

  final String title;
  final Widget contentWidget;
  final String actionText;
  final Function() actionFunction;
  final EdgeInsetsGeometry? contentPadding;

  static void showSample(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => DefaultDialog(
          title: 'Reservation Success',
          actionText: 'Got it',
          actionFunction: () =>
              Navigator.of(context, rootNavigator: true).pop('dialog'),
          contentWidget: Text(
            'Date: 2017/09/05\nPickup: Campus A\nTime: 08:20',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: SingleChildScrollView(
          padding: contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
          child: contentWidget,
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: actionFunction,
            child: Text(actionText),
          ),
        ),
      ],
    );
  }
}
