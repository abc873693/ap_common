import 'package:flutter/material.dart';

import 'dialog_option.dart';

class SimpleOptionDialog extends StatelessWidget {
  final String title;
  final List<String> items;
  final int index;
  final Function(int index)? onSelected;

  const SimpleOptionDialog({
    Key? key,
    required this.title,
    required this.items,
    required this.onSelected,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.length > 5
        ? AlertDialog(
            title: Text(title),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            contentPadding: const EdgeInsets.all(0.0),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.separated(
                controller: ScrollController(initialScrollOffset: index * 48.0),
                itemCount: items.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 6.0);
                },
                itemBuilder: (BuildContext context, int index) {
                  return DialogOption(
                    text: items[index],
                    check: index == this.index,
                    onPressed: () {
                      Navigator.pop(context, index);
                      onSelected?.call(index);
                    },
                  );
                },
              ),
            ),
          )
        : SimpleDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            title: Text(title),
            children: [
              for (var i = 0; i < (items.length); i++)
                DialogOption(
                  text: items[i],
                  check: i == index,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onSelected?.call(i);
                  },
                ),
            ],
          );
  }
}
