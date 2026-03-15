import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';

export 'package:ap_common_core/ap_common_core.dart';
export 'package:cross_file/cross_file.dart';

export 'src/callback/general_callback.dart';
export 'src/l10n/ap_localizations.dart';
export 'src/models/general_permission_status.dart';
export 'src/ui/ap_icon.dart';
export 'src/utilities/app_store_util.dart';
export 'src/utilities/media_util.dart';
export 'src/utilities/notification_util.dart';
export 'src/utilities/platform_calendar_util.dart';
export 'src/utilities/platform_util.dart';
export 'src/utilities/ui_util.dart';

void registerApCommonFlutter({
  required UiUtil ui,
  required PlatformUtil platform,
  required MediaUtil media,
  required PlatformCalendarUtil platformCalendar,
  required NotificationUtil notification,
  required AppStoreUtil appStore,
}) {
  injector
    ..registerSingleton<UiUtil>(() => ui)
    ..registerSingleton<PlatformUtil>(() => platform)
    ..registerSingleton<MediaUtil>(() => media)
    ..registerSingleton<PlatformCalendarUtil>(() => platformCalendar)
    ..registerSingleton<NotificationUtil>(() => notification)
    ..registerSingleton<AppStoreUtil>(() => appStore);
}
