import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTrackingUtils {
  static void show({
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    final ApLocalizations ap = ApLocalizations.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: DefaultDialog(
          title: ap.appTrackingDialogTitle,
          contentWidget: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  ap.appTrackingDialogContent,
                  style: TextStyle(
                    color: ApTheme.of(context).grey,
                    height: 1.3,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.analytics_outlined,
                      color: ApTheme.of(context).grey,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        ap.analyticsDescription,
                        style: TextStyle(
                          color: ApTheme.of(context).grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.bug_report_outlined,
                      color: ApTheme.of(context).grey,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        ap.crashReportDescription,
                        style: TextStyle(
                          color: ApTheme.of(context).grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actionText: ap.continueToUse,
          actionFunction: onTap ??
              () async {
                try {
                  if (await AppStoreUtil.instance.trackingAuthorizationStatus ==
                      GeneralPermissionStatus.notDetermined) {
                    await AppStoreUtil.instance.requestTrackingAuthorization();
                  }
                  //ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                } on PlatformException {
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                } catch (e) {
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  rethrow;
                }
              },
        ),
      ),
    );
  }
}
