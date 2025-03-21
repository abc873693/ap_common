import 'package:ap_common_core/ap_common_core.dart';
import 'package:ap_common_core/injector.dart';
import 'package:ap_common_core/src/mock_util.dart';

export 'src/config/analytics_constants.dart';
export 'src/config/ap_constants.dart';
export 'src/models/announcement_data.dart';
export 'src/models/announcement_login_data.dart';
export 'src/models/ap_support_language.dart';
export 'src/models/course_data.dart';
export 'src/models/course_notify_data.dart';
export 'src/models/general_response.dart';
export 'src/models/imgur_upload_response.dart';
export 'src/models/notification_data.dart';
export 'src/models/phone_model.dart';
export 'src/models/private_cookies_manager.dart';
export 'src/models/score_data.dart';
export 'src/models/semester_data.dart';
export 'src/models/time_code.dart';
export 'src/models/user_info.dart';
export 'src/models/version_info.dart';
export 'src/utilities/analytics_utils.dart';
export 'src/utilities/crashlytics_utils.dart';
export 'src/utilities/preference_util.dart';

void registerApCommonService({
  AnalyticsUtil analytics = const MockAnalyticsUtil(),
  CrashlyticsUtil crashlytics = const MockCrashlyticsUtil(),
}) {
  injector
    ..registerSingleton<AnalyticsUtil>(() => analytics)
    ..registerSingleton<CrashlyticsUtil>(() => crashlytics);
}

void registerApCommonCore({
  required PreferenceUtil preference,
}) {
  injector.registerSingleton<PreferenceUtil>(() => preference);
}
