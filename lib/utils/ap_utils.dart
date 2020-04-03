import 'dart:io';

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/default_dialog.dart';
import 'package:ap_common/widgets/yes_no_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:sprintf/sprintf.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
export 'package:dio/dio.dart';

class ApUtils {
  static void showToast(BuildContext context, String message) {
    Toast.show(
      message,
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      textColor: ApTheme.of(context).toastText,
      backgroundColor: ApTheme.of(context).toastBackground,
    );
  }

  static pushCupertinoStyle(BuildContext context, Widget page) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (BuildContext context) {
        return page;
      }),
    );
  }

  static void handleDioError(BuildContext context, DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.DEFAULT:
        showToast(context, ApLocalizations.of(context).noInternet);
        break;
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
        showToast(context, ApLocalizations.of(context).timeoutMessage);
        break;
      case DioErrorType.RESPONSE:
        showToast(context, dioError.message);
        break;
      case DioErrorType.CANCEL:
        break;
    }
  }

  static showNewVersionDialog({
    @required BuildContext context,
    @required int newVersionCode,
    @required String appName,
    @required String iOSAppId,
    @required String defaultUrl,
    @required String newVersionContent,
    int minVersionDiff = 5,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var app = ApLocalizations.of(context);
    String url = "";
    if (Platform.isAndroid) {
      url = "market://details?id=${packageInfo.packageName}";
    } else if (Platform.isIOS) {
      url = "itms-apps://itunes.apple.com/tw/app/apple-store/$iOSAppId?mt=8";
    } else {
      url = defaultUrl;
    }
    int versionDiff = newVersionCode - int.parse(packageInfo.buildNumber);
    String versionContent =
        "v${newVersionCode ~/ 10000}.${newVersionCode % 1000 ~/ 100}.${newVersionCode % 100}\n" +
            newVersionContent;
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
    if (versionDiff < minVersionDiff && versionDiff > 0) {
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
    } else if (versionDiff >= minVersionDiff) {
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
    }
  }
}
