import 'package:ap_common/models/version_info.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/dialog_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common_example/config/constants.dart';
import 'package:flutter/material.dart';

import '../utils/app_localizations.dart';

class DialogUtilsTestPage extends StatefulWidget {
  @override
  _DialogUtilsTestPageState createState() => _DialogUtilsTestPageState();
}

class _DialogUtilsTestPageState extends State<DialogUtilsTestPage> {
  AppLocalizations app;

  Day day = NotificationUtils.getDay(DateTime.now().weekday - 1);
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    app = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(app.dialogUtilTest),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '基本顯示',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Divider(height: 0.0),
          ListTile(
            onTap: () {
              DialogUtils.showNewVersionContent(
                context: context,
                appName: app.appName,
                iOSAppId: '1439751462',
                defaultUrl: 'https://www.facebook.com/NKUST.ITC/',
                githubRepositoryName: 'NKUST-ITC/NKUST-AP-Flutter',
                versionInfo: VersionInfo(
                  code: 30713,
                  isForceUpdate: false,
                  content:
                      'remoteConfig.getString(ApConstants.NEW_VERSION_CONTENT)',
                ),
              );
            },
            title: Text('新版本對話框'),
            subtitle: Text('DialogUtils.showNewVersionContent'),
          ),
          ListTile(
            onTap: () {
              DialogUtils.showUpdateContent(
                context,
                app.updateNoteContent,
              );
            },
            title: Text('版本內容對話框'),
            subtitle: Text('DialogUtils.showNewVersionContent'),
          ),
          ListTile(
            onTap: () {
              ApUtils.showAppReviewDialog(
                context,
                Constants.PLAY_STORE_URL,
              );
            },
            title: Text('App內評分'),
            subtitle: Text('ApUtils.showAppReviewDialog'),
          ),
        ],
      ),
    );
  }
}
