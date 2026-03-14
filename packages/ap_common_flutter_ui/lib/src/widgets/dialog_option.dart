import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  const DialogOption({
    super.key,
    required this.text,
    required this.check,
    required this.onPressed,
  });

  final String text;
  final bool check;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
                  color: check ? colorScheme.primary : null,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          if (check)
            Icon(
              ApIcon.check,
              color: colorScheme.primary,
            ),
        ],
      ),
    );
  }
}
