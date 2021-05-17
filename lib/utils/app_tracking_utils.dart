import 'dart:io';

import 'package:ap_common/l10n/l10n.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/widgets/default_dialog.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'package:app_tracking_transparency/app_tracking_transparency.dart';

class AppTrackingUtils {
  static Future<bool> get isSupportAppTrackingApi async {
    if (!kIsWeb && Platform.isIOS) {
      return await AppTrackingTransparency.trackingAuthorizationStatus ==
          TrackingStatus.notSupported;
    } else {
      return false;
    }
  }

  static Future<TrackingStatus> get trackingAuthorizationStatus async {
    return AppTrackingTransparency.trackingAuthorizationStatus;
  }

  static void show({
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    final ap = ApLocalizations.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: DefaultDialog(
          title: ap.appTrackingDialogTitle,
          contentWidget: Column(
            children: [
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
                children: [
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
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
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
          actionText: ap.continueToUse,
          actionFunction: onTap ??
              () async {
                try {
                  if (await AppTrackingTransparency
                          .trackingAuthorizationStatus ==
                      TrackingStatus.notDetermined) {
                    await AppTrackingTransparency
                        .requestTrackingAuthorization();
                  }
                  Navigator.of(context).pop();
                } on PlatformException {
                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  rethrow;
                }
              },
        ),
      ),
    );
  }
}
