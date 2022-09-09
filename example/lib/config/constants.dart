import 'package:encrypt/encrypt.dart';

// ignore_for_file: constant_identifier_names
class Constants {
  static final Key key = Key.fromUtf8('l9r1W3wcsnJTayxCXwoFt62w1i4sQ5J9');
  static final IV iv = IV.fromUtf8('auc9OV5r0nLwjCAH');

  static const String PREF_FIRST_ENTER_APP = 'pref_first_enter_app';
  static const String PREF_CURRENT_VERSION = 'pref_current_version';
  static const String PREF_REMEMBER_PASSWORD = 'pref_remember_password';
  static const String PREF_AUTO_LOGIN = 'pref_auto_login';
  static const String PREF_USERNAME = 'pref_username';
  static const String PREF_PASSWORD = 'pref_password';

  static const String PREF_COURSE_NOTIFY = 'pref_course_notify';
  static const String PREF_BUS_NOTIFY = 'pref_bus_notify';
  static const String PREF_COURSE_NOTIFY_DATA = 'pref_course_notify_data';
  static const String PREF_BUS_NOTIFY_DATA = 'pref_bus_notify_data';
  static const String PREF_COURSE_VIBRATE = 'pref_course_vibrate';
  static const String PREF_COURSE_VIBRATE_DATA = 'pref_course_vibrate_data';
  static const String PREF_COURSE_VIBRATE_USER_SETTING =
      'pref_course_vibrate_user_setting';
  static const String PREF_DISPLAY_PICTURE = 'pref_display_picture';
  static const String PREF_PICTURE_DATA = 'pref_picture_data';
  static const String PREF_SCORE_DATA = 'pref_score_data';
  static const String PREF_COURSE_DATA = 'pref_course_data';
  static const String PREF_LEAVE_DATA = 'pref_leave_data';
  static const String PREF_SEMESTER_DATA = 'pref_semester_data';
  static const String PREF_SCHEDULE_DATA = 'pref_schedule_datae';
  static const String PREF_USER_INFO = 'pref_user_info';
  static const String PREF_BUS_RESERVATIONS_DATA =
      'pref_bus_reservevations_data';

  static const String PREF_LANGUAGE_CODE = 'pref_language_code';
  static const String PREF_THEME_CODE = 'pref_theme_code';
  static const String PREF_ICON_STYLE_CODE = 'pref_icon_style_code';
  static const String PREF_THEME_MODE_INDEX = 'pref_theme_mode_index';

  static const String PREF_AP_ENABLE = 'pref_ap_enable';
  static const String PREF_BUS_ENABLE = 'pref_bus_enable';
  static const String PREF_LEAVE_ENABLE = 'pref_leave_enable';

  static const String PREF_IS_OFFLINE_LOGIN = 'pref_is_offline_login';

  static const String SCHEDULE_DATA = 'schedule_data';
  static const String SCHEDULE_PDF_URL = 'schedule_pdf_url';
  static const String ANDROID_APP_VERSION = 'android_app_version';
  static const String IOS_APP_VERSION = 'ios_app_version';
  static const String APP_VERSION = 'app_version';
  static const String NEW_VERSION_CONTENT_ZH = 'new_version_content_zh';
  static const String NEW_VERSION_CONTENT_EN = 'new_version_content_en';
  static const String API_HOST = 'api_host';
  static const String LEAVE_CAMPUS_DATA = 'leave_campus_data';

  static const String TAG_STUDENT_PICTURE = 'tag_student_picture';
  static const String TAG_NEWS_PICTURE = 'tag_news_picture';
  static const String TAG_NEWS_ICON = 'tag_news_icon';
  static const String TAG_NEWS_TITLE = 'tag_news_title';

  static const String ANDROID_DEFAULT_NOTIFICATION_NAME =
      '@drawable/ic_stat_kuas_ap';

  // Notification ID
  static const int NOTIFICATION_BUS_ID = 100;
  static const int NOTIFICATION_COURSE_ID = 101;
  static const int NOTIFICATION_FCM_ID = 200;

  static const String FANS_PAGE_ID = '954175941266264';
  static const String PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.kuas.ap&hl=zh_TW';
}
