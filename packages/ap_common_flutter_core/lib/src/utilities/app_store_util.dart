import 'package:ap_common_core/injector.dart';

abstract class AppStoreUtil {
  static AppStoreUtil get instance => injector.get<AppStoreUtil>();

  Future<void> openAppReview({
    String defaultUrl = '',
  });
}
