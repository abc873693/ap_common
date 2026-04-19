import 'dart:io';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';

class ApAppStoreUtil extends AppStoreUtil {
  @override
  Future<void> openAppReview({
    String defaultUrl = '',
  }) async {
    final InAppReview inAppReview = InAppReview.instance;
    if (!kIsWeb &&
        (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) &&
        (await inAppReview.isAvailable())) {
      inAppReview.requestReview();
    } else {
      PlatformUtil.instance.launchUrl(defaultUrl);
    }
  }

  @override
  Future<bool> get isAppTrackingApiSupported async {
    if (!kIsWeb && Platform.isIOS) {
      return await AppTrackingTransparency.trackingAuthorizationStatus ==
          TrackingStatus.notSupported;
    } else {
      return false;
    }
  }

  @override
  Future<GeneralPermissionStatus> get trackingAuthorizationStatus async =>
      switch (await AppTrackingTransparency.trackingAuthorizationStatus) {
        TrackingStatus.notDetermined => GeneralPermissionStatus.notDetermined,
        TrackingStatus.restricted => GeneralPermissionStatus.restricted,
        TrackingStatus.denied => GeneralPermissionStatus.denied,
        TrackingStatus.authorized => GeneralPermissionStatus.authorized,
        TrackingStatus.notSupported => GeneralPermissionStatus.notSupported,
      };

  @override
  Future<void> requestTrackingAuthorization() {
    return AppTrackingTransparency.requestTrackingAuthorization();
  }

  @override
  Future<InAppUpdateInfo?> checkForInAppUpdate() async {
    if (kIsWeb || !Platform.isAndroid) return null;
    try {
      final AppUpdateInfo info = await InAppUpdate.checkForUpdate();
      return InAppUpdateInfo(
        updateAvailability: switch (info.updateAvailability) {
          UpdateAvailability.updateAvailable =>
            InAppUpdateAvailability.updateAvailable,
          UpdateAvailability.updateNotAvailable =>
            InAppUpdateAvailability.updateNotAvailable,
          UpdateAvailability
                .developerTriggeredUpdateInProgress =>
            InAppUpdateAvailability.updateInProgress,
          _ => InAppUpdateAvailability.unknown,
        },
        immediateUpdateAllowed: info.immediateUpdateAllowed,
        flexibleUpdateAllowed: info.flexibleUpdateAllowed,
      );
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> performImmediateUpdate() async {
    await InAppUpdate.performImmediateUpdate();
  }

  @override
  Future<void> startFlexibleUpdate() async {
    await InAppUpdate.startFlexibleUpdate();
  }

  @override
  Future<void> completeFlexibleUpdate() async {
    await InAppUpdate.completeFlexibleUpdate();
  }
}
