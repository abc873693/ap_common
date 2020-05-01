import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static showAnnouncementRule({
    @required BuildContext context,
    @required Function onRightButtonClick,
  }) {
    final ap = ApLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) => YesNoDialog(
        title: ap.newsRuleTitle,
        contentWidget: RichText(
          text: TextSpan(
            style: TextStyle(color: ApTheme.of(context).grey, fontSize: 16.0),
            children: [
              TextSpan(
                  text: '${ap.newsRuleDescription1}',
                  style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(
                  text: '${ap.newsRuleDescription2}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '${ap.newsRuleDescription3}',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        leftActionText: ap.cancel,
        rightActionText: ap.contactFansPage,
        leftActionFunction: () {},
        rightActionFunction: onRightButtonClick,
      ),
    );
  }
}
