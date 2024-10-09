import 'package:ap_common_flutter_platform/ap_common_flutter_platform.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';

export 'package:ap_common_announcement_ui/ap_common_announcement_ui.dart';
export 'package:ap_common_flutter_platform/ap_common_flutter_platform.dart';
export 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';

void registerOneForAll() {
  registerApCommonFlutter(
    ui: ApUiUtil(),
    platform: ApPlatformUtil(),
    media: ApMediaUtil(),
    platformCalendar: ApPlatformCalendarUtil(),
    notification: ApNotificationUtil(),
    appStore: ApAppStoreUtil(),
  );
  registerApCommonCore(
    preference: ApPreferenceUtil(),
  );
}
