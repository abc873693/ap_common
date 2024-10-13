import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

class ItemPicker extends StatelessWidget {
  const ItemPicker({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.dialogTitle,
    required this.onSelected,
    this.featureTag,
  });

  final List<String> items;
  final int currentIndex;
  final Function(int index)? onSelected;
  final String dialogTitle;
  final String? featureTag;

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
        if (featureTag != null) {
          AnalyticsUtil.instance.logEvent('${featureTag}_item_picker_click');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Text(
                items.isEmpty ? '' : items[currentIndex],
                style: TextStyle(
                  color: ApTheme.of(context).semesterText,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 8.0),
            Icon(
              ApIcon.keyboardArrowDown,
              color: ApTheme.of(context).semesterText,
            ),
          ],
        ),
      ),
    );
  }
}
