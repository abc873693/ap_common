import 'package:flutter/material.dart';

import '../resources/ap_theme.dart';

class DefaultDialog extends StatelessWidget {
  final String title;
  final Widget contentWidget;
  final String actionText;
  final Function actionFunction;
  final EdgeInsetsGeometry? contentPadding;

  const DefaultDialog({
    Key? key,
    required this.title,
    required this.contentWidget,
    required this.actionText,
    required this.actionFunction,
    this.contentPadding,
  }) : super(key: key);

  static showSample(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => DefaultDialog(
          title: '預約成功',
          actionText: '我知道了',
          actionFunction: () =>
              Navigator.of(context, rootNavigator: true).pop('dialog'),
          contentWidget: Text(
            '預約日期：2017/09/05\n上車地點：燕巢校區\n預約班次：08:20',
            style: TextStyle(color: ApTheme.of(context).grey, height: 1.3),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ApTheme.of(context).blueText,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      titlePadding: EdgeInsets.symmetric(vertical: 16.0),
      contentPadding: EdgeInsets.all(0.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            padding: contentPadding ??
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
            child: contentWidget,
          ),
          Container(
            width: double.infinity,
            child: InkWell(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  actionText,
                  style: TextStyle(
                    color: ApTheme.of(context).greyText,
                    fontSize: 18.0,
                  ),
                ),
              ),
              onTap: actionFunction as void Function()?,
            ),
          ),
        ],
      ),
    );
  }
}
