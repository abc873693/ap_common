import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  const DialogOption({
    Key? key,
    required this.text,
    required this.check,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final bool check;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: check ? ApTheme.of(context).blueAccent : null,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          if (check)
            Icon(
              ApIcon.check,
              color: ApTheme.of(context).blueAccent,
            ),
        ],
      ),
    );
  }
}
