import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog(
    this.content, {
    this.onCancel,
  });

  final String content;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8.0),
          const CircularProgressIndicator(),
          const SizedBox(height: 28.0),
          Text(
            content,
            style: TextStyle(color: colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: onCancel != null
          ? <Widget>[
              TextButton(
                onPressed: onCancel,
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
              ),
            ]
          : null,
    );
  }
}
