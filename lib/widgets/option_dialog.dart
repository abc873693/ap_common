import 'package:ap_common/widgets/setting_page_widgets.dart';
import 'package:flutter/material.dart';

import 'dialog_option.dart';

class SimpleOptionDialog extends StatelessWidget {
  final String title;
  final List<String> items;
  final int index;
  final Function(int index) onSelected;

  const SimpleOptionDialog({
    Key key,
    this.title,
    this.items,
    this.index = 0,
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
        for (var i = 0; i < (items?.length ?? 0); i++)
          DialogOption(
            text: items[i],
            check: i == index,
            onPressed: () {
              this.onSelected(i);
            },
          ),
      ],
    );
  }
}
