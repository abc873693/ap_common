class ApConstants {
  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static const PACKAGE_NAME = 'ap_common';

  static const TAG_STUDENT_PICTURE = "tag_student_picture";
  static const TAG_ANNOUNCEMENT_PICTURE = "tag_announcement_picture";
  static const TAG_ANNOUNCEMENT_ICON = "tag_announcement_icon";
  static const TAG_ANNOUNCEMENT_TITLE = "tag_announcement_title";

  static const APP_VERSION = "app_version";
  static const NEW_VERSION_CONTENT = "new_version_content";
  static const IS_FORCE_UPDATE = "is_force_update";
  static const NEW_VERSION_CONTENT_ZH = "new_version_content_zh";
  static const NEW_VERSION_CONTENT_EN = "new_version_content_en";

  static const SEMESTER_LATEST = "latest";
  static const CURRENT_SEMESTER_CODE = "ap_common.current_semester_code";
}
