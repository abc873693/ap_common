import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:flutter/material.dart';

import 'option_dialog.dart';

class ItemPicker extends StatelessWidget {
  final List<String> items;
  final int currentIndex;
  final Function(int index) onSelected;
  final String dialogTitle;

  const ItemPicker({
    Key? key,
    required this.onSelected,
    required this.items,
    required this.dialogTitle,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SimpleOptionDialog(
            title: dialogTitle,
            items: items,
            index: currentIndex,
            onSelected: onSelected,
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Text(
              items[currentIndex] ?? '',
              style: TextStyle(
                color: ApTheme.of(context).semesterText,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 8.0),
          Icon(
            ApIcon.keyboardArrowDown,
            color: ApTheme.of(context).semesterText,
          )
        ],
      ),
    );
  }
}
