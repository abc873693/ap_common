import 'dart:io';

import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';

class ApAppStoreUtil extends AppStoreUtil {
  static ApAppStoreUtil get instance => injector.get<ApAppStoreUtil>();

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
}
