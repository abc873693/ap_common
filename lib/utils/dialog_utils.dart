import 'dart:io';

import 'package:ap_common/models/version_info.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/default_dialog.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogUtils {
  static showDefault({
    @required BuildContext context,
    @required String title,
    @required String content,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => DefaultDialog(
        title: title,
        contentWidget: Text(
          content,
          style: TextStyle(
            color: ApTheme.of(context).grey,
            height: 1.3,
            fontSize: 16.0,
          ),
        ),
        actionText: ApLocalizations.of(context).iKnow,
        actionFunction: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    );
  }

  static showAnnouncementRule({
    @required BuildContext context,
    @required Function onRightButtonClick,
  }) {
    final ap = ApLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) => YesNoDialog(
        title: ap.newsRuleTitle,
        contentWidget: SelectableText.rich(
          TextSpan(
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

  static showUpdateContent(BuildContext context, String content) => showDialog(
        context: context,
        builder: (BuildContext context) => DefaultDialog(
          title: ApLocalizations.of(context).updateNoteTitle,
          contentWidget: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(color: ApTheme.of(context).grey),
          ),
          actionText: ApLocalizations.of(context).iKnow,
          actionFunction: () => Navigator.of(context).pop(),
        ),
      );

  static showNewVersionContent({
    @required BuildContext context,
    @required VersionInfo versionInfo,
    @required String appName,
    @required String iOSAppId,
    @required String defaultUrl,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var app = ApLocalizations.current;
    String url = "";
    if (Platform.isAndroid) {
      url = "market://details?id=${packageInfo.packageName}";
    } else if (Platform.isIOS || Platform.isMacOS) {
      url = "itms-apps://itunes.apple.com/tw/app/apple-store/$iOSAppId?mt=8";
    } else {
      url = defaultUrl;
    }
    int versionDiff = versionInfo.code - int.parse(packageInfo.buildNumber);
    String versionContent =
        "\nv${versionInfo.code ~/ 10000}.${versionInfo.code % 1000 ~/ 100}.${versionInfo.code % 100}\n" +
            versionInfo.content;
    final contentWidget = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
            color: ApTheme.of(context).grey, height: 1.3, fontSize: 16.0),
        children: [
          TextSpan(
            text: '${sprintf(app.updateContent, [appName])}\n'
                '${versionContent.replaceAll('\\n', '\n')}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
    if (versionDiff > 0) {
      if (versionInfo.isForceUpdate)
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WillPopScope(
            child: DefaultDialog(
              title: app.updateTitle,
              actionText: app.update,
              contentWidget: contentWidget,
              actionFunction: () => launch(url),
            ),
            onWillPop: () async {
              return false;
            },
          ),
        );
      else
        showDialog(
          context: context,
          builder: (BuildContext context) => YesNoDialog(
            title: app.updateTitle,
            contentWidget: contentWidget,
            leftActionText: app.skip,
            rightActionText: app.update,
            leftActionFunction: null,
            rightActionFunction: () => launch(url),
          ),
        );
    }
  }
}
