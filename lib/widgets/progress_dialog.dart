import 'package:ap_common/resources/ap_theme.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String content;

  ProgressDialog(this.content);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8.0),
          CircularProgressIndicator(
            value: null,
            valueColor:
                AlwaysStoppedAnimation<Color>(ApTheme.of(context).blueAccent),
          ),
          SizedBox(height: 28.0),
          Container(
            child: Text(
              content,
              style: TextStyle(color: ApTheme.of(context).blueAccent),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
