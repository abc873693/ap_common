import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_core/src/models/general_permission_status.dart';
import 'package:ap_common_flutter_core/src/models/in_app_update_info.dart';

abstract class AppStoreUtil {
  static AppStoreUtil get instance => injector.get<AppStoreUtil>();

  Future<bool> get isAppTrackingApiSupported;

  Future<GeneralPermissionStatus> get trackingAuthorizationStatus;

  Future<void> openAppReview({
    String defaultUrl = '',
  });

  Future<void> requestTrackingAuthorization();

  /// Check if an in-app update is available.
  /// Returns `null` on unsupported platforms.
  Future<InAppUpdateInfo?> checkForInAppUpdate() async => null;

  /// Perform an immediate (blocking) in-app update.
  Future<void> performImmediateUpdate() async {}

  /// Start a flexible (background download) in-app update.
  Future<void> startFlexibleUpdate() async {}

  /// Complete a flexible update after the download finishes.
  Future<void> completeFlexibleUpdate() async {}
}
