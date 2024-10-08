import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_core/src/models/general_permission_status.dart';

abstract class AppStoreUtil {
  static AppStoreUtil get instance => injector.get<AppStoreUtil>();

  Future<bool> get isAppTrackingApiSupported;

  Future<GeneralPermissionStatus> get trackingAuthorizationStatus;

  Future<void> openAppReview({
    String defaultUrl = '',
  });

  Future<void> requestTrackingAuthorization();
}
