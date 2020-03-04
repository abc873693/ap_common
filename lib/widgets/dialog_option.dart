import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  final String text;
  final bool check;
  final Function onPressed;

  const DialogOption({
    Key key,
    @required this.text,
    @required this.check,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 16.0,
                  color: check ? ApTheme.of(context).blueAccent : null),
            ),
          ),
          if (check)
            Icon(
              ApIcon.check,
              color: ApTheme.of(context).blueAccent,
            )
        ],
      ),
      onPressed: onPressed,
    );
  }
}
