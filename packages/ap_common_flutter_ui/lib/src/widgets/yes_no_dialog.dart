import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    super.key,
    this.title,
    this.contentWidget,
    this.contentWidgetPadding,
    this.leftActionText,
    this.rightActionText,
    this.leftActionFunction,
    this.rightActionFunction,
  });

  final String? title;
  final Widget? contentWidget;
  final EdgeInsetsGeometry? contentWidgetPadding;
  final String? leftActionText;
  final String? rightActionText;
  final VoidCallback? leftActionFunction;
  final VoidCallback? rightActionFunction;

  static void showSample(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => YesNoDialog(
          title: '預約成功',
          contentWidget: Text(
            '預約日期：2017/09/05\n上車地點：燕巢校區\n預約班次：08:20',
            style: TextStyle(color: ApTheme.of(context).greyText, height: 1.3),
          ),
          leftActionText: '取消',
          rightActionText: '預約',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      title: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ApTheme.of(context).blueText,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 16.0),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            padding: contentWidgetPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 24.0,
                ),
            child: contentWidget,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    leftActionFunction?.call();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      leftActionText ?? ApLocalizations.current.confirm,
                      style: TextStyle(
                        color: ApTheme.of(context).greyText,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(16.0),
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    rightActionFunction?.call();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      rightActionText ?? ApLocalizations.current.cancel,
                      style: TextStyle(
                        color: ApTheme.of(context).greyText,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
