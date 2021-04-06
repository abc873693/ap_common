// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class ApLocalizations {
  ApLocalizations();
  
  static ApLocalizations current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<ApLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      ApLocalizations.current = ApLocalizations();
      
      return ApLocalizations.current;
    });
  } 

  static ApLocalizations of(BuildContext context) {
    return Localizations.of<ApLocalizations>(context, ApLocalizations);
  }

  /// `更新日誌`
  String get updateNoteTitle {
    return Intl.message(
      '更新日誌',
      name: 'updateNoteTitle',
      desc: '',
      args: [],
    );
  }

  /// `首頁`
  String get home {
    return Intl.message(
      '首頁',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `我們全都包了\n只剩下學校不包我們`
  String get splashContent {
    return Intl.message(
      '我們全都包了\n只剩下學校不包我們',
      name: 'splashContent',
      desc: '',
      args: [],
    );
  }

  /// `分享`
  String get share {
    return Intl.message(
      '分享',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `您是老師嗎？`
  String get teacherConfirmTitle {
    return Intl.message(
      '您是老師嗎？',
      name: 'teacherConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `本 App 僅有學生功能！`
  String get teacherConfirmContent {
    return Intl.message(
      '本 App 僅有學生功能！',
      name: 'teacherConfirmContent',
      desc: '',
      args: [],
    );
  }

  /// `繼續使用`
  String get continueToUse {
    return Intl.message(
      '繼續使用',
      name: 'continueToUse',
      desc: '',
      args: [],
    );
  }

  /// `登出`
  String get logout {
    return Intl.message(
      '登出',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `立即前往`
  String get clickToView {
    return Intl.message(
      '立即前往',
      name: 'clickToView',
      desc: '',
      args: [],
    );
  }

  /// `登入成功`
  String get loginSuccess {
    return Intl.message(
      '登入成功',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `發生錯誤`
  String get somethingError {
    return Intl.message(
      '發生錯誤',
      name: 'somethingError',
      desc: '',
      args: [],
    );
  }

  /// `連線逾時，請稍候再試`
  String get timeoutMessage {
    return Intl.message(
      '連線逾時，請稍候再試',
      name: 'timeoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `請先登入`
  String get loginFirst {
    return Intl.message(
      '請先登入',
      name: 'loginFirst',
      desc: '',
      args: [],
    );
  }

  /// `是否要登出？`
  String get logoutCheck {
    return Intl.message(
      '是否要登出？',
      name: 'logoutCheck',
      desc: '',
      args: [],
    );
  }

  /// `登入`
  String get login {
    return Intl.message(
      '登入',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `校務`
  String get dotAp {
    return Intl.message(
      '校務',
      name: 'dotAp',
      desc: '',
      args: [],
    );
  }

  /// `缺曠`
  String get dotLeave {
    return Intl.message(
      '缺曠',
      name: 'dotLeave',
      desc: '',
      args: [],
    );
  }

  /// `校車`
  String get dotBus {
    return Intl.message(
      '校車',
      name: 'dotBus',
      desc: '',
      args: [],
    );
  }

  /// `行事曆`
  String get schedule {
    return Intl.message(
      '行事曆',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `載入中`
  String get loading {
    return Intl.message(
      '載入中',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `學號`
  String get idHint {
    return Intl.message(
      '學號',
      name: 'idHint',
      desc: '',
      args: [],
    );
  }

  /// `密碼`
  String get passwordHint {
    return Intl.message(
      '密碼',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `記住密碼`
  String get rememberPassword {
    return Intl.message(
      '記住密碼',
      name: 'rememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `自動登入`
  String get autoLogin {
    return Intl.message(
      '自動登入',
      name: 'autoLogin',
      desc: '',
      args: [],
    );
  }

  /// `v.%s`
  String get version {
    return Intl.message(
      'v.%s',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `登入中...`
  String get logining {
    return Intl.message(
      '登入中...',
      name: 'logining',
      desc: '',
      args: [],
    );
  }

  /// `撥出電話`
  String get callPhoneTitle {
    return Intl.message(
      '撥出電話',
      name: 'callPhoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `確定要撥給「%s」？`
  String get callPhoneContent {
    return Intl.message(
      '確定要撥給「%s」？',
      name: 'callPhoneContent',
      desc: '',
      args: [],
    );
  }

  /// `撥出`
  String get callPhone {
    return Intl.message(
      '撥出',
      name: 'callPhone',
      desc: '',
      args: [],
    );
  }

  /// `確定`
  String get determine {
    return Intl.message(
      '確定',
      name: 'determine',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancel {
    return Intl.message(
      '取消',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `確定要將「%s」新增至行事曆？`
  String get addCalendarContent {
    return Intl.message(
      '確定要將「%s」新增至行事曆？',
      name: 'addCalendarContent',
      desc: '',
      args: [],
    );
  }

  /// `發生錯誤，點擊重試`
  String get clickToRetry {
    return Intl.message(
      '發生錯誤，點擊重試',
      name: 'clickToRetry',
      desc: '',
      args: [],
    );
  }

  /// `選擇乘車時間：%s`
  String get busPickDate {
    return Intl.message(
      '選擇乘車時間：%s',
      name: 'busPickDate',
      desc: '',
      args: [],
    );
  }

  /// `選擇乘車時間`
  String get busNotPickDate {
    return Intl.message(
      '選擇乘車時間',
      name: 'busNotPickDate',
      desc: '',
      args: [],
    );
  }

  /// `(%s / %s)`
  String get busCount {
    return Intl.message(
      '(%s / %s)',
      name: 'busCount',
      desc: '',
      args: [],
    );
  }

  /// `返回`
  String get back {
    return Intl.message(
      '返回',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `人`
  String get people {
    return Intl.message(
      '人',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `預定校車`
  String get busReserve {
    return Intl.message(
      '預定校車',
      name: 'busReserve',
      desc: '',
      args: [],
    );
  }

  /// `校車紀錄`
  String get busReservations {
    return Intl.message(
      '校車紀錄',
      name: 'busReservations',
      desc: '',
      args: [],
    );
  }

  /// `取消預定校車`
  String get busCancelReserve {
    return Intl.message(
      '取消預定校車',
      name: 'busCancelReserve',
      desc: '',
      args: [],
    );
  }

  /// `確定要預定本次校車？`
  String get busReserveConfirmTitle {
    return Intl.message(
      '確定要預定本次校車？',
      name: 'busReserveConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `要預定從%s\n%s 的校車嗎？`
  String get busReserveConfirmContent {
    return Intl.message(
      '要預定從%s\n%s 的校車嗎？',
      name: 'busReserveConfirmContent',
      desc: '',
      args: [],
    );
  }

  /// `確定要<b>取消</b>本校車車次？`
  String get busCancelReserveConfirmTitle {
    return Intl.message(
      '確定要<b>取消</b>本校車車次？',
      name: 'busCancelReserveConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `要取消從%s\n%s 的校車嗎？`
  String get busCancelReserveConfirmContent {
    return Intl.message(
      '要取消從%s\n%s 的校車嗎？',
      name: 'busCancelReserveConfirmContent',
      desc: '',
      args: [],
    );
  }

  /// `要取消從`
  String get busCancelReserveConfirmContent1 {
    return Intl.message(
      '要取消從',
      name: 'busCancelReserveConfirmContent1',
      desc: '',
      args: [],
    );
  }

  /// `到`
  String get busCancelReserveConfirmContent2 {
    return Intl.message(
      '到',
      name: 'busCancelReserveConfirmContent2',
      desc: '',
      args: [],
    );
  }

  /// `的校車嗎？`
  String get busCancelReserveConfirmContent3 {
    return Intl.message(
      '的校車嗎？',
      name: 'busCancelReserveConfirmContent3',
      desc: '',
      args: [],
    );
  }

  /// `預約`
  String get reserve {
    return Intl.message(
      '預約',
      name: 'reserve',
      desc: '',
      args: [],
    );
  }

  /// `預約日期`
  String get busReserveDate {
    return Intl.message(
      '預約日期',
      name: 'busReserveDate',
      desc: '',
      args: [],
    );
  }

  /// `上車地點`
  String get busReserveLocation {
    return Intl.message(
      '上車地點',
      name: 'busReserveLocation',
      desc: '',
      args: [],
    );
  }

  /// `預約班次`
  String get busReserveTime {
    return Intl.message(
      '預約班次',
      name: 'busReserveTime',
      desc: '',
      args: [],
    );
  }

  /// `未知`
  String get unknown {
    return Intl.message(
      '未知',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `校區`
  String get campus {
    return Intl.message(
      '校區',
      name: 'campus',
      desc: '',
      args: [],
    );
  }

  /// `已預約`
  String get reserved {
    return Intl.message(
      '已預約',
      name: 'reserved',
      desc: '',
      args: [],
    );
  }

  /// `無法預約`
  String get canNotReserve {
    return Intl.message(
      '無法預約',
      name: 'canNotReserve',
      desc: '',
      args: [],
    );
  }

  /// `特殊班次`
  String get specialBus {
    return Intl.message(
      '特殊班次',
      name: 'specialBus',
      desc: '',
      args: [],
    );
  }

  /// `試辦車次`
  String get trialBus {
    return Intl.message(
      '試辦車次',
      name: 'trialBus',
      desc: '',
      args: [],
    );
  }

  /// `預約成功！`
  String get busReserveSuccess {
    return Intl.message(
      '預約成功！',
      name: 'busReserveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `取消日期`
  String get busReserveCancelDate {
    return Intl.message(
      '取消日期',
      name: 'busReserveCancelDate',
      desc: '',
      args: [],
    );
  }

  /// `上車地點`
  String get busReserveCancelLocation {
    return Intl.message(
      '上車地點',
      name: 'busReserveCancelLocation',
      desc: '',
      args: [],
    );
  }

  /// `取消班次`
  String get busReserveCancelTime {
    return Intl.message(
      '取消班次',
      name: 'busReserveCancelTime',
      desc: '',
      args: [],
    );
  }

  /// `取消預約成功！`
  String get busCancelReserveSuccess {
    return Intl.message(
      '取消預約成功！',
      name: 'busCancelReserveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `取消預約失敗`
  String get busCancelReserveFail {
    return Intl.message(
      '取消預約失敗',
      name: 'busCancelReserveFail',
      desc: '',
      args: [],
    );
  }

  /// `Oops！您還沒有預約任何校車喔～\n多多搭乘大眾運輸，節能減碳救地球 😋`
  String get busReservationEmpty {
    return Intl.message(
      'Oops！您還沒有預約任何校車喔～\n多多搭乘大眾運輸，節能減碳救地球 😋',
      name: 'busReservationEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Oops 預約失敗`
  String get busReserveFailTitle {
    return Intl.message(
      'Oops 預約失敗',
      name: 'busReserveFailTitle',
      desc: '',
      args: [],
    );
  }

  /// `我知道了`
  String get iKnow {
    return Intl.message(
      '我知道了',
      name: 'iKnow',
      desc: '',
      args: [],
    );
  }

  /// `Oops！目前校車沒上班喔～\n請選擇其他班次 😋`
  String get busEmpty {
    return Intl.message(
      'Oops！目前校車沒上班喔～\n請選擇其他班次 😋',
      name: 'busEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Oops！本學期沒有任何課哦～\n請選擇其他學期 😋`
  String get courseEmpty {
    return Intl.message(
      'Oops！本學期沒有任何課哦～\n請選擇其他學期 😋',
      name: 'courseEmpty',
      desc: '',
      args: [],
    );
  }

  /// `好`
  String get ok {
    return Intl.message(
      '好',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `課程名稱：%s\n授課老師：%s\n教室位置：%s\n上課時間：%s`
  String get courseDialogMessages {
    return Intl.message(
      '課程名稱：%s\n授課老師：%s\n教室位置：%s\n上課時間：%s',
      name: 'courseDialogMessages',
      desc: '',
      args: [],
    );
  }

  /// `課程名稱`
  String get courseDialogName {
    return Intl.message(
      '課程名稱',
      name: 'courseDialogName',
      desc: '',
      args: [],
    );
  }

  /// `授課老師`
  String get courseDialogProfessor {
    return Intl.message(
      '授課老師',
      name: 'courseDialogProfessor',
      desc: '',
      args: [],
    );
  }

  /// `教室位置`
  String get courseDialogLocation {
    return Intl.message(
      '教室位置',
      name: 'courseDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `上課時間`
  String get courseDialogTime {
    return Intl.message(
      '上課時間',
      name: 'courseDialogTime',
      desc: '',
      args: [],
    );
  }

  /// `課程資訊`
  String get courseDialogTitle {
    return Intl.message(
      '課程資訊',
      name: 'courseDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `旋轉橫向即可查看周末課表 %s`
  String get courseHoliday {
    return Intl.message(
      '旋轉橫向即可查看周末課表 %s',
      name: 'courseHoliday',
      desc: '',
      args: [],
    );
  }

  /// `點擊科目名稱可看詳細資訊`
  String get courseClickHint {
    return Intl.message(
      '點擊科目名稱可看詳細資訊',
      name: 'courseClickHint',
      desc: '',
      args: [],
    );
  }

  /// `沒有網路連線，請檢查你的網路`
  String get noInternet {
    return Intl.message(
      '沒有網路連線，請檢查你的網路',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `設定網路`
  String get settingInternet {
    return Intl.message(
      '設定網路',
      name: 'settingInternet',
      desc: '',
      args: [],
    );
  }

  /// `Oops！本學期沒有任何成績資料哦～\n請選擇其他學期 😋`
  String get scoreEmpty {
    return Intl.message(
      'Oops！本學期沒有任何成績資料哦～\n請選擇其他學期 😋',
      name: 'scoreEmpty',
      desc: '',
      args: [],
    );
  }

  /// `科目`
  String get subject {
    return Intl.message(
      '科目',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `期中成績`
  String get midtermScoreTitle {
    return Intl.message(
      '期中成績',
      name: 'midtermScoreTitle',
      desc: '',
      args: [],
    );
  }

  /// `學期成績`
  String get semesterScoreTitle {
    return Intl.message(
      '學期成績',
      name: 'semesterScoreTitle',
      desc: '',
      args: [],
    );
  }

  /// `期中成績`
  String get midtermScore {
    return Intl.message(
      '期中成績',
      name: 'midtermScore',
      desc: '',
      args: [],
    );
  }

  /// `期末成績`
  String get finalScore {
    return Intl.message(
      '期末成績',
      name: 'finalScore',
      desc: '',
      args: [],
    );
  }

  /// `平時成績`
  String get generalScore {
    return Intl.message(
      '平時成績',
      name: 'generalScore',
      desc: '',
      args: [],
    );
  }

  /// `學期成績`
  String get semesterScore {
    return Intl.message(
      '學期成績',
      name: 'semesterScore',
      desc: '',
      args: [],
    );
  }

  /// `操行成績`
  String get conductScore {
    return Intl.message(
      '操行成績',
      name: 'conductScore',
      desc: '',
      args: [],
    );
  }

  /// `修習學分/實得學分`
  String get creditsTakenEarned {
    return Intl.message(
      '修習學分/實得學分',
      name: 'creditsTakenEarned',
      desc: '',
      args: [],
    );
  }

  /// `學分`
  String get credits {
    return Intl.message(
      '學分',
      name: 'credits',
      desc: '',
      args: [],
    );
  }

  /// `總平均`
  String get average {
    return Intl.message(
      '總平均',
      name: 'average',
      desc: '',
      args: [],
    );
  }

  /// `名次`
  String get rank {
    return Intl.message(
      '名次',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `班名次`
  String get classRank {
    return Intl.message(
      '班名次',
      name: 'classRank',
      desc: '',
      args: [],
    );
  }

  /// `系名次`
  String get departmentRank {
    return Intl.message(
      '系名次',
      name: 'departmentRank',
      desc: '',
      args: [],
    );
  }

  /// `總人數`
  String get totalClassmates {
    return Intl.message(
      '總人數',
      name: 'totalClassmates',
      desc: '',
      args: [],
    );
  }

  /// `班名次百分比`
  String get percentage {
    return Intl.message(
      '班名次百分比',
      name: 'percentage',
      desc: '',
      args: [],
    );
  }

  /// `旋轉橫向即可查看夜間缺曠`
  String get leaveNight {
    return Intl.message(
      '旋轉橫向即可查看夜間缺曠',
      name: 'leaveNight',
      desc: '',
      args: [],
    );
  }

  /// `Oops！本學期沒有任何缺曠課紀錄哦～\n請選擇其他學期 😋`
  String get leaveEmpty {
    return Intl.message(
      'Oops！本學期沒有任何缺曠課紀錄哦～\n請選擇其他學期 😋',
      name: 'leaveEmpty',
      desc: '',
      args: [],
    );
  }

  /// `重新登入`
  String get tokenExpiredTitle {
    return Intl.message(
      '重新登入',
      name: 'tokenExpiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `登入資訊過期，請重新登入！`
  String get tokenExpiredContent {
    return Intl.message(
      '登入資訊過期，請重新登入！',
      name: 'tokenExpiredContent',
      desc: '',
      args: [],
    );
  }

  /// `%s 有新版本喲！`
  String get updateContent {
    return Intl.message(
      '%s 有新版本喲！',
      name: 'updateContent',
      desc: '',
      args: [],
    );
  }

  /// `%s 在 Play 商店 有新版本喲！`
  String get updateAndroidContent {
    return Intl.message(
      '%s 在 Play 商店 有新版本喲！',
      name: 'updateAndroidContent',
      desc: '',
      args: [],
    );
  }

  /// `%s 在 Apple store 有新版本喲！`
  String get updateIosContent {
    return Intl.message(
      '%s 在 Apple store 有新版本喲！',
      name: 'updateIosContent',
      desc: '',
      args: [],
    );
  }

  /// `版本更新`
  String get updateTitle {
    return Intl.message(
      '版本更新',
      name: 'updateTitle',
      desc: '',
      args: [],
    );
  }

  /// `更新`
  String get update {
    return Intl.message(
      '更新',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `功能尚未開放\n私密粉絲團 小編會告訴你何時開放！`
  String get functionNotOpen {
    return Intl.message(
      '功能尚未開放\n私密粉絲團 小編會告訴你何時開放！',
      name: 'functionNotOpen',
      desc: '',
      args: [],
    );
  }

  /// `此功能為測試版本，如有問題請立即回報！`
  String get betaFunction {
    return Intl.message(
      '此功能為測試版本，如有問題請立即回報！',
      name: 'betaFunction',
      desc: '',
      args: [],
    );
  }

  /// `您尚未選擇日期！\n請先選擇日期 %s`
  String get busNotPick {
    return Intl.message(
      '您尚未選擇日期！\n請先選擇日期 %s',
      name: 'busNotPick',
      desc: '',
      args: [],
    );
  }

  /// `這不是彩蛋`
  String get easterEggJuke {
    return Intl.message(
      '這不是彩蛋',
      name: 'easterEggJuke',
      desc: '',
      args: [],
    );
  }

  /// `稍後再說`
  String get skip {
    return Intl.message(
      '稍後再說',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `分享至…`
  String get shareTo {
    return Intl.message(
      '分享至…',
      name: 'shareTo',
      desc: '',
      args: [],
    );
  }

  /// `Send from %s Android`
  String get sendFrom {
    return Intl.message(
      'Send from %s Android',
      name: 'sendFrom',
      desc: '',
      args: [],
    );
  }

  /// `Donate`
  String get donateTitle {
    return Intl.message(
      'Donate',
      name: 'donateTitle',
      desc: '',
      args: [],
    );
  }

  /// `貢獻一點心力支持作者，\n可以提早使用未開放功能！`
  String get donateContent {
    return Intl.message(
      '貢獻一點心力支持作者，\n可以提早使用未開放功能！',
      name: 'donateContent',
      desc: '',
      args: [],
    );
  }

  /// `校車預約將於發車前三十分鐘提醒！\n若在網頁預約或取消校車請重登入此App。`
  String get busNotifyHint {
    return Intl.message(
      '校車預約將於發車前三十分鐘提醒！\n若在網頁預約或取消校車請重登入此App。',
      name: 'busNotifyHint',
      desc: '',
      args: [],
    );
  }

  /// `您有一班 %s 從%s出發的校車！`
  String get busNotifyContent {
    return Intl.message(
      '您有一班 %s 從%s出發的校車！',
      name: 'busNotifyContent',
      desc: '',
      args: [],
    );
  }

  /// `建工`
  String get busNotifyJiangong {
    return Intl.message(
      '建工',
      name: 'busNotifyJiangong',
      desc: '',
      args: [],
    );
  }

  /// `燕巢`
  String get busNotifyYanchao {
    return Intl.message(
      '燕巢',
      name: 'busNotifyYanchao',
      desc: '',
      args: [],
    );
  }

  /// `將於上課時轉為震動，下課時恢復！`
  String get courseVibrateHint {
    return Intl.message(
      '將於上課時轉為震動，下課時恢復！',
      name: 'courseVibrateHint',
      desc: '',
      args: [],
    );
  }

  /// `需要「零打擾存取權」方能自動轉為震動。`
  String get courseVibratePermission {
    return Intl.message(
      '需要「零打擾存取權」方能自動轉為震動。',
      name: 'courseVibratePermission',
      desc: '',
      args: [],
    );
  }

  /// `將於上課前十分鐘提醒！`
  String get courseNotifyHint {
    return Intl.message(
      '將於上課前十分鐘提醒！',
      name: 'courseNotifyHint',
      desc: '',
      args: [],
    );
  }

  /// `%s 上課教室在 %s！`
  String get courseNotifyContent {
    return Intl.message(
      '%s 上課教室在 %s！',
      name: 'courseNotifyContent',
      desc: '',
      args: [],
    );
  }

  /// `外太空`
  String get courseNotifyUnknown {
    return Intl.message(
      '外太空',
      name: 'courseNotifyUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Oops！尚未開啟任何上課提醒哦～`
  String get courseNotifyEmpty {
    return Intl.message(
      'Oops！尚未開啟任何上課提醒哦～',
      name: 'courseNotifyEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Oops!發生錯誤~`
  String get courseNotifyError {
    return Intl.message(
      'Oops!發生錯誤~',
      name: 'courseNotifyError',
      desc: '',
      args: [],
    );
  }

  /// `取消通知成功`
  String get cancelNotifySuccess {
    return Intl.message(
      '取消通知成功',
      name: 'cancelNotifySuccess',
      desc: '',
      args: [],
    );
  }

  /// `找不到支援的行事曆 Apps`
  String get calendarAppNotFound {
    return Intl.message(
      '找不到支援的行事曆 Apps',
      name: 'calendarAppNotFound',
      desc: '',
      args: [],
    );
  }

  /// `前往設定`
  String get goToSettings {
    return Intl.message(
      '前往設定',
      name: 'goToSettings',
      desc: '',
      args: [],
    );
  }

  /// `學制`
  String get educationSystem {
    return Intl.message(
      '學制',
      name: 'educationSystem',
      desc: '',
      args: [],
    );
  }

  /// `科系`
  String get department {
    return Intl.message(
      '科系',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `班級`
  String get studentClass {
    return Intl.message(
      '班級',
      name: 'studentClass',
      desc: '',
      args: [],
    );
  }

  /// `學號`
  String get studentId {
    return Intl.message(
      '學號',
      name: 'studentId',
      desc: '',
      args: [],
    );
  }

  /// `姓名`
  String get studentNameCht {
    return Intl.message(
      '姓名',
      name: 'studentNameCht',
      desc: '',
      args: [],
    );
  }

  /// `通知項目`
  String get notificationItem {
    return Intl.message(
      '通知項目',
      name: 'notificationItem',
      desc: '',
      args: [],
    );
  }

  /// `其他資訊`
  String get otherInfo {
    return Intl.message(
      '其他資訊',
      name: 'otherInfo',
      desc: '',
      args: [],
    );
  }

  /// `其他設定`
  String get otherSettings {
    return Intl.message(
      '其他設定',
      name: 'otherSettings',
      desc: '',
      args: [],
    );
  }

  /// `環境設定`
  String get environmentSettings {
    return Intl.message(
      '環境設定',
      name: 'environmentSettings',
      desc: '',
      args: [],
    );
  }

  /// `顯示大頭貼`
  String get headPhotoSetting {
    return Intl.message(
      '顯示大頭貼',
      name: 'headPhotoSetting',
      desc: '',
      args: [],
    );
  }

  /// `側選單是否顯示大頭貼`
  String get headPhotoSettingSubTitle {
    return Intl.message(
      '側選單是否顯示大頭貼',
      name: 'headPhotoSettingSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `上課提醒`
  String get courseNotify {
    return Intl.message(
      '上課提醒',
      name: 'courseNotify',
      desc: '',
      args: [],
    );
  }

  /// `上課前十分鐘提醒 點擊可取消通知`
  String get courseNotifySubTitle {
    return Intl.message(
      '上課前十分鐘提醒 點擊可取消通知',
      name: 'courseNotifySubTitle',
      desc: '',
      args: [],
    );
  }

  /// `上課震動`
  String get courseVibrate {
    return Intl.message(
      '上課震動',
      name: 'courseVibrate',
      desc: '',
      args: [],
    );
  }

  /// `校車提醒`
  String get busNotify {
    return Intl.message(
      '校車提醒',
      name: 'busNotify',
      desc: '',
      args: [],
    );
  }

  /// `發車前三十分鐘提醒`
  String get busNotifySubTitle {
    return Intl.message(
      '發車前三十分鐘提醒',
      name: 'busNotifySubTitle',
      desc: '',
      args: [],
    );
  }

  /// `回饋意見`
  String get feedback {
    return Intl.message(
      '回饋意見',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `私訊給粉絲專頁`
  String get feedbackViaFacebook {
    return Intl.message(
      '私訊給粉絲專頁',
      name: 'feedbackViaFacebook',
      desc: '',
      args: [],
    );
  }

  /// `App 版本`
  String get appVersion {
    return Intl.message(
      'App 版本',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `作者群`
  String get aboutAuthorTitle {
    return Intl.message(
      '作者群',
      name: 'aboutAuthorTitle',
      desc: '',
      args: [],
    );
  }

  /// `高科校務通v1 & v2\n呂紹榕(Louie Lu), 姜尚德(JohnThunder), \nregisterAutumn, 詹濬鍵(Evans), \n陳建霖(HearSilent), 陳冠蓁, 徐羽柔\n高科校務通v3\n房志剛(Rainvisitor),林義翔(takidog)\n林鈺軒(Lin YuHsuan),周鈺禮(Gary)\n中山校務通\n房志剛(Rainvisitor),胡智強（JohnHuCC)\n台科校務通\n房志剛(Rainvisitor),林義翔(takidog)\n文藻校務通\n林義翔(takidog),房志剛(Rainvisitor)`
  String get aboutAuthorContent {
    return Intl.message(
      '高科校務通v1 & v2\n呂紹榕(Louie Lu), 姜尚德(JohnThunder), \nregisterAutumn, 詹濬鍵(Evans), \n陳建霖(HearSilent), 陳冠蓁, 徐羽柔\n高科校務通v3\n房志剛(Rainvisitor),林義翔(takidog)\n林鈺軒(Lin YuHsuan),周鈺禮(Gary)\n中山校務通\n房志剛(Rainvisitor),胡智強（JohnHuCC)\n台科校務通\n房志剛(Rainvisitor),林義翔(takidog)\n文藻校務通\n林義翔(takidog),房志剛(Rainvisitor)',
      name: 'aboutAuthorContent',
      desc: '',
      args: [],
    );
  }

  /// `「不要問為何沒有人做這個，\n先承認你就是『沒有人』」。\n因為，「沒有人」是萬能的。\n\n因為沒有人做這些，所以我們跳下來做。\n先後完成了高應無線通、高應校務通，到後來的高應美食通、模擬選課等等.......\n無非是希望帶給大家更便利的校園生活！`
  String get aboutUsContent {
    return Intl.message(
      '「不要問為何沒有人做這個，\n先承認你就是『沒有人』」。\n因為，「沒有人」是萬能的。\n\n因為沒有人做這些，所以我們跳下來做。\n先後完成了高應無線通、高應校務通，到後來的高應美食通、模擬選課等等.......\n無非是希望帶給大家更便利的校園生活！',
      name: 'aboutUsContent',
      desc: '',
      args: [],
    );
  }

  /// `We Need You !`
  String get aboutRecruitTitle {
    return Intl.message(
      'We Need You !',
      name: 'aboutRecruitTitle',
      desc: '',
      args: [],
    );
  }

  /// `如果你是 Objective-C、Swift 高手，或是 Java、Kotlin、Dart 神手，又或是對 Coding充滿著熱誠！\n\n歡迎私訊我們粉絲專頁！\n你的程式碼將有機會出現在周遭同學的手中～`
  String get aboutRecruitContent {
    return Intl.message(
      '如果你是 Objective-C、Swift 高手，或是 Java、Kotlin、Dart 神手，又或是對 Coding充滿著熱誠！\n\n歡迎私訊我們粉絲專頁！\n你的程式碼將有機會出現在周遭同學的手中～',
      name: 'aboutRecruitContent',
      desc: '',
      args: [],
    );
  }

  /// `在103學年度，\n我們也成立了高應大資訊研習社！\n\n如果你對資訊有熱誠或是對我們作品有興趣，歡迎來社課或是講座，也可以來找我們聊聊天。`
  String get aboutItcContent {
    return Intl.message(
      '在103學年度，\n我們也成立了高應大資訊研習社！\n\n如果你對資訊有熱誠或是對我們作品有興趣，歡迎來社課或是講座，也可以來找我們聊聊天。',
      name: 'aboutItcContent',
      desc: '',
      args: [],
    );
  }

  /// `高科資研社`
  String get aboutItcTitle {
    return Intl.message(
      '高科資研社',
      name: 'aboutItcTitle',
      desc: '',
      args: [],
    );
  }

  /// `聯繫我們`
  String get aboutContactUsTitle {
    return Intl.message(
      '聯繫我們',
      name: 'aboutContactUsTitle',
      desc: '',
      args: [],
    );
  }

  /// `開放原始碼授權`
  String get aboutOpenSourceTitle {
    return Intl.message(
      '開放原始碼授權',
      name: 'aboutOpenSourceTitle',
      desc: '',
      args: [],
    );
  }

  /// `打開功能表`
  String get openDrawer {
    return Intl.message(
      '打開功能表',
      name: 'openDrawer',
      desc: '',
      args: [],
    );
  }

  /// `關閉功能表`
  String get closeDrawer {
    return Intl.message(
      '關閉功能表',
      name: 'closeDrawer',
      desc: '',
      args: [],
    );
  }

  /// `最新消息`
  String get announcements {
    return Intl.message(
      '最新消息',
      name: 'announcements',
      desc: '',
      args: [],
    );
  }

  /// `Oops！沒有任何最新消息 😋`
  String get announcementEmpty {
    return Intl.message(
      'Oops！沒有任何最新消息 😋',
      name: 'announcementEmpty',
      desc: '',
      args: [],
    );
  }

  /// `離線課表`
  String get offlineCourse {
    return Intl.message(
      '離線課表',
      name: 'offlineCourse',
      desc: '',
      args: [],
    );
  }

  /// `課程學習`
  String get courseInfo {
    return Intl.message(
      '課程學習',
      name: 'courseInfo',
      desc: '',
      args: [],
    );
  }

  /// `學期課表`
  String get course {
    return Intl.message(
      '學期課表',
      name: 'course',
      desc: '',
      args: [],
    );
  }

  /// `學期成績`
  String get score {
    return Intl.message(
      '學期成績',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `缺曠系統`
  String get leave {
    return Intl.message(
      '缺曠系統',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `校車系統`
  String get bus {
    return Intl.message(
      '校車系統',
      name: 'bus',
      desc: '',
      args: [],
    );
  }

  /// `模擬選課`
  String get simcourse {
    return Intl.message(
      '模擬選課',
      name: 'simcourse',
      desc: '',
      args: [],
    );
  }

  /// `校園資訊`
  String get schoolInfo {
    return Intl.message(
      '校園資訊',
      name: 'schoolInfo',
      desc: '',
      args: [],
    );
  }

  /// `最新消息`
  String get notifications {
    return Intl.message(
      '最新消息',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `常用電話`
  String get phones {
    return Intl.message(
      '常用電話',
      name: 'phones',
      desc: '',
      args: [],
    );
  }

  /// `行事曆`
  String get events {
    return Intl.message(
      '行事曆',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `個人資訊`
  String get userInfo {
    return Intl.message(
      '個人資訊',
      name: 'userInfo',
      desc: '',
      args: [],
    );
  }

  /// `關於我們`
  String get about {
    return Intl.message(
      '關於我們',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `設定`
  String get settings {
    return Intl.message(
      '設定',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `訪客`
  String get guest {
    return Intl.message(
      '訪客',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `點擊登入`
  String get tapHereToLogin {
    return Intl.message(
      '點擊登入',
      name: 'tapHereToLogin',
      desc: '',
      args: [],
    );
  }

  /// `選擇學期`
  String get pickSemester {
    return Intl.message(
      '選擇學期',
      name: 'pickSemester',
      desc: '',
      args: [],
    );
  }

  /// `請輸入帳號`
  String get enterUsernameHint {
    return Intl.message(
      '請輸入帳號',
      name: 'enterUsernameHint',
      desc: '',
      args: [],
    );
  }

  /// `請輸入密碼`
  String get enterPasswordHint {
    return Intl.message(
      '請輸入密碼',
      name: 'enterPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `請檢查帳號密碼`
  String get checkLoginHint {
    return Intl.message(
      '請檢查帳號密碼',
      name: 'checkLoginHint',
      desc: '',
      args: [],
    );
  }

  /// `建工上車`
  String get fromJiangong {
    return Intl.message(
      '建工上車',
      name: 'fromJiangong',
      desc: '',
      args: [],
    );
  }

  /// `燕巢上車`
  String get fromYanchao {
    return Intl.message(
      '燕巢上車',
      name: 'fromYanchao',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum`
  String get loremTitle {
    return Intl.message(
      'Lorem ipsum',
      name: 'loremTitle',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet.`
  String get loremSentence {
    return Intl.message(
      'Lorem ipsum dolor sit amet.',
      name: 'loremSentence',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.`
  String get loremParagraph {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      name: 'loremParagraph',
      desc: '',
      args: [],
    );
  }

  /// `123`
  String get loremNumber {
    return Intl.message(
      '123',
      name: 'loremNumber',
      desc: '',
      args: [],
    );
  }

  /// `2015&#8211;09&#8211;06`
  String get loremDate {
    return Intl.message(
      '2015&#8211;09&#8211;06',
      name: 'loremDate',
      desc: '',
      args: [],
    );
  }

  /// `09:20`
  String get loremTime {
    return Intl.message(
      '09:20',
      name: 'loremTime',
      desc: '',
      args: [],
    );
  }

  /// `(1 / 999)`
  String get loremBusCount {
    return Intl.message(
      '(1 / 999)',
      name: 'loremBusCount',
      desc: '',
      args: [],
    );
  }

  /// `(01) 234&#8211;5678`
  String get loremPhone {
    return Intl.message(
      '(01) 234&#8211;5678',
      name: 'loremPhone',
      desc: '',
      args: [],
    );
  }

  /// `104學年度第1學期`
  String get loremSemester {
    return Intl.message(
      '104學年度第1學期',
      name: 'loremSemester',
      desc: '',
      args: [],
    );
  }

  /// `一`
  String get mon {
    return Intl.message(
      '一',
      name: 'mon',
      desc: '',
      args: [],
    );
  }

  /// `二`
  String get tue {
    return Intl.message(
      '二',
      name: 'tue',
      desc: '',
      args: [],
    );
  }

  /// `三`
  String get wed {
    return Intl.message(
      '三',
      name: 'wed',
      desc: '',
      args: [],
    );
  }

  /// `四`
  String get thu {
    return Intl.message(
      '四',
      name: 'thu',
      desc: '',
      args: [],
    );
  }

  /// `五`
  String get fri {
    return Intl.message(
      '五',
      name: 'fri',
      desc: '',
      args: [],
    );
  }

  /// `六`
  String get sat {
    return Intl.message(
      '六',
      name: 'sat',
      desc: '',
      args: [],
    );
  }

  /// `日`
  String get sun {
    return Intl.message(
      '日',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `週一`
  String get monday {
    return Intl.message(
      '週一',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `週二`
  String get tuesday {
    return Intl.message(
      '週二',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `週三`
  String get wednesday {
    return Intl.message(
      '週三',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `週四`
  String get thursday {
    return Intl.message(
      '週四',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `週五`
  String get friday {
    return Intl.message(
      '週五',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `週六`
  String get saturday {
    return Intl.message(
      '週六',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `週日`
  String get sunday {
    return Intl.message(
      '週日',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `學分`
  String get units {
    return Intl.message(
      '學分',
      name: 'units',
      desc: '',
      args: [],
    );
  }

  /// `時數`
  String get courseHours {
    return Intl.message(
      '時數',
      name: 'courseHours',
      desc: '',
      args: [],
    );
  }

  /// `請勿留空`
  String get doNotEmpty {
    return Intl.message(
      '請勿留空',
      name: 'doNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `帳號或密碼錯誤或是此帳號無法使用`
  String get loginFail {
    return Intl.message(
      '帳號或密碼錯誤或是此帳號無法使用',
      name: 'loginFail',
      desc: '',
      args: [],
    );
  }

  /// `學校校車系統或許壞掉惹～`
  String get busFailInfinity {
    return Intl.message(
      '學校校車系統或許壞掉惹～',
      name: 'busFailInfinity',
      desc: '',
      args: [],
    );
  }

  /// `預約中...`
  String get reserving {
    return Intl.message(
      '預約中...',
      name: 'reserving',
      desc: '',
      args: [],
    );
  }

  /// `取消中...`
  String get canceling {
    return Intl.message(
      '取消中...',
      name: 'canceling',
      desc: '',
      args: [],
    );
  }

  /// `計算中...`
  String get calculating {
    return Intl.message(
      '計算中...',
      name: 'calculating',
      desc: '',
      args: [],
    );
  }

  /// `學分試算`
  String get calculateUnits {
    return Intl.message(
      '學分試算',
      name: 'calculateUnits',
      desc: '',
      args: [],
    );
  }

  /// `必修學分`
  String get requiredUnits {
    return Intl.message(
      '必修學分',
      name: 'requiredUnits',
      desc: '',
      args: [],
    );
  }

  /// `選修學分`
  String get electiveUnits {
    return Intl.message(
      '選修學分',
      name: 'electiveUnits',
      desc: '',
      args: [],
    );
  }

  /// `其他學分`
  String get otherUnits {
    return Intl.message(
      '其他學分',
      name: 'otherUnits',
      desc: '',
      args: [],
    );
  }

  /// `總學分`
  String get unitsTotal {
    return Intl.message(
      '總學分',
      name: 'unitsTotal',
      desc: '',
      args: [],
    );
  }

  /// `學期`
  String get semester {
    return Intl.message(
      '學期',
      name: 'semester',
      desc: '',
      args: [],
    );
  }

  /// `開始計算`
  String get beginCalculate {
    return Intl.message(
      '開始計算',
      name: 'beginCalculate',
      desc: '',
      args: [],
    );
  }

  /// `計算僅供參考 其餘以學校公告為主`
  String get calculateUnitsContent {
    return Intl.message(
      '計算僅供參考 其餘以學校公告為主',
      name: 'calculateUnitsContent',
      desc: '',
      args: [],
    );
  }

  /// `通識課程`
  String get generalEductionCourse {
    return Intl.message(
      '通識課程',
      name: 'generalEductionCourse',
      desc: '',
      args: [],
    );
  }

  /// `此帳號無法使用此功能或是學校系統出了問題`
  String get canNotUseFeature {
    return Intl.message(
      '此帳號無法使用此功能或是學校系統出了問題',
      name: 'canNotUseFeature',
      desc: '',
      args: [],
    );
  }

  /// `新增成功`
  String get addSuccess {
    return Intl.message(
      '新增成功',
      name: 'addSuccess',
      desc: '',
      args: [],
    );
  }

  /// `日期`
  String get date {
    return Intl.message(
      '日期',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `線上請假`
  String get leaveApply {
    return Intl.message(
      '線上請假',
      name: 'leaveApply',
      desc: '',
      args: [],
    );
  }

  /// `缺曠查詢`
  String get leaveRecords {
    return Intl.message(
      '缺曠查詢',
      name: 'leaveRecords',
      desc: '',
      args: [],
    );
  }

  /// `假單內容`
  String get leaveContent {
    return Intl.message(
      '假單內容',
      name: 'leaveContent',
      desc: '',
      args: [],
    );
  }

  /// `假單編號`
  String get leaveSheetId {
    return Intl.message(
      '假單編號',
      name: 'leaveSheetId',
      desc: '',
      args: [],
    );
  }

  /// `師長批註意見`
  String get instructorsComment {
    return Intl.message(
      '師長批註意見',
      name: 'instructorsComment',
      desc: '',
      args: [],
    );
  }

  /// `載入離線資料`
  String get loadOfflineData {
    return Intl.message(
      '載入離線資料',
      name: 'loadOfflineData',
      desc: '',
      args: [],
    );
  }

  /// `預約截止時間`
  String get reserveDeadline {
    return Intl.message(
      '預約截止時間',
      name: 'reserveDeadline',
      desc: '',
      args: [],
    );
  }

  /// `校車搭乘規則`
  String get busRule {
    return Intl.message(
      '校車搭乘規則',
      name: 'busRule',
      desc: '',
      args: [],
    );
  }

  /// `此平台無法使用此功能`
  String get platformError {
    return Intl.message(
      '此平台無法使用此功能',
      name: 'platformError',
      desc: '',
      args: [],
    );
  }

  /// `語言`
  String get language {
    return Intl.message(
      '語言',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `語言`
  String get choseLanguageTitle {
    return Intl.message(
      '語言',
      name: 'choseLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `系統語言`
  String get systemLanguage {
    return Intl.message(
      '系統語言',
      name: 'systemLanguage',
      desc: '',
      args: [],
    );
  }

  /// `繁體中文`
  String get traditionalChinese {
    return Intl.message(
      '繁體中文',
      name: 'traditionalChinese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `評分`
  String get ratingDialogTitle {
    return Intl.message(
      '評分',
      name: 'ratingDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `喜歡校務通嗎？\n前往商店給予我們評論\n是我們最大的動力！`
  String get ratingDialogContent {
    return Intl.message(
      '喜歡校務通嗎？\n前往商店給予我們評論\n是我們最大的動力！',
      name: 'ratingDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `稍後再說`
  String get later {
    return Intl.message(
      '稍後再說',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `現在就去`
  String get rateNow {
    return Intl.message(
      '現在就去',
      name: 'rateNow',
      desc: '',
      args: [],
    );
  }

  /// `離線登入`
  String get offlineLogin {
    return Intl.message(
      '離線登入',
      name: 'offlineLogin',
      desc: '',
      args: [],
    );
  }

  /// `無離線登入資料 請至少登入一次`
  String get noOfflineLoginData {
    return Intl.message(
      '無離線登入資料 請至少登入一次',
      name: 'noOfflineLoginData',
      desc: '',
      args: [],
    );
  }

  /// `離線登入學號或密碼錯誤`
  String get offlineLoginPasswordError {
    return Intl.message(
      '離線登入學號或密碼錯誤',
      name: 'offlineLoginPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `離線模式`
  String get offlineMode {
    return Intl.message(
      '離線模式',
      name: 'offlineMode',
      desc: '',
      args: [],
    );
  }

  /// `無離線資料`
  String get noOfflineData {
    return Intl.message(
      '無離線資料',
      name: 'noOfflineData',
      desc: '',
      args: [],
    );
  }

  /// `離線成績`
  String get offlineScore {
    return Intl.message(
      '離線成績',
      name: 'offlineScore',
      desc: '',
      args: [],
    );
  }

  /// `離線校車紀錄`
  String get offlineBusReservations {
    return Intl.message(
      '離線校車紀錄',
      name: 'offlineBusReservations',
      desc: '',
      args: [],
    );
  }

  /// `離線缺曠資料`
  String get offlineLeaveData {
    return Intl.message(
      '離線缺曠資料',
      name: 'offlineLeaveData',
      desc: '',
      args: [],
    );
  }

  /// `無資料`
  String get noData {
    return Intl.message(
      '無資料',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `聯絡粉專`
  String get contactFansPage {
    return Intl.message(
      '聯絡粉專',
      name: 'contactFansPage',
      desc: '',
      args: [],
    );
  }

  /// `最新消息刊登規則`
  String get newsRuleTitle {
    return Intl.message(
      '最新消息刊登規則',
      name: 'newsRuleTitle',
      desc: '',
      args: [],
    );
  }

  /// `本系統提供社團或學生\n刊登學校相關資訊\n需使用有學校域名(%s)的第三方驗證帳號登入\n`
  String get newsRuleDescription1 {
    return Intl.message(
      '本系統提供社團或學生\n刊登學校相關資訊\n需使用有學校域名(%s)的第三方驗證帳號登入\n',
      name: 'newsRuleDescription1',
      desc: '',
      args: [],
    );
  }

  /// `1. 圖片且上傳至 Imgur\n請使用JPEG有壓縮過的檔案\n建議不要超過100KB\n2. 標題建議放活動名稱，不要太長\n3. 活動網址連結\n4. 內容說明(建議100字內 避免跑版)\n5.必須為非營利活動\n\n`
  String get newsRuleDescription2 {
    return Intl.message(
      '1. 圖片且上傳至 Imgur\n請使用JPEG有壓縮過的檔案\n建議不要超過100KB\n2. 標題建議放活動名稱，不要太長\n3. 活動網址連結\n4. 內容說明(建議100字內 避免跑版)\n5.必須為非營利活動\n\n',
      name: 'newsRuleDescription2',
      desc: '',
      args: [],
    );
  }

  /// `校務通團隊有最終修改權利`
  String get newsRuleDescription3 {
    return Intl.message(
      '校務通團隊有最終修改權利',
      name: 'newsRuleDescription3',
      desc: '',
      args: [],
    );
  }

  /// `主題`
  String get theme {
    return Intl.message(
      '主題',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `系統主題`
  String get systemTheme {
    return Intl.message(
      '系統主題',
      name: 'systemTheme',
      desc: '',
      args: [],
    );
  }

  /// `淺色`
  String get light {
    return Intl.message(
      '淺色',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `深色`
  String get dark {
    return Intl.message(
      '深色',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `圖案風格`
  String get iconStyle {
    return Intl.message(
      '圖案風格',
      name: 'iconStyle',
      desc: '',
      args: [],
    );
  }

  /// `填充`
  String get filled {
    return Intl.message(
      '填充',
      name: 'filled',
      desc: '',
      args: [],
    );
  }

  /// `輪廓`
  String get outlined {
    return Intl.message(
      '輪廓',
      name: 'outlined',
      desc: '',
      args: [],
    );
  }

  /// `學號查詢`
  String get searchUsername {
    return Intl.message(
      '學號查詢',
      name: 'searchUsername',
      desc: '',
      args: [],
    );
  }

  /// `查詢`
  String get search {
    return Intl.message(
      '查詢',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `名字`
  String get name {
    return Intl.message(
      '名字',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `身分證字號`
  String get id {
    return Intl.message(
      '身分證字號',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `查詢結果`
  String get searchResult {
    return Intl.message(
      '查詢結果',
      name: 'searchResult',
      desc: '',
      args: [],
    );
  }

  /// `自動填入`
  String get autoFill {
    return Intl.message(
      '自動填入',
      name: 'autoFill',
      desc: '',
      args: [],
    );
  }

  /// `首次登入密碼預設為身分證末四碼`
  String get firstLoginHint {
    return Intl.message(
      '首次登入密碼預設為身分證末四碼',
      name: 'firstLoginHint',
      desc: '',
      args: [],
    );
  }

  /// `姓名：%s\n學號：%s\n`
  String get searchStudentIdFormat {
    return Intl.message(
      '姓名：%s\n學號：%s\n',
      name: 'searchStudentIdFormat',
      desc: '',
      args: [],
    );
  }

  /// `查無資料`
  String get searchStudentIdError {
    return Intl.message(
      '查無資料',
      name: 'searchStudentIdError',
      desc: '',
      args: [],
    );
  }

  /// `期中預警`
  String get midtermAlerts {
    return Intl.message(
      '期中預警',
      name: 'midtermAlerts',
      desc: '',
      args: [],
    );
  }

  /// `太好了！本學期沒有任何科目被預警哦～\n請選擇其他學期 😋`
  String get midtermAlertsEmpty {
    return Intl.message(
      '太好了！本學期沒有任何科目被預警哦～\n請選擇其他學期 😋',
      name: 'midtermAlertsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `原因：%s\n備註：%s`
  String get midtermAlertsContent {
    return Intl.message(
      '原因：%s\n備註：%s',
      name: 'midtermAlertsContent',
      desc: '',
      args: [],
    );
  }

  /// `獎懲紀錄`
  String get rewardAndPenalty {
    return Intl.message(
      '獎懲紀錄',
      name: 'rewardAndPenalty',
      desc: '',
      args: [],
    );
  }

  /// `Oops！本學期沒有任何獎懲紀錄哦～\n請選擇其他學期 😋`
  String get rewardAndPenaltyEmpty {
    return Intl.message(
      'Oops！本學期沒有任何獎懲紀錄哦～\n請選擇其他學期 😋',
      name: 'rewardAndPenaltyEmpty',
      desc: '',
      args: [],
    );
  }

  /// `數量：%s\n日期：%s`
  String get rewardAndPenaltyContent {
    return Intl.message(
      '數量：%s\n日期：%s',
      name: 'rewardAndPenaltyContent',
      desc: '',
      args: [],
    );
  }

  /// `所在的校區無法使用此功能`
  String get campusNotSupport {
    return Intl.message(
      '所在的校區無法使用此功能',
      name: 'campusNotSupport',
      desc: '',
      args: [],
    );
  }

  /// `使用者無法使用此功能`
  String get userNotSupport {
    return Intl.message(
      '使用者無法使用此功能',
      name: 'userNotSupport',
      desc: '',
      args: [],
    );
  }

  /// `尚未登入`
  String get notLogin {
    return Intl.message(
      '尚未登入',
      name: 'notLogin',
      desc: '',
      args: [],
    );
  }

  /// `尚未登入 請檢查登入狀態`
  String get notLoginHint {
    return Intl.message(
      '尚未登入 請檢查登入狀態',
      name: 'notLoginHint',
      desc: '',
      args: [],
    );
  }

  /// `新增日期`
  String get addDate {
    return Intl.message(
      '新增日期',
      name: 'addDate',
      desc: '',
      args: [],
    );
  }

  /// `導師`
  String get tutor {
    return Intl.message(
      '導師',
      name: 'tutor',
      desc: '',
      args: [],
    );
  }

  /// `請假類別`
  String get leaveType {
    return Intl.message(
      '請假類別',
      name: 'leaveType',
      desc: '',
      args: [],
    );
  }

  /// `原因`
  String get reason {
    return Intl.message(
      '原因',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `請假延遲原因`
  String get delayReason {
    return Intl.message(
      '請假延遲原因',
      name: 'delayReason',
      desc: '',
      args: [],
    );
  }

  /// `送出`
  String get submit {
    return Intl.message(
      '送出',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `上傳中\n請等候上傳完畢再關閉App`
  String get leaveSubmitUploadHint {
    return Intl.message(
      '上傳中\n請等候上傳完畢再關閉App',
      name: 'leaveSubmitUploadHint',
      desc: '',
      args: [],
    );
  }

  /// `確認`
  String get confirm {
    return Intl.message(
      '確認',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `老師`
  String get teacher {
    return Intl.message(
      '老師',
      name: 'teacher',
      desc: '',
      args: [],
    );
  }

  /// `選擇老師`
  String get pickTeacher {
    return Intl.message(
      '選擇老師',
      name: 'pickTeacher',
      desc: '',
      args: [],
    );
  }

  /// `請假證明`
  String get leaveProof {
    return Intl.message(
      '請假證明',
      name: 'leaveProof',
      desc: '',
      args: [],
    );
  }

  /// `請選擇`
  String get pleasePick {
    return Intl.message(
      '請選擇',
      name: 'pleasePick',
      desc: '',
      args: [],
    );
  }

  /// `請選擇日期及節次`
  String get pleasePickDateAndSection {
    return Intl.message(
      '請選擇日期及節次',
      name: 'pleasePickDateAndSection',
      desc: '',
      args: [],
    );
  }

  /// `請假送出成功`
  String get leaveSubmitSuccess {
    return Intl.message(
      '請假送出成功',
      name: 'leaveSubmitSuccess',
      desc: '',
      args: [],
    );
  }

  /// `因為超出請假時間 請填寫延遲原因`
  String get leaveDelayHint {
    return Intl.message(
      '因為超出請假時間 請填寫延遲原因',
      name: 'leaveDelayHint',
      desc: '',
      args: [],
    );
  }

  /// `請選擇照片`
  String get leaveProofHint {
    return Intl.message(
      '請選擇照片',
      name: 'leaveProofHint',
      desc: '',
      args: [],
    );
  }

  /// `因檔案超出 %.1fMB 自動將其壓縮至 %.2f MB`
  String get imageCompressHint {
    return Intl.message(
      '因檔案超出 %.1fMB 自動將其壓縮至 %.2f MB',
      name: 'imageCompressHint',
      desc: '',
      args: [],
    );
  }

  /// `圖片大小必須小於%.1fMB 請重新挑選`
  String get imageTooBigHint {
    return Intl.message(
      '圖片大小必須小於%.1fMB 請重新挑選',
      name: 'imageTooBigHint',
      desc: '',
      args: [],
    );
  }

  /// `日期與節次`
  String get leaveDateAndSection {
    return Intl.message(
      '日期與節次',
      name: 'leaveDateAndSection',
      desc: '',
      args: [],
    );
  }

  /// `無`
  String get none {
    return Intl.message(
      '無',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `假單送出`
  String get leaveSubmit {
    return Intl.message(
      '假單送出',
      name: 'leaveSubmit',
      desc: '',
      args: [],
    );
  }

  /// `關閉App`
  String get closeAppTitle {
    return Intl.message(
      '關閉App',
      name: 'closeAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `是否關閉App?`
  String get closeAppHint {
    return Intl.message(
      '是否關閉App?',
      name: 'closeAppHint',
      desc: '',
      args: [],
    );
  }

  /// `Oops 請假送出失敗`
  String get leaveSubmitFail {
    return Intl.message(
      'Oops 請假送出失敗',
      name: 'leaveSubmitFail',
      desc: '',
      args: [],
    );
  }

  /// `重試`
  String get retry {
    return Intl.message(
      '重試',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `標題`
  String get title {
    return Intl.message(
      '標題',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `說明`
  String get description {
    return Intl.message(
      '說明',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `圖片網址`
  String get imageUrl {
    return Intl.message(
      '圖片網址',
      name: 'imageUrl',
      desc: '',
      args: [],
    );
  }

  /// `連結網址`
  String get url {
    return Intl.message(
      '連結網址',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `到期時間`
  String get expireTime {
    return Intl.message(
      '到期時間',
      name: 'expireTime',
      desc: '',
      args: [],
    );
  }

  /// `權重`
  String get weight {
    return Intl.message(
      '權重',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `權重：%d\n圖片網址：%s\n連結網址：%s\n到期時間：%s\n描述：%s`
  String get newsContentFormat {
    return Intl.message(
      '權重：%d\n圖片網址：%s\n連結網址：%s\n到期時間：%s\n描述：%s',
      name: 'newsContentFormat',
      desc: '',
      args: [],
    );
  }

  /// `刪除最新消息`
  String get deleteNewsTitle {
    return Intl.message(
      '刪除最新消息',
      name: 'deleteNewsTitle',
      desc: '',
      args: [],
    );
  }

  /// `確定要刪除?`
  String get deleteNewsContent {
    return Intl.message(
      '確定要刪除?',
      name: 'deleteNewsContent',
      desc: '',
      args: [],
    );
  }

  /// `刪除成功`
  String get deleteSuccess {
    return Intl.message(
      '刪除成功',
      name: 'deleteSuccess',
      desc: '',
      args: [],
    );
  }

  /// `更新成功`
  String get updateSuccess {
    return Intl.message(
      '更新成功',
      name: 'updateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `格式錯誤`
  String get formatError {
    return Intl.message(
      '格式錯誤',
      name: 'formatError',
      desc: '',
      args: [],
    );
  }

  /// `無到期時間 請選擇時間`
  String get newsExpireTimeHint {
    return Intl.message(
      '無到期時間 請選擇時間',
      name: 'newsExpireTimeHint',
      desc: '',
      args: [],
    );
  }

  /// `設定無到期時間`
  String get setNoExpireTime {
    return Intl.message(
      '設定無到期時間',
      name: 'setNoExpireTime',
      desc: '',
      args: [],
    );
  }

  /// `無到期時間`
  String get noExpiration {
    return Intl.message(
      '無到期時間',
      name: 'noExpiration',
      desc: '',
      args: [],
    );
  }

  /// `顯示搜尋按鈕`
  String get showSearchButton {
    return Intl.message(
      '顯示搜尋按鈕',
      name: 'showSearchButton',
      desc: '',
      args: [],
    );
  }

  /// `電子信箱`
  String get email {
    return Intl.message(
      '電子信箱',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `校園導覽`
  String get schoolNavigation {
    return Intl.message(
      '校園導覽',
      name: 'schoolNavigation',
      desc: '',
      args: [],
    );
  }

  /// `校園地圖`
  String get schoolMap {
    return Intl.message(
      '校園地圖',
      name: 'schoolMap',
      desc: '',
      args: [],
    );
  }

  /// `出生月`
  String get birthMonth {
    return Intl.message(
      '出生月',
      name: 'birthMonth',
      desc: '',
      args: [],
    );
  }

  /// `出生日`
  String get birthDay {
    return Intl.message(
      '出生日',
      name: 'birthDay',
      desc: '',
      args: [],
    );
  }

  /// `身分證末四碼`
  String get idCardLastCode {
    return Intl.message(
      '身分證末四碼',
      name: 'idCardLastCode',
      desc: '',
      args: [],
    );
  }

  /// `驗證碼`
  String get captcha {
    return Intl.message(
      '驗證碼',
      name: 'captcha',
      desc: '',
      args: [],
    );
  }

  /// `學號輸入錯誤`
  String get usernameError {
    return Intl.message(
      '學號輸入錯誤',
      name: 'usernameError',
      desc: '',
      args: [],
    );
  }

  /// `驗證碼錯誤`
  String get captchaError {
    return Intl.message(
      '驗證碼錯誤',
      name: 'captchaError',
      desc: '',
      args: [],
    );
  }

  /// `密碼輸入錯誤`
  String get passwordError {
    return Intl.message(
      '密碼輸入錯誤',
      name: 'passwordError',
      desc: '',
      args: [],
    );
  }

  /// `未知錯誤 請聯絡臉書粉絲專頁反應`
  String get unknownError {
    return Intl.message(
      '未知錯誤 請聯絡臉書粉絲專頁反應',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `僅限在校生使用`
  String get onlySupportInSchool {
    return Intl.message(
      '僅限在校生使用',
      name: 'onlySupportInSchool',
      desc: '',
      args: [],
    );
  }

  /// `入學指南`
  String get admissionGuide {
    return Intl.message(
      '入學指南',
      name: 'admissionGuide',
      desc: '',
      args: [],
    );
  }

  /// `印表機`
  String get printing {
    return Intl.message(
      '印表機',
      name: 'printing',
      desc: '',
      args: [],
    );
  }

  /// `更改電子信箱`
  String get changeEmail {
    return Intl.message(
      '更改電子信箱',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `完成`
  String get done {
    return Intl.message(
      '完成',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `加到行事曆`
  String get addToCalendar {
    return Intl.message(
      '加到行事曆',
      name: 'addToCalendar',
      desc: '',
      args: [],
    );
  }

  /// `校務通伺服器錯誤\n可向粉絲專頁回報`
  String get apiServerError {
    return Intl.message(
      '校務通伺服器錯誤\n可向粉絲專頁回報',
      name: 'apiServerError',
      desc: '',
      args: [],
    );
  }

  /// `學校伺服器錯誤\n可向學校回報`
  String get schoolServerError {
    return Intl.message(
      '學校伺服器錯誤\n可向學校回報',
      name: 'schoolServerError',
      desc: '',
      args: [],
    );
  }

  /// `教室列表`
  String get roomList {
    return Intl.message(
      '教室列表',
      name: 'roomList',
      desc: '',
      args: [],
    );
  }

  /// `空教室查詢`
  String get emptyClassroomSearch {
    return Intl.message(
      '空教室查詢',
      name: 'emptyClassroomSearch',
      desc: '',
      args: [],
    );
  }

  /// `教室課表查詢`
  String get classroomCourseTableSearch {
    return Intl.message(
      '教室課表查詢',
      name: 'classroomCourseTableSearch',
      desc: '',
      args: [],
    );
  }

  /// `取消所有提醒`
  String get cancelAllNotify {
    return Intl.message(
      '取消所有提醒',
      name: 'cancelAllNotify',
      desc: '',
      args: [],
    );
  }

  /// `清除包含未知的通知`
  String get cancelAllNotifySubTitle {
    return Intl.message(
      '清除包含未知的通知',
      name: 'cancelAllNotifySubTitle',
      desc: '',
      args: [],
    );
  }

  /// `匯出課表成圖片`
  String get exportCourseTable {
    return Intl.message(
      '匯出課表成圖片',
      name: 'exportCourseTable',
      desc: '',
      args: [],
    );
  }

  /// `取得權限失敗 請給於權限功能才能正常運作`
  String get grandPermissionFail {
    return Intl.message(
      '取得權限失敗 請給於權限功能才能正常運作',
      name: 'grandPermissionFail',
      desc: '',
      args: [],
    );
  }

  /// `匯出成功~ 請檢查資料夾`
  String get exportCourseTableSuccess {
    return Intl.message(
      '匯出成功~ 請檢查資料夾',
      name: 'exportCourseTableSuccess',
      desc: '',
      args: [],
    );
  }

  /// `課表設定`
  String get courseScaffoldSetting {
    return Intl.message(
      '課表設定',
      name: 'courseScaffoldSetting',
      desc: '',
      args: [],
    );
  }

  /// `顯示課堂時間`
  String get showSectionTime {
    return Intl.message(
      '顯示課堂時間',
      name: 'showSectionTime',
      desc: '',
      args: [],
    );
  }

  /// `顯示教師名稱`
  String get showInstructors {
    return Intl.message(
      '顯示教師名稱',
      name: 'showInstructors',
      desc: '',
      args: [],
    );
  }

  /// `顯示教室位置`
  String get showClassroomLocation {
    return Intl.message(
      '顯示教室位置',
      name: 'showClassroomLocation',
      desc: '',
      args: [],
    );
  }

  /// `最新消息審查系統`
  String get announcementReviewSystem {
    return Intl.message(
      '最新消息審查系統',
      name: 'announcementReviewSystem',
      desc: '',
      args: [],
    );
  }

  /// `第三方登入失敗`
  String get thirdPartyLoginFail {
    return Intl.message(
      '第三方登入失敗',
      name: 'thirdPartyLoginFail',
      desc: '',
      args: [],
    );
  }

  /// `批准`
  String get approve {
    return Intl.message(
      '批准',
      name: 'approve',
      desc: '',
      args: [],
    );
  }

  /// `駁回`
  String get reject {
    return Intl.message(
      '駁回',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `更新並批准`
  String get updateAndApprove {
    return Intl.message(
      '更新並批准',
      name: 'updateAndApprove',
      desc: '',
      args: [],
    );
  }

  /// `更新並駁回`
  String get updateAndReject {
    return Intl.message(
      '更新並駁回',
      name: 'updateAndReject',
      desc: '',
      args: [],
    );
  }

  /// `審查申請`
  String get reviewApplication {
    return Intl.message(
      '審查申請',
      name: 'reviewApplication',
      desc: '',
      args: [],
    );
  }

  /// `找不到此資料`
  String get notFoundData {
    return Intl.message(
      '找不到此資料',
      name: 'notFoundData',
      desc: '',
      args: [],
    );
  }

  /// `所有最新消息`
  String get allAnnouncements {
    return Intl.message(
      '所有最新消息',
      name: 'allAnnouncements',
      desc: '',
      args: [],
    );
  }

  /// `所有審查`
  String get allApplications {
    return Intl.message(
      '所有審查',
      name: 'allApplications',
      desc: '',
      args: [],
    );
  }

  /// `無權限`
  String get noPermissionHint {
    return Intl.message(
      '無權限',
      name: 'noPermissionHint',
      desc: '',
      args: [],
    );
  }

  /// `無權限操作更新`
  String get noPermissionUpdateHint {
    return Intl.message(
      '無權限操作更新',
      name: 'noPermissionUpdateHint',
      desc: '',
      args: [],
    );
  }

  /// `無權限操作審查`
  String get noPermissionReviewHint {
    return Intl.message(
      '無權限操作審查',
      name: 'noPermissionReviewHint',
      desc: '',
      args: [],
    );
  }

  /// `找不到對應的 application_id.`
  String get noApplicationHint {
    return Intl.message(
      '找不到對應的 application_id.',
      name: 'noApplicationHint',
      desc: '',
      args: [],
    );
  }

  /// `申請`
  String get apply {
    return Intl.message(
      '申請',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `我的申請`
  String get myApplications {
    return Intl.message(
      '我的申請',
      name: 'myApplications',
      desc: '',
      args: [],
    );
  }

  /// `審查狀態`
  String get reviewState {
    return Intl.message(
      '審查狀態',
      name: 'reviewState',
      desc: '',
      args: [],
    );
  }

  /// `等待審查`
  String get waitingForReview {
    return Intl.message(
      '等待審查',
      name: 'waitingForReview',
      desc: '',
      args: [],
    );
  }

  /// `通過`
  String get reviewApproval {
    return Intl.message(
      '通過',
      name: 'reviewApproval',
      desc: '',
      args: [],
    );
  }

  /// `未通過`
  String get reviewReject {
    return Intl.message(
      '未通過',
      name: 'reviewReject',
      desc: '',
      args: [],
    );
  }

  /// `審查說明`
  String get reviewDescription {
    return Intl.message(
      '審查說明',
      name: 'reviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `申請送出成功`
  String get applicationSubmitSuccess {
    return Intl.message(
      '申請送出成功',
      name: 'applicationSubmitSuccess',
      desc: '',
      args: [],
    );
  }

  /// `申請人`
  String get applicant {
    return Intl.message(
      '申請人',
      name: 'applicant',
      desc: '',
      args: [],
    );
  }

  /// `新增申請`
  String get addApplication {
    return Intl.message(
      '新增申請',
      name: 'addApplication',
      desc: '',
      args: [],
    );
  }

  /// `只顯示尚未審查`
  String get onlyShowNotReview {
    return Intl.message(
      '只顯示尚未審查',
      name: 'onlyShowNotReview',
      desc: '',
      args: [],
    );
  }

  /// `帳號`
  String get account {
    return Intl.message(
      '帳號',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `密碼`
  String get password {
    return Intl.message(
      '密碼',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `為了解省伺服器負擔與方便\n圖片將公開上傳至Imgur`
  String get imgurUploadDescription {
    return Intl.message(
      '為了解省伺服器負擔與方便\n圖片將公開上傳至Imgur',
      name: 'imgurUploadDescription',
      desc: '',
      args: [],
    );
  }

  /// `選擇並上傳至Imgur`
  String get pickAndUploadToImgur {
    return Intl.message(
      '選擇並上傳至Imgur',
      name: 'pickAndUploadToImgur',
      desc: '',
      args: [],
    );
  }

  /// `上傳中`
  String get uploading {
    return Intl.message(
      '上傳中',
      name: 'uploading',
      desc: '',
      args: [],
    );
  }

  /// `圖片預覽`
  String get imagePreview {
    return Intl.message(
      '圖片預覽',
      name: 'imagePreview',
      desc: '',
      args: [],
    );
  }

  /// `不支援圖片格式`
  String get notSupportImageType {
    return Intl.message(
      '不支援圖片格式',
      name: 'notSupportImageType',
      desc: '',
      args: [],
    );
  }

  /// `標籤`
  String get tag {
    return Intl.message(
      '標籤',
      name: 'tag',
      desc: '',
      args: [],
    );
  }

  /// `新增標籤`
  String get addTag {
    return Intl.message(
      '新增標籤',
      name: 'addTag',
      desc: '',
      args: [],
    );
  }

  /// `標籤已重複`
  String get tagRepeatHint {
    return Intl.message(
      '標籤已重複',
      name: 'tagRepeatHint',
      desc: '',
      args: [],
    );
  }

  /// `標籤名稱`
  String get tagName {
    return Intl.message(
      '標籤名稱',
      name: 'tagName',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<ApLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<ApLocalizations> load(Locale locale) => ApLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}