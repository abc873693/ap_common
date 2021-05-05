import 'package:ap_common/resources/ap_theme.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String content;

  const ProgressDialog(this.content);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8.0),
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ApTheme.of(context).blueAccent),
          ),
          const SizedBox(height: 28.0),
          Text(
            content,
            style: TextStyle(color: ApTheme.of(context).blueAccent),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
