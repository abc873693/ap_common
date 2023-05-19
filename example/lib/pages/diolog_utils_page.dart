import 'package:ap_common/models/version_info.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/app_tracking_utils.dart';
import 'package:ap_common/utils/dialog_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common_example/config/constants.dart';
import 'package:ap_common_example/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class DialogUtilsTestPage extends StatefulWidget {
  @override
  _DialogUtilsTestPageState createState() => _DialogUtilsTestPageState();
}

class _DialogUtilsTestPageState extends State<DialogUtilsTestPage> {
  late AppLocalizations app;

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
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '基本顯示',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Divider(height: 0.0),
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
            title: const Text('新版本對話框'),
            subtitle: const Text('DialogUtils.showNewVersionContent'),
          ),
          ListTile(
            onTap: () {
              DialogUtils.showUpdateContent(
                context,
                app.updateNoteContent,
              );
            },
            title: const Text('版本內容對話框'),
            subtitle: const Text('DialogUtils.showNewVersionContent'),
          ),
          ListTile(
            onTap: () {
              ApUtils.showAppReviewDialog(
                context,
                Constants.PLAY_STORE_URL,
              );
            },
            title: const Text('App內評分'),
            subtitle: const Text('ApUtils.showAppReviewDialog'),
          ),
          ListTile(
            onTap: () {
              AppTrackingUtils.show(
                context: context,
                onTap: () async {
                  Navigator.of(context).pop();
                },
              );
            },
            title: const Text('App 追蹤'),
            subtitle: const Text('ApUtils.showAppTracking'),
          ),
        ],
      ),
    );
  }
}
