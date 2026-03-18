import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog(this.content);

  final String content;

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
            style: TextStyle(color: colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
