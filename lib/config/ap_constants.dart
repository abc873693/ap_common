class ApConstants {
  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static const PACKAGE_NAME = 'ap_common';

  static const TAG_STUDENT_PICTURE = "tag_student_picture";
  static const TAG_NEWS_PICTURE = "tag_news_picture";
  static const TAG_NEWS_ICON = "tag_news_icon";
  static const TAG_NEWS_TITLE = "tag_news_title";

  static const APP_VERSION = "app_version";
  static const NEW_VERSION_CONTENT = "new_version_content";
  static const NEW_VERSION_CONTENT_ZH = "new_version_content_zh";
  static const NEW_VERSION_CONTENT_EN = "new_version_content_en";

  static const SEMESTER_LATEST = "latest";
}
