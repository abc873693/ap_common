import 'dart:io';

import 'package:ap_common/resources/ap_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:ap_common/models/ap_support_language.dart';

class ApLocalizations {
  ApLocalizations(Locale locale) {
    ApLocalizations.locale = locale;
  }

  static Locale locale;

  static ApLocalizations instance;

  Map get _vocabularies {
    return _localizedValues[locale.languageCode] ?? _localizedValues['en'];
  }

  static get dateTimeLocale {
    if (locale.languageCode.contains('zh'))
      return 'zh-TW';
    else
      return 'en-US';
  }

  String get iconText {
    switch (ApIcon.code) {
      case ApIcon.FILLED:
        return filled;
      case ApIcon.OUTLINED:
      default:
        return outlined;
    }
  }

  List<String> get weekdaysCourse => [
        mon,
        tue,
        wed,
        thu,
        fri,
        sat,
        sun,
      ];

  List<String> get weekdays => [
        sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
      ];

  String get home => _vocabularies['home'];

  String get updateNoteTitle => _vocabularies['update_note_title'];

  String get ok => _vocabularies['ok'];

  String get somethingError => _vocabularies['something_error'];

  String get username => _vocabularies['id_hint'];

  String get password => _vocabularies['password_hint'];

  String get remember => _vocabularies['remember_password'];

  String get login => _vocabularies['login'];

  String get doNotEmpty => _vocabularies['do_not_empty'];

  String get loginFail => _vocabularies['login_fail'];

  String get bus => _vocabularies['bus'];

  String get course => _vocabularies['course'];

  String get score => _vocabularies['score'];

  String get logining => _vocabularies['login_ing'];

  String get schoolInfo => _vocabularies['school_info'];

  String get about => _vocabularies['about'];

  String get settings => _vocabularies['settings'];

  String get notifications => _vocabularies['notifications'];

  String get phones => _vocabularies['phones'];

  String get events => _vocabularies['events'];

  String get clickToRetry => _vocabularies['click_to_retry'];

  String get aboutAuthorTitle => _vocabularies['about_author_title'];

  String get aboutAuthorContent => _vocabularies['about_author_content'];

  String get aboutUsContent => _vocabularies['about_us'];

  String get aboutRecruitTitle => _vocabularies['about_recruit_title'];

  String get aboutRecruitContent => _vocabularies['about_recruit_content'];

  String get aboutItcTitle => _vocabularies['about_itc_title'];

  String get aboutItcContent => _vocabularies['about_itc_content'];

  String get aboutContactUsTitle => _vocabularies['about_contact_us'];

  String get aboutOpenSourceTitle => _vocabularies['about_open_source_title'];

  String get back => _vocabularies['back'];

  String get people => _vocabularies['people'];

  String get busReserve => _vocabularies['bus_reserve'];

  String get busReservations => _vocabularies['bus_reservations'];

  String get determine => _vocabularies['determine'];

  String get jiangong => _vocabularies['jiangong'];

  String get yanchao => _vocabularies['yanchao'];

  String get unknown => _vocabularies['unknown'];

  String get campus => _vocabularies['campus'];

  String get reserve => _vocabularies['reserve'];

  String get reserved => _vocabularies['reserved'];

  String get canNotReserve => _vocabularies['can_not_reserve'];

  String get specialBus => _vocabularies['special_bus'];

  String get trialBus => _vocabularies['trial_bus'];

  String get cancel => _vocabularies['cancel'];

  String get busReserveSuccess => _vocabularies['bus_reserve_success'];

  String get busCancelReserve => _vocabularies['bus_cancel_reserve'];

  String get busCancelReserveSuccess =>
      _vocabularies['bus_cancel_reserve_success'];

  String get busCancelReserveFail => _vocabularies['bus_cancel_reserve_fail'];

  String get busReservationEmpty => _vocabularies['bus_no_reservation'];

  String get busEmpty => _vocabularies['bus_no_bus'];

  String get busReserveConfirmTitle =>
      _vocabularies['bus_reserve_confirm_title'];

  String get busReserveFailTitle => _vocabularies['bus_reserve_fail_title'];

  String get busReserveDate => _vocabularies['bus_reserve_date'];

  String get busReserveLocation => _vocabularies['bus_reserve_location'];

  String get busReserveTime => _vocabularies['bus_reserve_time'];

  String get iKnow => _vocabularies['i_know'];

  String get busCancelReserveConfirmContent1 =>
      _vocabularies['bus_cancel_reserve_confirm_content1'];

  String get busCancelReserveConfirmContent2 =>
      _vocabularies['bus_cancel_reserve_confirm_content2'];

  String get busCancelReserveConfirmContent3 =>
      _vocabularies['bus_cancel_reserve_confirm_content3'];

  String get busReserveCancelDate => _vocabularies['bus_reserve_cancel_date'];

  String get busReserveCancelLocation =>
      _vocabularies['bus_reserve_cancel_location'];

  String get busReserveCancelTime => _vocabularies['bus_reserve_cancel_time'];

  String get courseEmpty => _vocabularies['course_no_course'];

  String get picksSemester => _vocabularies['pick_semester'];

  String get courseDialogName => _vocabularies['course_dialog_name'];

  String get courseDialogProfessor => _vocabularies['course_dialog_professor'];

  String get courseDialogLocation => _vocabularies['course_dialog_location'];

  String get courseDialogTime => _vocabularies['course_dialog_time'];

  String get courseDialogTitle => _vocabularies['course_dialog_title'];

  String get courseClickHint => _vocabularies['courseClickHint'];

  String get mon => _vocabularies['mon'];

  String get tue => _vocabularies['tue'];

  String get wed => _vocabularies['wed'];

  String get thu => _vocabularies['thu'];

  String get fri => _vocabularies['fri'];

  String get sat => _vocabularies['sat'];

  String get sun => _vocabularies['sun'];

  String get monday => _vocabularies['monday'];

  String get tuesday => _vocabularies['tuesday'];

  String get wednesday => _vocabularies['wednesday'];

  String get thursday => _vocabularies['thursday'];

  String get friday => _vocabularies['friday'];

  String get saturday => _vocabularies['saturday'];

  String get sunday => _vocabularies['sunday'];

  String get units => _vocabularies['units'];

  String get courseHours => _vocabularies['courseHours'];

  String get fromJiangong => _vocabularies['from_jiangong'];

  String get fromYanchao => _vocabularies['from_yanchao'];

  String get scoreEmpty => _vocabularies['score_no_score'];

  String get subject => _vocabularies['subject'];

  String get midtermScoreTitle => _vocabularies['midtermScoreTitle'];

  String get semesterScoreTitle => _vocabularies['semesterScoreTitle'];

  String get midtermScore => _vocabularies['midtermScore'];

  String get finalScore => _vocabularies['finalScore'];

  String get generalScore => _vocabularies['generalScore'];

  String get semesterScore => _vocabularies['semesterScore'];

  String get conductScore => _vocabularies['conduct_score'];

  String get creditsTakenEarned => _vocabularies['creditsTakenEarned'];

  String get credits => _vocabularies['credits'];

  String get average => _vocabularies['average'];

  String get rank => _vocabularies['rank'];

  String get classRank => _vocabularies['classRank'];

  String get departmentRank => _vocabularies['departmentRank'];

  String get classNumberOfPeople => _vocabularies['classNumberOfPeople'];

  String get percentage => _vocabularies['percentage'];

  String get userInfo => _vocabularies['user'];

  String get educationSystem => _vocabularies['education_system'];

  String get department => _vocabularies['department'];

  String get studentClass => _vocabularies['student_class'];

  String get studentId => _vocabularies['student_id'];

  String get studentNameCht => _vocabularies['student_name_cht'];

  String get notificationItem => _vocabularies['notification_item'];

  String get otherInfo => _vocabularies['other_info'];

  String get otherSettings => _vocabularies['other_settings'];

  String get environmentSettings => _vocabularies['environment_settings'];

  String get headPhotoSetting => _vocabularies['head_photo_setting'];

  String get headPhotoSettingSubTitle =>
      _vocabularies['head_photo_setting_sub_title'];

  String get courseNotify => _vocabularies['course_notify'];

  String get courseNotifySubTitle => _vocabularies['course_notify_sub_title'];

  String get courseVibrate => _vocabularies['course_vibrate'];

  String get busNotify => _vocabularies['bus_notify'];

  String get busNotifySubTitle => _vocabularies['bus_notify_sub_title'];

  String get feedback => _vocabularies['feedback'];

  String get feedbackViaFacebook => _vocabularies['feedback_via_facebook'];

  String get donateTitle => _vocabularies['donate_title'];

  String get donateContent => _vocabularies['donate_content'];

  String get donateError => _vocabularies['donate_error'];

  String get appVersion => _vocabularies['app_version'];

  String get updateContent {
    if (Platform.isAndroid)
      return updateAndroidContent;
    else if (Platform.isIOS)
      return updateIOSContent;
    else
      return _vocabularies['update_content'];
  }

  String get updateAndroidContent => _vocabularies['update_android_content'];

  String get updateIOSContent => _vocabularies['update_ios_content'];

  String get updateTitle => _vocabularies['update_title'];

  String get update => _vocabularies['update'];

  String get functionNotOpen => _vocabularies['function_not_open'];

  String get betaFunction => _vocabularies['beta_function'];

  String get easterEggJuke => _vocabularies['easter_egg_juke'];

  String get skip => _vocabularies['skip'];

  String get shareTo => _vocabularies['share_to'];

  String get sendFrom => _vocabularies['send_from'];

  String get timeoutMessage => _vocabularies['timeout_message'];

  String get noInternet => _vocabularies['no_internet'];

  String get tokenExpiredTitle => _vocabularies['token_expired_title'];

  String get tokenExpiredContent => _vocabularies['token_expired_content'];

  String get busFailInfinity => _vocabularies['bus_fail_infinity'];

  String get reserving => _vocabularies['reserving'];

  String get canceling => _vocabularies['canceling'];

  String get logout => _vocabularies['logout'];

  String get announcements => _vocabularies['news'];

  String get logoutCheck => _vocabularies['logout_check'];

  String get courseInfo => _vocabularies['course_info'];

  String get autoLogin => _vocabularies['auto_login'];

  String get calculateUnits => _vocabularies['calculate_units'];

  String get requiredUnits => _vocabularies['required_units'];

  String get electiveUnits => _vocabularies['elective_units'];

  String get otherUnits => _vocabularies['other_units'];

  String get unitsTotal => _vocabularies['units_total'];

  String get semester => _vocabularies['semester'];

  String get beginCalculate => _vocabularies['begin_calculate'];

  String get calculateUnitsContent => _vocabularies['calculate_units_content'];

  String get generalEductionCourse => _vocabularies['general_eduction_course'];

  String get calculating => _vocabularies['calculating'];

  String get canNotUseFeature => _vocabularies['can_not_use_feature'];

  String get busNotifyHint => _vocabularies['bus_notify_hint'];

  String get busNotifyContent => _vocabularies['bus_notify_content'];

  String get busNotifyJiangong => _vocabularies['bus_notify_jiangong'];

  String get busNotifyYanchao => _vocabularies['bus_notify_yanchao'];

  String get loading => _vocabularies['loading'];

  String get courseNotifyHint => _vocabularies['course_notify_hint'];

  String get courseNotifyContent => _vocabularies['course_notify_content'];

  String get courseNotifyUnknown => _vocabularies['course_notify_unknown'];

  String get courseNotifyEmpty => _vocabularies['course_notify_empty'];

  String get courseNotifyError => _vocabularies['course_notify_error'];

  String get cancelNotifySuccess => _vocabularies['cancel_notify_success'];

  String get callPhoneTitle => _vocabularies['call_phone_title'];

  String get callPhoneContent => _vocabularies['call_phone_content'];

  String get callPhone => _vocabularies['call_phone'];

  String get addCalendarContent => _vocabularies['add_cal_content'];

  String get calendarAppNotFound => _vocabularies['calendar_app_not_found'];

  String get addSuccess => _vocabularies['add_success'];

  String get leave => _vocabularies['leave'];

  String get leaveNight => _vocabularies['leave_night'];

  String get leaveEmpty => _vocabularies['leave_no_leave'];

  String get date => _vocabularies['date'];

  String get leaveApply => _vocabularies['leave_apply'];

  String get leaveRecords => _vocabularies['leave_records'];

  String get leaveContent => _vocabularies['leave_content'];

  String get leaveSheetId => _vocabularies['leave_sheet_id'];

  String get instructorsComment => _vocabularies['instructors_comment'];

  String get loadOfflineData => _vocabularies['load_offline_data'];

  String get offlineCourse => _vocabularies['offline_course'];

  String get busRule => _vocabularies['bus_rule'];

  String get platformError => _vocabularies['platform_error'];

  String get reserveDeadline => _vocabularies['reserve_deadline'];

  String get choseLanguageTitle => _vocabularies['chose_language_title'];

  String get language => _vocabularies['language'];

  String get systemLanguage => _vocabularies['system_language'];

  String get traditionalChinese => _vocabularies['traditional_chinese'];

  String get english => _vocabularies['english'];

  String get ratingDialogTitle => _vocabularies['rating_dialog_title'];

  String get ratingDialogContent => _vocabularies['rating_dialog_content'];

  String get later => _vocabularies['later'];

  String get rateNow => _vocabularies['rate_now'];

  String get offlineLogin => _vocabularies['offline_login'];

  String get noOfflineLoginData => _vocabularies['no_offline_login_data'];

  String get offlineLoginPasswordError =>
      _vocabularies['offline_login_password_error'];

  String get noOfflineData => _vocabularies['no_offline_data'];

  String get offlineMode => _vocabularies['offline_mode'];

  String get offlineScore => _vocabularies['offline_score'];

  String get offlineBusReservations =>
      _vocabularies['offline_bus_reservations'];

  String get offlineLeaveData => _vocabularies['offline_leave_data'];

  String get noData => _vocabularies['noData'];

  String get graduationCheckChecklistSummary =>
      _vocabularies['graduationCheckChecklistSummary'];

  String get contactFansPage => _vocabularies['contactFansPage'];

  String get newsRuleTitle => _vocabularies['newsRuleTitle'];

  String get newsRuleDescription1 => _vocabularies['newsRuleDescription1'];

  String get newsRuleDescription2 => _vocabularies['newsRuleDescription2'];

  String get newsRuleDescription3 => _vocabularies['newsRuleDescription3'];

  String get theme => _vocabularies['theme'];

  String get systemTheme => _vocabularies['systemTheme'];

  String get dark => _vocabularies['dark'];

  String get light => _vocabularies['light'];

  String get iconStyle => _vocabularies['iconStyle'];

  String get filled => _vocabularies['filled'];

  String get outlined => _vocabularies['outlined'];

  String get searchUsername => _vocabularies['searchUsername'];

  String get search => _vocabularies['search'];

  String get name => _vocabularies['name'];

  String get id => _vocabularies['id'];

  String get searchResult => _vocabularies['searchResult'];

  String get autoFill => _vocabularies['autoFill'];

  String get firstLoginHint => _vocabularies['firstLoginHint'];

  String get searchStudentIdFormat => _vocabularies['searchStudentIdFormat'];

  String get searchStudentIdError => _vocabularies['searchError'];

  String get midtermAlerts => _vocabularies['midtermAlerts'];

  String get midtermAlertsEmpty => _vocabularies['midtermAlertsEmpty'];

  String get midtermAlertsContent => _vocabularies['midtermAlertsContent'];

  String get rewardAndPenalty => _vocabularies['rewardAndPenalty'];

  String get rewardAndPenaltyEmpty => _vocabularies['rewardAndPenaltyEmpty'];

  String get rewardAndPenaltyContent =>
      _vocabularies['rewardAndPenaltyContent'];

  String get campusNotSupport => _vocabularies['campusNotSupport'];

  String get userNotSupport => _vocabularies['userNotSupport'];

  String get notLogin => _vocabularies['notLogin'];

  String get notLoginHint => _vocabularies['notLoginHint'];

  String get addDate => _vocabularies['addDate'];

  String get tutor => _vocabularies['tutor'];

  String get leaveType => _vocabularies['leaveType'];

  String get reason => _vocabularies['reason'];

  String get delayReason => _vocabularies['delayReason'];

  String get submit => _vocabularies['submit'];

  String get leaveSubmitUploadHint => _vocabularies['leaveSubmitUploadHint'];

  String get confirm => _vocabularies['confirm'];

  String get teacher => _vocabularies['teacher'];

  String get pickTeacher => _vocabularies['pickTeacher'];

  String get leaveProof => _vocabularies['leaveProof'];

  String get pleasePick => _vocabularies['pleasePick'];

  String get pleasePickDateAndSection =>
      _vocabularies['pleasePickDateAndSection'];

  String get leaveSubmitSuccess => _vocabularies['leaveSubmitSuccess'];

  String get leaveDelayHint => _vocabularies['leaveDelayHint'];

  String get leaveProofHint => _vocabularies['leaveProofHint'];

  String get imageCompressHint => _vocabularies['imageCompressHint'];

  String get imageTooBigHint => _vocabularies['imageTooBigHint'];

  String get leaveDateAndSection => _vocabularies['leaveDateAndSection'];

  String get none => _vocabularies['none'];

  String get leaveSubmit => _vocabularies['leaveSubmit'];

  String get closeAppTitle => _vocabularies['closeAppTitle'];

  String get closeAppHint => _vocabularies['closeAppHint'];

  String get leaveSubmitFail => _vocabularies['leaveSubmitFail'];

  String get loginSuccess => _vocabularies['loginSuccess'];

  String get retry => _vocabularies['retry'];

  String get title => _vocabularies['title'];

  String get description => _vocabularies['description'];

  String get imageUrl => _vocabularies['imageUrl'];

  String get url => _vocabularies['url'];

  String get expireTime => _vocabularies['expireTime'];

  String get weight => _vocabularies['weight'];

  String get newsContentFormat => _vocabularies['newsContentFormat'];

  String get deleteNewsTitle => _vocabularies['deleteNewsTitle'];

  String get deleteNewsContent => _vocabularies['deleteNewsContent'];

  String get deleteSuccess => _vocabularies['deleteSuccess'];

  String get updateSuccess => _vocabularies['updateSuccess'];

  String get formatError => _vocabularies['formatError'];

  String get newsExpireTimeHint => _vocabularies['newsExpireTimeHint'];

  String get setNoExpireTime => _vocabularies['setNoExpireTime'];

  String get noExpiration => _vocabularies['noExpiration'];

  String get showSearchButton => _vocabularies['showSearchButton'];

  String get email => _vocabularies['email'];

  String get schoolNavigation => _vocabularies['schoolNavigation'];

  String get schoolMap => _vocabularies['schoolMap'];

  String get birthMonth => _vocabularies['birthMonth'];

  String get birthDay => _vocabularies['birthDay'];

  String get idCardLastCode => _vocabularies['idCardLastCode'];

  String get captcha => _vocabularies['captcha'];

  String get usernameError => _vocabularies['usernameError'];

  String get captchaError => _vocabularies['captchaError'];

  String get passwordError => _vocabularies['passwordError'];

  String get unknownError => _vocabularies['unknownError'];

  String get onlySupportInSchool => _vocabularies['onlySupportInSchool'];

  String get admissionGuide => _vocabularies['admissionGuide'];

  String get share => _vocabularies['share'];

  String get printing => _vocabularies['printing'];

  String get changeEmail => _vocabularies['changeEmail'];

  String get done => _vocabularies['done'];

  String get addToCalendar => _vocabularies['add_to_calendar'];

  String get apiSeverError => _vocabularies['api_server_error'];

  String get schoolSeverError => _vocabularies['school_server_error'];

  String get roomList => _vocabularies['room_list'];

  String get emptyClassroomSearch => _vocabularies['empty_classroom_search'];

  String get classroomCourseTableSearch =>
      _vocabularies['classroom_coursetable_search'];

  String get cancelAllNotify => _vocabularies['cancelAllNotify'];

  String get cancelAllNotifySubTitle =>
      _vocabularies['cancelAllNotifySubTitle'];

  String get exportCourseTable => _vocabularies['exportCourseTable'];

  String get grandPermissionFail => _vocabularies['grandPermissionFail'];

  String get exportCourseTableSuccess =>
      _vocabularies['exportCourseTableSuccess'];

  String get apply => _vocabularies['apply'];

  String get myApplications => _vocabularies['myApplications'];

  String get reviewState => _vocabularies['reviewState'];

  String get waitingForReview => _vocabularies['waitingForReview'];

  String get reviewApproval => _vocabularies['reviewApproval'];

  String get reviewReject => _vocabularies['reviewReject'];

  String get reviewDescription => _vocabularies['reviewDescription'];

  String get applicationSubmitSuccess => _vocabularies['applicationSubmitSuccess'];

  static ApLocalizations of(BuildContext context) {
    return instance =
        Localizations.of<ApLocalizations>(context, ApLocalizations);
  }

  static String dioError(BuildContext context, DioError dioError) {
    var ap = ApLocalizations.of(context);
    switch (dioError.type) {
      case DioErrorType.DEFAULT:
        return ap.noInternet;
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
        return ap.timeoutMessage;
        break;
      case DioErrorType.RESPONSE:
        return dioError.message;
        break;
      case DioErrorType.CANCEL:
      default:
        return null;
    }
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'update_note_title': 'Update Notes',
      'home': 'Home',
      'splash_content': '我們全都包了\n只剩下學校不包我們',
      'share': 'Share',
      'teacher_confirm_title': 'Are you a teacher?',
      'teacher_confirm_content': 'This App only for students!',
      'continue_to_use': 'Continue',
      'logout': 'Logout',
      'click_to_view': 'View',
      'login_success': 'Login success,\nclick menu to view.',
      'something_error': 'Error Occurred.',
      'timeout_message': 'Try again later, Connection Timeout',
      'login_first': 'Please login',
      'logout_check': 'Are you sure you want to log out?',
      'login': 'Login',
      'dot_ap': 'AP',
      'dot_leave': 'Leave',
      'dot_bus': 'Bus',
      'schedule': 'Events',
      'loading': 'Loading',
      'id_hint': 'Student ID',
      'password_hint': 'Password',
      'remember_password': 'Remember',
      'auto_login': 'Auto login',
      'version': 'v.%s',
      'login_ing': 'Logging...',
      'call_phone_title': 'Call this number',
      'call_phone_content': 'Are you sure to call \"%s\"?',
      'call_phone': 'Call',
      'determine': 'Yes',
      'cancel': 'No',
      'add_cal_content': 'Are you sure to add \"%s\" to your calendar?',
      'click_to_retry': 'An error occurred, click to retry',
      'bus_pick_date': 'Chosen Date: %s',
      'bus_not_pick_date': 'Chosen Date',
      'bus_count" formatted="false': '(%s / %s)',
      'back': 'Back',
      'people': 'PX',
      'bus_reserve': 'Bus Reservation',
      'bus_reservations': 'Bus Record',
      'bus_cancel_reserve': 'Cancel Bus Reservation',
      'bus_reserve_confirm_title': 'Reserve this bus?',
      'bus_reserve_confirm_content" formatted="false':
          'Are you sure to reserve a seat from %s at %s ?',
      'bus_cancel_reserve_confirm_title': '<b>Cancel</b> this reservation?',
      'bus_cancel_reserve_confirm_content':
          'Are you sure to cancel a seat from %s at %s ?',
      'bus_cancel_reserve_confirm_content1':
          'Are you sure to cancel a seat from ',
      'bus_cancel_reserve_confirm_content2': ' to ',
      'bus_cancel_reserve_confirm_content3': ' ?',
      'bus_from_jiangong': 'JianGong to YanChao',
      'bus_from_yanchao': 'YanChao to JianGong',
      'bus_reserve_date': 'Date',
      'bus_reserve_location': 'Location',
      'bus_reserve_time': 'Time',
      'unknown': 'Unknown',
      'campus': ' campus',
      'reserve': 'Reserve',
      'reserved': 'Reserved',
      'can_not_reserve': 'Can\'t reserve',
      'special_bus': 'Special Bus',
      'trial_bus': 'Trial Bus',
      'bus_reserve_success': 'Successfully Reserved!',
      'bus_reserve_cancel_date': 'Date',
      'bus_reserve_cancel_location': 'Location',
      'bus_reserve_cancel_time': 'Time',
      'bus_cancel_reserve_success': 'Successfully Canceled!',
      'bus_cancel_reserve_fail': 'Fail Canceled',
      'bus_no_reservation':
          'Oops! You haven\'t reserved any bus~\n Ride public transport to save the Earth \uD83D\uDE0B',
      'bus_no_bus':
          'Oops! No bus today~\n Please choose another date \uD83D\uDE0B',
      'course_no_course':
          'Oops! No class for this semester~\n Please choose another semester \uD83D\uDE0B',
      'bus_reserve_fail_title': 'Oops Book Fail',
      'i_know': 'Got it',
      'ok': 'OK',
      'course_dialog_messages" formatted="false':
          'Class：%s\nProfessor：%s\nLocation：%s\nTime：%s',
      'course_dialog_name': 'Class',
      'course_dialog_professor': 'Professor',
      'course_dialog_location': 'Location',
      'course_dialog_time': 'Time',
      'course_dialog_title': 'Class Info',
      'course_holiday': 'Rotate Screen to see weekend schedule %s',
      'courseClickHint': 'Click subject show more.',
      'no_internet': 'No internet connection',
      'setting_internet': 'Internet Settings',
      'score_no_score':
          'Oops! No record for this semester~\nPlease choose another semester \uD83D\uDE0B',
      'subject': 'Subject',
      'midtermScoreTitle': 'Midterm',
      'semesterScoreTitle': 'Final',
      'midtermScore': 'Midterm Score',
      'finalScore': 'Final Score',
      'generalScore': 'General Score',
      'semesterScore': 'Semester Score',
      'conduct_score': 'Conduct Score',
      'creditsTakenEarned': 'Credits Taken/Earned',
      'credits': 'Credits',
      'average': 'Average',
      'rank': 'Rank',
      'classRank': 'Class Rank',
      'departmentRank': 'Department Rank',
      'totalClassmates': 'Total Classmates',
      'percentage': 'Top % in Class',
      'leave_night': 'Rotate screen to see night school absent record',
      'leave_no_leave':
          'Oops! No absent record for this semester~\nPlease choose another semester \uD83D\uDE0B',
      'token_expired_title': 'Re-login Required',
      'token_expired_content': 'Cookie has expired, please re-login!',
      'update_content': 'Update available for %s!',
      'update_android_content': 'Update available for %s!',
      'update_ios_content': 'Update available for %s!',
      'update_title': 'Updated',
      'update': 'Update',
      'function_not_open': 'Coming Soon~\nDonate to use this feature now!',
      'beta_function':
          'This is a beta version, please report a bug if an error occurred!',
      'bus_not_pick':
          'You have not chosen a date!\n Please choose a date first %s',
      'easter_egg_juke': 'This is not an easter egg',
      'skip': 'Skip',
      'share_to': 'Share to…',
      'send_from': 'Sent from KUAS AP Android',
      'donate_title': 'Donate',
      'donate_content': 'Help and support the programmer\nto use new features!',
      'bus_notify_hint':
          'Reminder will pop up 30 mins before reserved bus !\nIf you reserved or canceled the seat via website, please restart the app.',
      'bus_notify_content" formatted="false':
          'You\'ve got a bus departing at %s from %s!',
      'bus_notify_jiangong': 'JianGong',
      'bus_notify_yanchao': 'YanChao',
      'course_vibrate_hint':
          'Will turn on silent mode during class, turn back to normal mode after class!',
      'course_vibrate_permission': 'Need "Do Not Disturb access" to auto mute.',
      'course_notify_hint': 'Reminder will pop up 10 mins before class starts!',
      'course_notify_content': 'Class %s will be at room %s!',
      'course_notify_unknown': 'Outerspace~',
      'course_notify_empty': 'Oops! No class need notify~',
      'course_notify_error': 'Oops! Something was wrong~',
      'cancel_notify_success': 'Cancel Success',
      'calendar_app_not_found': 'Can\'t found any calendar apps.',
      'go_to_settings': 'Settings',
      'notifications': 'News',
      'phones': 'Tel no.',
      'events': 'Events',
      'education_system': 'Scheme',
      'department': 'Department',
      'student_class': 'Class',
      'student_id': 'Student ID',
      'student_name_cht': 'Name',
      'notification_item': 'Notification',
      'other_info': 'Other',
      'other_settings': 'Settings',
      'environment_settings': 'Environment',
      'head_photo_setting': 'Show Photo',
      'head_photo_setting_sub_title': 'Side menu shows the photo sticker',
      'course_notify': 'Class Reminder',
      'course_notify_sub_title':
          'Reminder 10 mins before class starts, click item to cancel.',
      'course_vibrate': 'Silent Mode During Class',
      'bus_notify': 'Bus Reservation Reminder',
      'bus_notify_sub_title': 'Reminder 30 mins before reserved bus',
      'feedback': 'Suggestions',
      'feedback_via_facebook': 'Message to Facebook Page',
      'app_version': 'App Version',
      'about_detail':
          'The best KUAS Campus App\nKUAS AP\n\nAre you afreshman?\nDon\'t know about school info, telephone numbers, or up coming events?\nBeenhere a few years?\nHave checking class schedule, report card and reserving bus seatsdrove you crazy?\n\nNo more, no more worries, anymore!\n\nKUAS AP lets no matter old or newfellow\nhave control over your life in KUAS!\n\nFrom checking class schedule, report card toyour absence records!\nPlus reserving/canceling bus seats with newest school feeds!\n\n\n\nMuch Simple, Many Convenient, Very instinct, wow!\n\n☆FABULOUS☆',
      'about_author_title': 'Made by',
      'about_author_content':
          '高科校務通v1 & v2\n呂紹榕(Louie Lu), 姜尚德(JohnThunder), \nregisterAutumn, 詹濬鍵(Evans), \n陳建霖(HearSilent), 陳冠蓁, 徐羽柔\n高科校務通v3\n房志剛(Rainvisitor),林義翔(takidog)\n林鈺軒(Lin YuHsuan),周鈺禮(Gary)\n中山校務通\n房志剛(Rainvisitor),胡智強（JohnHuCC)\n台科校務通\n房志剛(Rainvisitor),林義翔(takidog)\n文藻校務通\n林義翔(takidog),房志剛(Rainvisitor)',
      'about_us':
          '“Ask not why nobody is doing this. You are \'nobody\'.”\n\nWe did this cause no one did it.\nWe created KUAS Wifi Login, KUASAP and KUAS Gourmet, Course Selection Sim, etc&#8230;\nTo bring convenience to everyone\'s on campus!',
      'about_recruit_title': 'We Need You !',
      'about_recruit_content':
          'If you\'re experienced in Objective-C, Swift, Java, Kotlin, Dart or you\'re interested in Coding!\n\nMessage us at our Facebook fanpage!\nYour code might one day be operating in everyone\'s hands~',
      'about_itc_content':
          'In year 2014,\nwe founded KUAS Information Technology Club!\n\nIf you\'re enthusiastic or drawn to our projects, join our classes and talks or come by to chat!',
      'about_itc_title': 'NKUST IT Club',
      'about_contact_us': 'Contact Us',
      'about_open_source_title': 'Open Source License',
      'open_drawer': 'Open Menu',
      'close_drawer': 'Close Menu',
      'news': 'News',
      'offline_course': 'Offline Class Schedule',
      'course_info': 'Course info',
      'course': 'Class Schedule',
      'score': 'Report Card',
      'leave': 'Absent System',
      'bus': 'Bus Reservation',
      'simcourse': 'Course Selection Sim',
      'school_info': 'School Info',
      'user': 'Personal Info',
      'about': 'About Us',
      'settings': 'Settings',
      'guest': 'Guest',
      'tap_here_to_login': 'Tap to Login',
      'pick_semester': 'Choose Semester',
      'enter_username_hint': 'Please enter your ID',
      'enter_password_hint': 'Please enter your password',
      'check_login_hint': 'Check your username and password then retry',
      'from_jiangong': 'From JianGong',
      'from_yanchao': 'From YanChao',
      'lorem_title': 'Lorem ipsum',
      'lorem_sentence': 'Lorem ipsum dolor sit amet.',
      'lorem_paragraph':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'lorem_number': '123',
      'lorem_date': '2015&#8211;09&#8211;06',
      'lorem_time': '09:20',
      'lorem_bus_count': '(1 / 999)',
      'lorem_phone': '(01) 234&#8211;5678',
      'lorem_semester': '104學年度第1學期',
      'mon': 'Mon.',
      'tue': 'Tue.',
      'wed': 'Wed.',
      'thu': 'Thu.',
      'fri': 'Fri.',
      'sat': 'Sat.',
      'sun': 'Sun.',
      'monday': 'Mon',
      'tuesday': 'Tue',
      'wednesday': 'Wed',
      'thursday': 'Thu',
      'friday': 'Fri',
      'saturday': 'Sat',
      'sunday': 'Sun',
      'units': 'Units',
      'courseHours': 'Hours',
      'do_not_empty': 'Don\'t Empty',
      'login_fail':
          'student id or password error or this student id is not available',
      'bus_fail_infinity': 'Bus system perhaps broken!!!',
      'reserving': 'Reserving...',
      'canceling': 'Canceling...',
      'calculating': 'Calculating...',
      'calculate_units': 'Calculate Units',
      'begin_calculate': 'Begin Calculate',
      'calculate_units_content': 'Calculation is for reference only',
      'general_eduction_course': 'General education course',
      'can_not_use_feature':
          'This account can\'t use this feature or school system happend error',
      'add_success': 'Add Success',
      'date': 'Date',
      'leave_apply': 'Absent apply',
      'leave_records': 'Absent records',
      'leave_content': 'Absent Content',
      'leave_sheet_id': 'Sheet id',
      'instructors_comment': 'Comment',
      'load_offline_data': 'Load offline data',
      'reserve_deadline': 'Reserve Deadline',
      'bus_rule': 'Bus Rule',
      'platform_error': 'Current platform can\'t use this feature.',
      'language': 'Language',
      'chose_language_title': 'Language',
      'system_language': 'System Language',
      'traditional_chinese': '繁體中文',
      'english': 'English',
      'rating_dialog_title': 'Rate App',
      'rating_dialog_content':
          'Do you like NKUST APP?\nPlease write a comment and rating on the store\nThis is our motivation!',
      'later': 'LATER',
      'rate_now': 'RATE NOW',
      'offline_login': 'Offline Login',
      'no_offline_login_data':
          'No Offline login data, please login at least once.',
      'offline_login_password_error':
          'Offline login username or password Error',
      'offline_mode': 'Offline Mode',
      'no_offline_data': 'No offline data',
      'offline_score': 'Offline Score',
      'offline_bus_reservations': 'Offline Bus Reservations',
      'offline_leave_data': 'Offline absent Report',
      'noData': 'No Data',
      'contactFansPage': 'Contact',
      'newsRuleTitle': 'News publication rules',
      'newsRuleDescription1':
          'This feature provides information about the school or student\'s publication of the school.\n\nPlease contact the fan page if you need it\n',
      'newsRuleDescription2':
          '1. Image and upload to imgur, please use JPEG compressed file. It is recommended not to exceed 100KB. \n2. The title suggests placing the name of the event, not too long. \n3. Activity URL link. \n4. Description of the content. \n5. Must be a non-profit activity.\n\n',
      'newsRuleDescription3':
          'The NKUST AP team has the final right to modify.',
      'theme': 'Theme',
      'systemTheme': 'System Theme',
      'light': 'Light',
      'dark': 'Dark',
      'iconStyle': 'Icon Style',
      'filled': 'Filled',
      'outlined': 'Outlined',
      'searchUsername': 'Search Student ID',
      'search': 'Search',
      'name': 'Name',
      'id': 'id',
      'searchResult': 'Result',
      'autoFill': 'Auto Fill',
      'firstLoginHint':
          'For first-time login, please fill in the last four number of your ID as your password',
      'searchStudentIdFormat': 'Name：%s\nStudent ID：%s\n',
      'searchStudentIdError': 'Search no data.',
      'midtermAlerts': 'Midterm Alerts',
      'midtermAlertsEmpty':
          'Very Good！ No Midterm warning class for this semester~\n Please choose another semester \uD83D\uDE0B',
      'midtermAlertsContent': 'Reason：%s\nRemark：%s',
      'rewardAndPenalty': 'Reward and Penalty',
      'rewardAndPenaltyEmpty':
          'Oops！No reward and penalty for this semester~\n Please choose another semester \uD83D\uDE0B',
      'rewardAndPenaltyContent': 'Counts：%s\nDate：%s',
      'campusNotSupport': 'Campus not support this feature ~',
      'userNotSupport': 'User can\'t use this feature ~',
      'notLogin': 'Not Login',
      'notLoginHint': 'Not Login, please check login status.',
      'addDate': 'Add Date',
      'tutor': 'Tutor',
      'leaveType': 'Leave Type',
      'reason': 'Reason',
      'delayReason': 'Delay Reason',
      'submit': 'Submit',
      'leaveSubmitUploadHint':
          'Uploading\nPlease waiting for finish before close App',
      'confirm': 'Confirm',
      'teacher': 'Teacher',
      'pickTeacher': 'Pick Teacher',
      'leaveProof': 'Leave Proof',
      'pleasePick': 'Please Pick one',
      'pleasePickDateAndSection': 'Please pick date and section.',
      'leaveSubmitSuccess': 'Leave submit successful.',
      'leaveDelayHint': 'Because over time, need to fill delay reason.',
      'leaveProofHint': 'Please pick image',
      'imageCompressHint':
          'Because file big than %.1fMB, so compress to %.2f MB',
      'imageTooBigHint':
          'Image size must below %.1fMB, Plese pick another one.',
      'leaveDateAndSection': 'Date & Section',
      'none': 'None',
      'leaveSubmit': 'Leave Submit',
      'leaveAppHint': 'Do you want to leave App?',
      'closeAppTitle': 'Close App',
      'closeAppHint': 'Do you want to close App?',
      'leaveSubmitFail': 'Oops Leaves Submit Fail!',
      'loginSuccess': 'Login Success',
      'retry': 'Retry',
      'title': 'Title',
      'description': 'Description',
      'imageUrl': 'Image Link',
      'url': 'Link',
      'expireTime': 'Expire Time',
      'weight': 'Weight',
      'newsContentFormat':
          'Weight：%d\nImage Link：%s\nLink：%s\nExpire Time：%s\nDescription：%s',
      'deleteNewsTitle': 'Delete News',
      'deleteNewsContent': 'Sure delete?',
      'deleteSuccess': 'Delete Success',
      'updateSuccess': 'Update Success',
      'formatError': 'Format Error',
      'newsExpireTimeHint': 'No expiration time, please pick time.',
      'setNoExpireTime': 'Set No Expiration Time',
      'noExpiration': 'No Expiration',
      'showSearchButton': 'Show Search Button',
      'email': 'Email',
      'schoolNavigation': 'School Navigation',
      'schoolMap': 'School Map',
      'birthMonth': 'Birth Month',
      'birthDay': 'Birth Day',
      'idCardLastCode': 'ID card',
      'captcha': 'Captcha',
      'usernameError': 'Username Error',
      'captchaError': 'Captcha Error',
      'passwordError': 'Password Error',
      'unknownError': 'Unknown Error, Please contact Facebook fans page.',
      'onlySupportInSchool': 'Only current student',
      'admissionGuide': 'Admission Guide',
      'printing': 'Printing',
      'changeEmail': 'Change Email',
      'done': 'Done',
      'add_to_calendar': 'Add to Calendar',
      'api_server_error': 'AP Server Error\nPlease report to fans page',
      'school_server_error': 'School Server Error\nPlease report to school',
      'room_list': 'Classroom List',
      'empty_classroom_search': 'Empty classroom search',
      'classroom_coursetable_search': 'Classroom Coursetable Search',
      'cancelAllNotify': 'Cancel All Notify',
      'cancelAllNotifySubTitle': 'Clean all notify include unknown notify',
      'exportCourseTable': 'Export courseTable to image',
      'grandPermissionFail': 'Grand permission fail, please try again.',
      'exportCourseTableSuccess':
          'Export Successful~ Please check download directory.',
      'apply': 'Apply',
      'myApplications': 'My Applications',
      'reviewState': 'Review State',
      'waitingForReview': 'Waiting for review',
      'reviewApproval': 'Approval',
      'reviewReject': 'Rejected',
      'reviewDescription': 'Review Description',
      'applicationSubmitSuccess': 'Application Submit Success',
    },
    'zh': {
      'update_note_title': '更新日誌',
      'home': '首頁',
      'splash_content': '我們全都包了\n只剩下學校不包我們',
      'share': '分享',
      'teacher_confirm_title': '您是老師嗎？',
      'teacher_confirm_content': '本 App 僅有學生功能！',
      'continue_to_use': '繼續使用',
      'logout': '登出',
      'click_to_view': '立即前往',
      'login_success': '成功登入高科大校務系統\n點擊左側選單，開始瀏覽',
      'something_error': '發生錯誤',
      'timeout_message': '連線逾時，請稍候再試',
      'login_first': '請先登入',
      'logout_check': '是否要登出？',
      'login': '登入',
      'dot_ap': '校務',
      'dot_leave': '缺曠',
      'dot_bus': '校車',
      'schedule': '行事曆',
      'loading': '載入中',
      'id_hint': '學號',
      'password_hint': '密碼',
      'remember_password': '記住密碼',
      'auto_login': '自動登入',
      'version': 'v.%s',
      'login_ing': '登入中...',
      'call_phone_title': '撥出電話',
      'call_phone_content': '確定要撥給「%s」？',
      'call_phone': '撥出',
      'determine': '確定',
      'cancel': '取消',
      'add_cal_content': '確定要將「%s」新增至行事曆？',
      'click_to_retry': '發生錯誤，點擊重試',
      'bus_pick_date': '選擇乘車時間：%s',
      'bus_not_pick_date': '選擇乘車時間',
      'bus_count': '(%s / %s)',
      'back': '返回',
      'people': '人',
      'bus_reserve': '預定校車',
      'bus_reservations': '校車紀錄',
      'bus_cancel_reserve': '取消預定校車',
      'bus_reserve_confirm_title': '確定要預定本次校車？',
      'bus_reserve_confirm_content': '要預定從%s\n%s 的校車嗎？',
      'bus_cancel_reserve_confirm_title': '確定要<b>取消</b>本校車車次？',
      'bus_cancel_reserve_confirm_content': '要取消從%s\n%s 的校車嗎？',
      'bus_cancel_reserve_confirm_content1': '要取消從',
      'bus_cancel_reserve_confirm_content2': '到',
      'bus_cancel_reserve_confirm_content3': '的校車嗎？',
      'reserve': '預約',
      'bus_reserve_date': '預約日期',
      'bus_reserve_location': '上車地點',
      'bus_reserve_time': '預約班次',
      'unknown': '未知',
      'campus': '校區',
      'reserved': '已預約',
      'can_not_reserve': '無法預約',
      'special_bus': '特殊班次',
      'trial_bus': '試辦車次',
      'bus_reserve_success': '預約成功！',
      'bus_reserve_cancel_date': '取消日期',
      'bus_reserve_cancel_location': '上車地點',
      'bus_reserve_cancel_time': '取消班次',
      'bus_cancel_reserve_success': '取消預約成功！',
      'bus_cancel_reserve_fail': '取消預約失敗',
      'bus_no_reservation': 'Oops！您還沒有預約任何校車喔～\n多多搭乘大眾運輸，節能減碳救地球 \uD83D\uDE0B',
      'bus_reserve_fail_title': 'Oops 預約失敗',
      'i_know': '我知道了',
      'bus_no_bus': 'Oops！本日校車沒上班喔～\n請選擇其他日期 \uD83D\uDE0B',
      'course_no_course': 'Oops！本學期沒有任何課哦～\n請選擇其他學期 \uD83D\uDE0B',
      'ok': '好',
      'course_dialog_messages': '課程名稱：%s\n授課老師：%s\n教室位置：%s\n上課時間：%s',
      'course_dialog_name': '課程名稱',
      'course_dialog_professor': '授課老師',
      'course_dialog_location': '教室位置',
      'course_dialog_time': '上課時間',
      'course_dialog_title': '課程資訊',
      'course_holiday': '旋轉橫向即可查看周末課表 %s',
      'courseClickHint': '點擊科目名稱可看詳細資訊',
      'no_internet': '沒有網路連線，請檢查你的網路',
      'setting_internet': '設定網路',
      'score_no_score': 'Oops！本學期沒有任何成績資料哦～\n請選擇其他學期 \uD83D\uDE0B',
      'subject': '科目',
      'midtermScoreTitle': '期中成績',
      'semesterScoreTitle': '學期成績',
      'midtermScore': '期中成績',
      'finalScore': '期末成績',
      'generalScore': '平時成績',
      'semesterScore': '學期成績',
      'conduct_score': '操行成績',
      'creditsTakenEarned': '修習學分/實得學分',
      'credits': '學分',
      'average': '總平均',
      'rank': '名次',
      'classRank': '班名次',
      'departmentRank': '系名次',
      'totalClassmates': '總人數',
      'percentage': '班名次百分比',
      'leave_night': '旋轉橫向即可查看夜間缺曠',
      'leave_no_leave': 'Oops！本學期沒有任何缺曠課紀錄哦～\n請選擇其他學期 \uD83D\uDE0B',
      'token_expired_title': '重新登入',
      'token_expired_content': '登入資訊過期，請重新登入！',
      'update_content': '%s 有新版本喲！',
      'update_android_content': '%s 在 Play 商店 有新版本喲！',
      'update_ios_content': '%s 在 Apple store 有新版本喲！',
      'update_title': '版本更新',
      'update': '更新',
      'function_not_open': '功能尚未開放\n私密粉絲團 小編會告訴你何時開放！',
      'beta_function': '此功能為測試版本，如有問題請立即回報！',
      'bus_not_pick': '您尚未選擇日期！\n請先選擇日期 %s',
      'easter_egg_juke': '這不是彩蛋',
      'skip': '稍後再說',
      'share_to': '分享至…',
      'send_from': 'Send from %s Android',
      'donate_title': 'Donate',
      'donate_content': '貢獻一點心力支持作者，\n可以提早使用未開放功能！',
      'bus_notify_hint': '校車預約將於發車前三十分鐘提醒！\n若在網頁預約或取消校車請重登入此App。',
      'bus_notify_content': '您有一班 %s 從%s出發的校車！',
      'bus_notify_jiangong': '建工',
      'bus_notify_yanchao': '燕巢',
      'course_vibrate_hint': '將於上課時轉為震動，下課時恢復！',
      'course_vibrate_permission': '需要「零打擾存取權」方能自動轉為震動。',
      'course_notify_hint': '將於上課前十分鐘提醒！',
      'course_notify_content': '%s 上課教室在 %s！',
      'course_notify_unknown': '外太空',
      'course_notify_empty': 'Oops！尚未開啟任何上課提醒哦～',
      'course_notify_error': 'Oops!發生錯誤~',
      'cancel_notify_success': '取消通知成功',
      'calendar_app_not_found': '找不到支援的行事曆 Apps',
      'go_to_settings': '前往設定',
      'education_system': '學制',
      'department': '科系',
      'student_class': '班級',
      'student_id': '學號',
      'student_name_cht': '姓名',
      'notification_item': '通知項目',
      'other_info': '其他資訊',
      'other_settings': '其他設定',
      'environment_settings': '環境設定',
      'head_photo_setting': '顯示大頭貼',
      'head_photo_setting_sub_title': '側選單是否顯示大頭貼',
      'course_notify': '上課提醒',
      'course_notify_sub_title': '上課前十分鐘提醒 點擊可取消通知',
      'course_vibrate': '上課震動',
      'bus_notify': '校車提醒',
      'bus_notify_sub_title': '發車前三十分鐘提醒',
      'feedback': '回饋意見',
      'feedback_via_facebook': '私訊給粉絲專頁',
      'app_version': 'App 版本',
      'about_author_title': '作者群',
      'about_author_content':
          '高科校務通v1 & v2\n呂紹榕(Louie Lu), 姜尚德(JohnThunder), \nregisterAutumn, 詹濬鍵(Evans), \n陳建霖(HearSilent), 陳冠蓁, 徐羽柔\n高科校務通v3\n房志剛(Rainvisitor),林義翔(takidog)\n林鈺軒(Lin YuHsuan),周鈺禮(Gary)\n中山校務通\n房志剛(Rainvisitor),胡智強（JohnHuCC)\n台科校務通\n房志剛(Rainvisitor),林義翔(takidog)\n文藻校務通\n林義翔(takidog),房志剛(Rainvisitor)',
      'about_us':
          '「不要問為何沒有人做這個，\n先承認你就是『沒有人』」。\n因為，「沒有人」是萬能的。\n\n因為沒有人做這些，所以我們跳下來做。\n先後完成了高應無線通、高應校務通，到後來的高應美食通、模擬選課等等.......\n無非是希望帶給大家更便利的校園生活！',
      'about_recruit_title': 'We Need You !',
      'about_recruit_content':
          '如果你是 Objective-C、Swift 高手，或是 Java、Kotlin、Dart 神手，又或是對 Coding充滿著熱誠！\n\n歡迎私訊我們粉絲專頁！\n你的程式碼將有機會出現在周遭同學的手中～',
      'about_itc_content':
          '在103學年度，\n我們也成立了高應大資訊研習社！\n\n如果你對資訊有熱誠或是對我們作品有興趣，歡迎來社課或是講座，也可以來找我們聊聊天。',
      'about_itc_title': '高科資研社',
      'about_contact_us': '聯繫我們',
      'about_open_source_title': '開放原始碼授權',
      'open_drawer': '打開功能表',
      'close_drawer': '關閉功能表',
      'news': '最新消息',
      'offline_course': '離線課表',
      'course_info': '課程學習',
      'course': '學期課表',
      'score': '學期成績',
      'leave': '缺曠系統',
      'bus': '校車系統(建工/燕巢)',
      'simcourse': '模擬選課',
      'school_info': '校園資訊',
      'notifications': '最新消息',
      'phones': '常用電話',
      'events': '行事曆',
      'user': '個人資訊',
      'about': '關於我們',
      'settings': '設定',
      'guest': '訪客',
      'tap_here_to_login': '點擊登入',
      'pick_semester': '選擇學期',
      'enter_username_hint': '請輸入帳號',
      'enter_password_hint': '請輸入密碼',
      'check_login_hint': '請檢查帳號密碼',
      'from_jiangong': '建工上車',
      'from_yanchao': '燕巢上車',
      'lorem_title': 'Lorem ipsum',
      'lorem_sentence': 'Lorem ipsum dolor sit amet.',
      'lorem_paragraph':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'lorem_number': '123',
      'lorem_date': '2015&#8211;09&#8211;06',
      'lorem_time': '09:20',
      'lorem_bus_count': '(1 / 999)',
      'lorem_phone': '(01) 234&#8211;5678',
      'lorem_semester': '104學年度第1學期',
      'mon': ' 一 ',
      'tue': ' 二 ',
      'wed': ' 三 ',
      'thu': ' 四 ',
      'fri': ' 五 ',
      'sat': ' 六 ',
      'sun': ' 日 ',
      'monday': '週一',
      'tuesday': '週二',
      'wednesday': '週三',
      'thursday': '週四',
      'friday': '週五',
      'saturday': '週六',
      'sunday': '週日',
      'units': '學分',
      'courseHours': '時數',
      'do_not_empty': '請勿留空',
      'login_fail': '帳號或密碼錯誤或是此帳號無法使用',
      'bus_fail_infinity': '學校校車系統或許壞掉惹～',
      'reserving': '預約中...',
      'canceling': '取消中...',
      'calculating': '計算中...',
      'calculate_units': '學分試算',
      'required_units': '必修學分',
      'elective_units': '選修學分',
      'other_units': '其他學分',
      'units_total': '總學分',
      'semester': '學期',
      'begin_calculate': '開始計算',
      'calculate_units_content': '計算僅供參考 其餘以學校公告為主',
      'general_eduction_course': '通識課程',
      'can_not_use_feature': '此帳號無法使用此功能或是學校系統出了問題',
      'add_success': '新增成功',
      'date': '日期',
      'leave_apply': '線上請假',
      'leave_records': '缺曠查詢',
      'leave_content': '假單內容',
      'leave_sheet_id': '假單編號',
      'instructors_comment': '師長批註意見',
      'load_offline_data': '載入離線資料',
      'reserve_deadline': '預約截止時間',
      'bus_rule': '校車搭乘規則',
      'platform_error': '此平台無法使用此功能',
      'language': '語言',
      'chose_language_title': '語言',
      'system_language': '系統語言',
      'traditional_chinese': '繁體中文',
      'english': 'English',
      'rating_dialog_title': '評分',
      'rating_dialog_content': '喜歡高科校務通嗎？\n前往商店給予我們評論\n是我們最大的動力！',
      'later': '稍後再說',
      'rate_now': '現在就去',
      'offline_login': '離線登入',
      'no_offline_login_data': '無離線登入資料 請至少登入一次',
      'offline_login_password_error': '離線登入學號或密碼錯誤',
      'offline_mode': '離線模式',
      'no_offline_data': '無離線資料',
      'offline_score': '離線成績',
      'offline_bus_reservations': '離線校車紀錄',
      'offline_leave_data': '離線缺曠資料',
      'noData': '無資料',
      'contactFansPage': '聯絡粉專',
      'newsRuleTitle': '最新消息刊登規則',
      'newsRuleDescription1': '本功能提供社團或學生\n刊登學校相關資訊\n\n若需要請聯絡粉絲專頁並提供\n',
      'newsRuleDescription2':
          '1. 圖片且上傳至 imgur\n請使用ＪＰＥＧ有壓縮過的檔案\n建議不要超過100KB\n2. 標題建議放活動名稱，不要太長\n3. 活動網址連結\n4. 內容說明\n5.必須為非營利活動\n\n',
      'newsRuleDescription3': '高科校務通團隊有最終修改權利',
      'theme': '主題',
      'systemTheme': '系統主題',
      'light': '淺色',
      'dark': '深色',
      'iconStyle': '圖案風格',
      'filled': '填充',
      'outlined': '輪廓',
      'searchUsername': '學號查詢',
      'search': '查詢',
      'name': '名字',
      'id': '身分證字號',
      'searchResult': '查詢結果',
      'autoFill': '自動填入',
      'firstLoginHint': '首次登入密碼預設為身分證末四碼',
      'searchStudentIdFormat': '姓名：%s\n學號：%s\n',
      'searchStudentIdError': '查無資料',
      'midtermAlerts': '期中預警',
      'midtermAlertsEmpty': '太好了！本學期沒有任何科目被預警哦～\n請選擇其他學期 \uD83D\uDE0B',
      'midtermAlertsContent': '原因：%s\n備註：%s',
      'rewardAndPenalty': '獎懲紀錄',
      'rewardAndPenaltyEmpty': 'Oops！本學期沒有任何獎懲紀錄哦～\n請選擇其他學期 \uD83D\uDE0B',
      'rewardAndPenaltyContent': '數量：%s\n日期：%s',
      'campusNotSupport': '所在的校區無法使用此功能',
      'userNotSupport': '使用者無法使用此功能',
      'notLogin': '尚未登入',
      'notLoginHint': '尚未登入 請檢查登入狀態',
      'addDate': '新增日期',
      'tutor': '導師',
      'leaveType': '請假類別',
      'reason': '原因',
      'delayReason': '請假延遲原因',
      'submit': '送出',
      'leaveSubmitUploadHint': '上傳中\n請等候上傳完畢再關閉App',
      'confirm': '確認',
      'teacher': '老師',
      'pickTeacher': '選擇老師',
      'leaveProof': '請假證明',
      'pleasePick': '請選擇',
      'pleasePickDateAndSection': '請選擇日期及節次',
      'leaveSubmitSuccess': '請假送出成功',
      'leaveDelayHint': '因為超出請假時間 請填寫延遲原因',
      'leaveProofHint': '請選擇照片',
      'imageCompressHint': '因檔案超出 %.1fMB 自動將其壓縮至 %.2f MB',
      'imageTooBigHint': '圖片大小必須小於%.1fMB 請重新挑選',
      'leaveDateAndSection': '日期與節次',
      'none': '無',
      'leaveSubmit': '假單送出',
      'closeAppTitle': '關閉App',
      'closeAppHint': '是否關閉App?',
      'leaveSubmitFail': 'Oops 請假送出失敗',
      'loginSuccess': '登入成功',
      'retry': '重試',
      'title': '標題',
      'description': '說明',
      'imageUrl': '圖片網址',
      'url': '連結網址',
      'expireTime': '到期時間',
      'weight': '權重',
      'newsContentFormat': '權重：%d\n圖片網址：%s\n連結網址：%s\n到期時間：%s\n描述：%s',
      'deleteNewsTitle': '刪除最新消息',
      'deleteNewsContent': '確定要刪除?',
      'deleteSuccess': '刪除成功',
      'updateSuccess': '更新成功',
      'formatError': '格式錯誤',
      'newsExpireTimeHint': '無到期時間 請選擇時間',
      'setNoExpireTime': '設定無到期時間',
      'noExpiration': '無到期時間',
      'showSearchButton': '顯示搜尋按鈕',
      'email': '電子信箱',
      'schoolNavigation': '校園導覽',
      'schoolMap': '校園地圖',
      'birthMonth': '出生月',
      'birthDay': '出生日',
      'idCardLastCode': '身分證末四碼',
      'captcha': '驗證碼',
      'usernameError': '學號輸入錯誤',
      'captchaError': '驗證碼錯誤',
      'passwordError': '密碼輸入錯誤',
      'unknownError': '未知錯誤 請聯絡臉書粉絲專頁反應',
      'onlySupportInSchool': '僅限在校生使用',
      'admissionGuide': '入學指南',
      'printing': '印表機',
      'changeEmail': '更改電子信箱',
      'done': '完成',
      'add_to_calendar': '加到行事曆',
      'api_server_error': '校務通伺服器錯誤\n可向粉絲專頁回報',
      'school_server_error': '學校伺服器錯誤\n可向學校回報',
      'room_list': '教室列表',
      'empty_classroom_search': '空教室查詢',
      'classroom_coursetable_search': '教室課表查詢',
      'cancelAllNotify': '取消所有提醒',
      'cancelAllNotifySubTitle': '清除包含未知的通知',
      'exportCourseTable': '匯出課表成圖片',
      'grandPermissionFail': '取得權限失敗 請給於權限功能才能正常運作',
      'exportCourseTableSuccess': '匯出成功~ 請檢查下載資料夾',
      'apply': '申請',
      'myApplications': '我的申請',
      'reviewState': '審查狀態',
      'waitingForReview': '等待審查',
      'reviewApproval': '通過',
      'reviewReject': '未通過',
      'reviewDescription': '審查說明',
      'applicationSubmitSuccess': '申請送出成功',
    },
  };
}

class ApLocalizationsDelegate extends LocalizationsDelegate<ApLocalizations> {
  const ApLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<ApLocalizations> load(Locale locale) async {
    return ApLocalizations(locale);
  }

  @override
  bool shouldReload(ApLocalizationsDelegate old) => false;
}
