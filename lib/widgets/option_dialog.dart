import 'package:ap_common/widgets/setting_widget.dart';
import 'package:flutter/material.dart';

import 'dialog_option.dart';

class SimpleOptionDialog extends StatelessWidget {
  final String title;
  final List<Item> items;
  final String value;
  final Function(Item item) onSelected;

  const SimpleOptionDialog({
    Key key,
    this.title,
    this.items,
    this.value,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(title),
      children: [
        for (var item in items)
          DialogOption(
            text: item.text,
            check: value == item.value,
            onPressed: () {
              this.onSelected(item);
            },
          ),
      ],
    );
  }
}
