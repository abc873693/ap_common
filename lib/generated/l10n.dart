// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

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

  /// `Update Notes`
  String get updateNoteTitle {
    return Intl.message(
      'Update Notes',
      name: 'updateNoteTitle',
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

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Are you a teacher?`
  String get teacherConfirmTitle {
    return Intl.message(
      'Are you a teacher?',
      name: 'teacherConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `This App only for students!`
  String get teacherConfirmContent {
    return Intl.message(
      'This App only for students!',
      name: 'teacherConfirmContent',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueToUse {
    return Intl.message(
      'Continue',
      name: 'continueToUse',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get clickToView {
    return Intl.message(
      'View',
      name: 'clickToView',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get loginSuccess {
    return Intl.message(
      'Login Success',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error Occurred.`
  String get somethingError {
    return Intl.message(
      'Error Occurred.',
      name: 'somethingError',
      desc: '',
      args: [],
    );
  }

  /// `Try again later, Connection Timeout`
  String get timeoutMessage {
    return Intl.message(
      'Try again later, Connection Timeout',
      name: 'timeoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please login`
  String get loginFirst {
    return Intl.message(
      'Please login',
      name: 'loginFirst',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logoutCheck {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutCheck',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `AP`
  String get dotAp {
    return Intl.message(
      'AP',
      name: 'dotAp',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get dotLeave {
    return Intl.message(
      'Leave',
      name: 'dotLeave',
      desc: '',
      args: [],
    );
  }

  /// `Bus`
  String get dotBus {
    return Intl.message(
      'Bus',
      name: 'dotBus',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get schedule {
    return Intl.message(
      'Events',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Student ID`
  String get idHint {
    return Intl.message(
      'Student ID',
      name: 'idHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordHint {
    return Intl.message(
      'Password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Remember`
  String get rememberPassword {
    return Intl.message(
      'Remember',
      name: 'rememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `Auto login`
  String get autoLogin {
    return Intl.message(
      'Auto login',
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

  /// `Logging...`
  String get loginIng {
    return Intl.message(
      'Logging...',
      name: 'loginIng',
      desc: '',
      args: [],
    );
  }

  /// `Call this number`
  String get callPhoneTitle {
    return Intl.message(
      'Call this number',
      name: 'callPhoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to call "%s"?`
  String get callPhoneContent {
    return Intl.message(
      'Are you sure to call "%s"?',
      name: 'callPhoneContent',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get callPhone {
    return Intl.message(
      'Call',
      name: 'callPhone',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get determine {
    return Intl.message(
      'Yes',
      name: 'determine',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get cancel {
    return Intl.message(
      'No',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to add "%s" to your calendar?`
  String get addCalContent {
    return Intl.message(
      'Are you sure to add "%s" to your calendar?',
      name: 'addCalContent',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred, click to retry`
  String get clickToRetry {
    return Intl.message(
      'An error occurred, click to retry',
      name: 'clickToRetry',
      desc: '',
      args: [],
    );
  }

  /// `Chosen Date: %s`
  String get busPickDate {
    return Intl.message(
      'Chosen Date: %s',
      name: 'busPickDate',
      desc: '',
      args: [],
    );
  }

  /// `Chosen Date`
  String get busNotPickDate {
    return Intl.message(
      'Chosen Date',
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

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `PX`
  String get people {
    return Intl.message(
      'PX',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Bus Reservation`
  String get busReserve {
    return Intl.message(
      'Bus Reservation',
      name: 'busReserve',
      desc: '',
      args: [],
    );
  }

  /// `Bus Record`
  String get busReservations {
    return Intl.message(
      'Bus Record',
      name: 'busReservations',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Bus Reservation`
  String get busCancelReserve {
    return Intl.message(
      'Cancel Bus Reservation',
      name: 'busCancelReserve',
      desc: '',
      args: [],
    );
  }

  /// `Reserve this bus?`
  String get busReserveConfirmTitle {
    return Intl.message(
      'Reserve this bus?',
      name: 'busReserveConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to reserve a seat from %s at %s ?`
  String get busReserveConfirmContent {
    return Intl.message(
      'Are you sure to reserve a seat from %s at %s ?',
      name: 'busReserveConfirmContent',
      desc: '',
      args: [],
    );
  }

  /// `<b>Cancel</b> this reservation?`
  String get busCancelReserveConfirmTitle {
    return Intl.message(
      '<b>Cancel</b> this reservation?',
      name: 'busCancelReserveConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to cancel a seat from %s at %s ?`
  String get busCancelReserveConfirmContent {
    return Intl.message(
      'Are you sure to cancel a seat from %s at %s ?',
      name: 'busCancelReserveConfirmContent',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to cancel a seat from `
  String get busCancelReserveConfirmContent1 {
    return Intl.message(
      'Are you sure to cancel a seat from ',
      name: 'busCancelReserveConfirmContent1',
      desc: '',
      args: [],
    );
  }

  /// ` to `
  String get busCancelReserveConfirmContent2 {
    return Intl.message(
      ' to ',
      name: 'busCancelReserveConfirmContent2',
      desc: '',
      args: [],
    );
  }

  /// ` ?`
  String get busCancelReserveConfirmContent3 {
    return Intl.message(
      ' ?',
      name: 'busCancelReserveConfirmContent3',
      desc: '',
      args: [],
    );
  }

  /// `JianGong to YanChao`
  String get busFromJiangong {
    return Intl.message(
      'JianGong to YanChao',
      name: 'busFromJiangong',
      desc: '',
      args: [],
    );
  }

  /// `YanChao to JianGong`
  String get busFromYanchao {
    return Intl.message(
      'YanChao to JianGong',
      name: 'busFromYanchao',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get busReserveDate {
    return Intl.message(
      'Date',
      name: 'busReserveDate',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get busReserveLocation {
    return Intl.message(
      'Location',
      name: 'busReserveLocation',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get busReserveTime {
    return Intl.message(
      'Time',
      name: 'busReserveTime',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// ` campus`
  String get campus {
    return Intl.message(
      ' campus',
      name: 'campus',
      desc: '',
      args: [],
    );
  }

  /// `Reserve`
  String get reserve {
    return Intl.message(
      'Reserve',
      name: 'reserve',
      desc: '',
      args: [],
    );
  }

  /// `Reserved`
  String get reserved {
    return Intl.message(
      'Reserved',
      name: 'reserved',
      desc: '',
      args: [],
    );
  }

  /// `Can"t reserve`
  String get canNotReserve {
    return Intl.message(
      'Can"t reserve',
      name: 'canNotReserve',
      desc: '',
      args: [],
    );
  }

  /// `Special Bus`
  String get specialBus {
    return Intl.message(
      'Special Bus',
      name: 'specialBus',
      desc: '',
      args: [],
    );
  }

  /// `Trial Bus`
  String get trialBus {
    return Intl.message(
      'Trial Bus',
      name: 'trialBus',
      desc: '',
      args: [],
    );
  }

  /// `Successfully Reserved!`
  String get busReserveSuccess {
    return Intl.message(
      'Successfully Reserved!',
      name: 'busReserveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get busReserveCancelDate {
    return Intl.message(
      'Date',
      name: 'busReserveCancelDate',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get busReserveCancelLocation {
    return Intl.message(
      'Location',
      name: 'busReserveCancelLocation',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get busReserveCancelTime {
    return Intl.message(
      'Time',
      name: 'busReserveCancelTime',
      desc: '',
      args: [],
    );
  }

  /// `Successfully Canceled!`
  String get busCancelReserveSuccess {
    return Intl.message(
      'Successfully Canceled!',
      name: 'busCancelReserveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Fail Canceled`
  String get busCancelReserveFail {
    return Intl.message(
      'Fail Canceled',
      name: 'busCancelReserveFail',
      desc: '',
      args: [],
    );
  }

  /// `Oops! You haven"t reserved any bus~\n Ride public transport to save the Earth 😋`
  String get busNoReservation {
    return Intl.message(
      'Oops! You haven"t reserved any bus~\n Ride public transport to save the Earth 😋',
      name: 'busNoReservation',
      desc: '',
      args: [],
    );
  }

  /// `Oops! No bus today~\n Please choose another date 😋`
  String get busNoBus {
    return Intl.message(
      'Oops! No bus today~\n Please choose another date 😋',
      name: 'busNoBus',
      desc: '',
      args: [],
    );
  }

  /// `Oops! No class for this semester~\n Please choose another semester 😋`
  String get courseEmpty {
    return Intl.message(
      'Oops! No class for this semester~\n Please choose another semester 😋',
      name: 'courseEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Oops Book Fail`
  String get busReserveFailTitle {
    return Intl.message(
      'Oops Book Fail',
      name: 'busReserveFailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get iKnow {
    return Intl.message(
      'Got it',
      name: 'iKnow',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Class：%s\nProfessor：%s\nLocation：%s\nTime：%s`
  String get courseDialogMessages {
    return Intl.message(
      'Class：%s\nProfessor：%s\nLocation：%s\nTime：%s',
      name: 'courseDialogMessages',
      desc: '',
      args: [],
    );
  }

  /// `Class`
  String get courseDialogName {
    return Intl.message(
      'Class',
      name: 'courseDialogName',
      desc: '',
      args: [],
    );
  }

  /// `Professor`
  String get courseDialogProfessor {
    return Intl.message(
      'Professor',
      name: 'courseDialogProfessor',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get courseDialogLocation {
    return Intl.message(
      'Location',
      name: 'courseDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get courseDialogTime {
    return Intl.message(
      'Time',
      name: 'courseDialogTime',
      desc: '',
      args: [],
    );
  }

  /// `Class Info`
  String get courseDialogTitle {
    return Intl.message(
      'Class Info',
      name: 'courseDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rotate Screen to see weekend schedule %s`
  String get courseHoliday {
    return Intl.message(
      'Rotate Screen to see weekend schedule %s',
      name: 'courseHoliday',
      desc: '',
      args: [],
    );
  }

  /// `Click subject show more.`
  String get courseClickHint {
    return Intl.message(
      'Click subject show more.',
      name: 'courseClickHint',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternet {
    return Intl.message(
      'No internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Internet Settings`
  String get settingInternet {
    return Intl.message(
      'Internet Settings',
      name: 'settingInternet',
      desc: '',
      args: [],
    );
  }

  /// `Oops! No record for this semester~\nPlease choose another semester 😋`
  String get scoreEmpty {
    return Intl.message(
      'Oops! No record for this semester~\nPlease choose another semester 😋',
      name: 'scoreEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Midterm`
  String get midtermScore {
    return Intl.message(
      'Midterm',
      name: 'midtermScore',
      desc: '',
      args: [],
    );
  }

  /// `Final`
  String get finalScore {
    return Intl.message(
      'Final',
      name: 'finalScore',
      desc: '',
      args: [],
    );
  }

  /// `Conduct Score`
  String get conductScore {
    return Intl.message(
      'Conduct Score',
      name: 'conductScore',
      desc: '',
      args: [],
    );
  }

  /// `Credits Taken/Earned`
  String get creditsTakenEarned {
    return Intl.message(
      'Credits Taken/Earned',
      name: 'creditsTakenEarned',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get credits {
    return Intl.message(
      'Credits',
      name: 'credits',
      desc: '',
      args: [],
    );
  }

  /// `Average`
  String get average {
    return Intl.message(
      'Average',
      name: 'average',
      desc: '',
      args: [],
    );
  }

  /// `Rank`
  String get rank {
    return Intl.message(
      'Rank',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `Class Rank`
  String get classRank {
    return Intl.message(
      'Class Rank',
      name: 'classRank',
      desc: '',
      args: [],
    );
  }

  /// `Department Rank`
  String get departmentRank {
    return Intl.message(
      'Department Rank',
      name: 'departmentRank',
      desc: '',
      args: [],
    );
  }

  /// `Total Classmates`
  String get totalClassmates {
    return Intl.message(
      'Total Classmates',
      name: 'totalClassmates',
      desc: '',
      args: [],
    );
  }

  /// `Top % in Class`
  String get percentage {
    return Intl.message(
      'Top % in Class',
      name: 'percentage',
      desc: '',
      args: [],
    );
  }

  /// `Rotate screen to see night school absent record`
  String get leaveNight {
    return Intl.message(
      'Rotate screen to see night school absent record',
      name: 'leaveNight',
      desc: '',
      args: [],
    );
  }

  /// `Oops! No absent record for this semester~\nPlease choose another semester 😋`
  String get leaveNoLeave {
    return Intl.message(
      'Oops! No absent record for this semester~\nPlease choose another semester 😋',
      name: 'leaveNoLeave',
      desc: '',
      args: [],
    );
  }

  /// `Re-login Required`
  String get tokenExpiredTitle {
    return Intl.message(
      'Re-login Required',
      name: 'tokenExpiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cookie has expired, please re-login!`
  String get tokenExpiredContent {
    return Intl.message(
      'Cookie has expired, please re-login!',
      name: 'tokenExpiredContent',
      desc: '',
      args: [],
    );
  }

  /// `Update available for %s!`
  String get updateContent {
    return Intl.message(
      'Update available for %s!',
      name: 'updateContent',
      desc: '',
      args: [],
    );
  }

  /// `Update available for %s!`
  String get updateAndroidContent {
    return Intl.message(
      'Update available for %s!',
      name: 'updateAndroidContent',
      desc: '',
      args: [],
    );
  }

  /// `Update available for %s!`
  String get updateIosContent {
    return Intl.message(
      'Update available for %s!',
      name: 'updateIosContent',
      desc: '',
      args: [],
    );
  }

  /// `Updated`
  String get updateTitle {
    return Intl.message(
      'Updated',
      name: 'updateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon~\nDonate to use this feature now!`
  String get functionNotOpen {
    return Intl.message(
      'Coming Soon~\nDonate to use this feature now!',
      name: 'functionNotOpen',
      desc: '',
      args: [],
    );
  }

  /// `This is a beta version, please report a bug if an error occurred!`
  String get betaFunction {
    return Intl.message(
      'This is a beta version, please report a bug if an error occurred!',
      name: 'betaFunction',
      desc: '',
      args: [],
    );
  }

  /// `You have not chosen a date!\n Please choose a date first %s`
  String get busNotPick {
    return Intl.message(
      'You have not chosen a date!\n Please choose a date first %s',
      name: 'busNotPick',
      desc: '',
      args: [],
    );
  }

  /// `This is not an easter egg`
  String get easterEggJuke {
    return Intl.message(
      'This is not an easter egg',
      name: 'easterEggJuke',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Share to…`
  String get shareTo {
    return Intl.message(
      'Share to…',
      name: 'shareTo',
      desc: '',
      args: [],
    );
  }

  /// `Sent from KUAS AP Android`
  String get sendFrom {
    return Intl.message(
      'Sent from KUAS AP Android',
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

  /// `Help and support the programmer\nto use new features!`
  String get donateContent {
    return Intl.message(
      'Help and support the programmer\nto use new features!',
      name: 'donateContent',
      desc: '',
      args: [],
    );
  }

  /// `Reminder will pop up 30 mins before reserved bus !\nIf you reserved or canceled the seat via website, please restart the app.`
  String get busNotifyHint {
    return Intl.message(
      'Reminder will pop up 30 mins before reserved bus !\nIf you reserved or canceled the seat via website, please restart the app.',
      name: 'busNotifyHint',
      desc: '',
      args: [],
    );
  }

  /// `You"ve got a bus departing at %s from %s!`
  String get busNotifyContent {
    return Intl.message(
      'You"ve got a bus departing at %s from %s!',
      name: 'busNotifyContent',
      desc: '',
      args: [],
    );
  }

  /// `JianGong`
  String get busNotifyJiangong {
    return Intl.message(
      'JianGong',
      name: 'busNotifyJiangong',
      desc: '',
      args: [],
    );
  }

  /// `YanChao`
  String get busNotifyYanchao {
    return Intl.message(
      'YanChao',
      name: 'busNotifyYanchao',
      desc: '',
      args: [],
    );
  }

  /// `Will turn on silent mode during class, turn back to normal mode after class!`
  String get courseVibrateHint {
    return Intl.message(
      'Will turn on silent mode during class, turn back to normal mode after class!',
      name: 'courseVibrateHint',
      desc: '',
      args: [],
    );
  }

  /// `Need "Do Not Disturb access" to auto mute.`
  String get courseVibratePermission {
    return Intl.message(
      'Need "Do Not Disturb access" to auto mute.',
      name: 'courseVibratePermission',
      desc: '',
      args: [],
    );
  }

  /// `Reminder will pop up 10mins before class starts!`
  String get courseNotifyHint {
    return Intl.message(
      'Reminder will pop up 10mins before class starts!',
      name: 'courseNotifyHint',
      desc: '',
      args: [],
    );
  }

  /// `Class %s will be at room %s!`
  String get courseNotifyContent {
    return Intl.message(
      'Class %s will be at room %s!',
      name: 'courseNotifyContent',
      desc: '',
      args: [],
    );
  }

  /// `Outerspace~`
  String get courseNotifyUnknown {
    return Intl.message(
      'Outerspace~',
      name: 'courseNotifyUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Oops! No class need notify~`
  String get courseNotifyEmpty {
    return Intl.message(
      'Oops! No class need notify~',
      name: 'courseNotifyEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something was wrong~`
  String get courseNotifyError {
    return Intl.message(
      'Oops! Something was wrong~',
      name: 'courseNotifyError',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Success`
  String get cancelNotifySuccess {
    return Intl.message(
      'Cancel Success',
      name: 'cancelNotifySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Can"t found any calendar apps.`
  String get calendarAppNotFound {
    return Intl.message(
      'Can"t found any calendar apps.',
      name: 'calendarAppNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get goToSettings {
    return Intl.message(
      'Settings',
      name: 'goToSettings',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get notifications {
    return Intl.message(
      'News',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Tel no.`
  String get phones {
    return Intl.message(
      'Tel no.',
      name: 'phones',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message(
      'Events',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `Scheme`
  String get educationSystem {
    return Intl.message(
      'Scheme',
      name: 'educationSystem',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message(
      'Department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `Class`
  String get studentClass {
    return Intl.message(
      'Class',
      name: 'studentClass',
      desc: '',
      args: [],
    );
  }

  /// `Student ID`
  String get studentId {
    return Intl.message(
      'Student ID',
      name: 'studentId',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get studentNameCht {
    return Intl.message(
      'Name',
      name: 'studentNameCht',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notificationItem {
    return Intl.message(
      'Notification',
      name: 'notificationItem',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get otherInfo {
    return Intl.message(
      'Other',
      name: 'otherInfo',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get otherSettings {
    return Intl.message(
      'Settings',
      name: 'otherSettings',
      desc: '',
      args: [],
    );
  }

  /// `Environment`
  String get environmentSettings {
    return Intl.message(
      'Environment',
      name: 'environmentSettings',
      desc: '',
      args: [],
    );
  }

  /// `Show Photo`
  String get headPhotoSetting {
    return Intl.message(
      'Show Photo',
      name: 'headPhotoSetting',
      desc: '',
      args: [],
    );
  }

  /// `Side menu shows the photo sticker`
  String get headPhotoSettingSubTitle {
    return Intl.message(
      'Side menu shows the photo sticker',
      name: 'headPhotoSettingSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Class Reminder`
  String get courseNotify {
    return Intl.message(
      'Class Reminder',
      name: 'courseNotify',
      desc: '',
      args: [],
    );
  }

  /// `Reminder 10mins before class starts`
  String get courseNotifySubTitle {
    return Intl.message(
      'Reminder 10mins before class starts',
      name: 'courseNotifySubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Silent Mode During Class`
  String get courseVibrate {
    return Intl.message(
      'Silent Mode During Class',
      name: 'courseVibrate',
      desc: '',
      args: [],
    );
  }

  /// `Bus Reservation Reminder`
  String get busNotify {
    return Intl.message(
      'Bus Reservation Reminder',
      name: 'busNotify',
      desc: '',
      args: [],
    );
  }

  /// `Reminder 30 mins before reserved bus`
  String get busNotifySubTitle {
    return Intl.message(
      'Reminder 30 mins before reserved bus',
      name: 'busNotifySubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions`
  String get feedback {
    return Intl.message(
      'Suggestions',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Message to Facebook Page`
  String get feedbackViaFacebook {
    return Intl.message(
      'Message to Facebook Page',
      name: 'feedbackViaFacebook',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get appVersion {
    return Intl.message(
      'App Version',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `The best KUAS Campus App\nKUAS AP\n\nAre you afreshman?\nDon"t know about school info, telephone numbers, or up coming events?\nBeenhere a few years?\nHave checking class schedule, report card and reserving bus seatsdrove you crazy?\n\nNo more, no more worries, anymore!\n\nKUAS AP lets no matter old or newfellow\nhave control over your life in KUAS!\n\nFrom checking class schedule, report card toyour absence records!\nPlus reserving/canceling bus seats with newest school feeds!\n\n\n\nMuch Simple, Many Convenient, Very instinct, wow!\n\n☆FABULOUS☆`
  String get aboutDetail {
    return Intl.message(
      'The best KUAS Campus App\nKUAS AP\n\nAre you afreshman?\nDon"t know about school info, telephone numbers, or up coming events?\nBeenhere a few years?\nHave checking class schedule, report card and reserving bus seatsdrove you crazy?\n\nNo more, no more worries, anymore!\n\nKUAS AP lets no matter old or newfellow\nhave control over your life in KUAS!\n\nFrom checking class schedule, report card toyour absence records!\nPlus reserving/canceling bus seats with newest school feeds!\n\n\n\nMuch Simple, Many Convenient, Very instinct, wow!\n\n☆FABULOUS☆',
      name: 'aboutDetail',
      desc: '',
      args: [],
    );
  }

  /// `Made by`
  String get aboutAuthorTitle {
    return Intl.message(
      'Made by',
      name: 'aboutAuthorTitle',
      desc: '',
      args: [],
    );
  }

  /// `高科校務通v1 & v2\n呂紹榕(Louie Lu), 姜尚德(JohnThunder), \nregisterAutumn, 詹濬鍵(Evans), \n陳建霖(HearSilent), 陳冠蓁, 徐羽柔\n高科校務通v3\n房志剛(Rainvisitor),林義翔(takidog)\n林鈺軒(Lin YuHsuan),周鈺禮(Gary)\n中山校務通\n房志剛(Rainvisitor),胡智強（JohnHuCC)\n台科校務通\n房志剛(Rainvisitor),林義翔(takidog)`
  String get aboutAuthorContent {
    return Intl.message(
      '高科校務通v1 & v2\n呂紹榕(Louie Lu), 姜尚德(JohnThunder), \nregisterAutumn, 詹濬鍵(Evans), \n陳建霖(HearSilent), 陳冠蓁, 徐羽柔\n高科校務通v3\n房志剛(Rainvisitor),林義翔(takidog)\n林鈺軒(Lin YuHsuan),周鈺禮(Gary)\n中山校務通\n房志剛(Rainvisitor),胡智強（JohnHuCC)\n台科校務通\n房志剛(Rainvisitor),林義翔(takidog)',
      name: 'aboutAuthorContent',
      desc: '',
      args: [],
    );
  }

  /// `“Ask not why nobody is doing this. You are "nobody".”\n\nWe did this cause no one did it.\nWe created KUAS Wifi Login, KUASAP and KUAS Gourmet, Course Selection Sim, etc&#8230;\nTo bring convenience to everyone"s on campus!`
  String get aboutUsContent {
    return Intl.message(
      '“Ask not why nobody is doing this. You are "nobody".”\n\nWe did this cause no one did it.\nWe created KUAS Wifi Login, KUASAP and KUAS Gourmet, Course Selection Sim, etc&#8230;\nTo bring convenience to everyone"s on campus!',
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

  /// `If you"re experienced in Objective-C, Swift, Java or you"re interested in Coding!\n\nMessage us at our Facebook fanpage!\nYour code might one day be operating in everyone"s hands~`
  String get aboutRecruitContent {
    return Intl.message(
      'If you"re experienced in Objective-C, Swift, Java or you"re interested in Coding!\n\nMessage us at our Facebook fanpage!\nYour code might one day be operating in everyone"s hands~',
      name: 'aboutRecruitContent',
      desc: '',
      args: [],
    );
  }

  /// `In year 2014,\nwe founded KUAS Information Technology Club!\n\nIf you"re enthusiastic or drawn to our projects, join our classes and talks or come by to chat!`
  String get aboutItcContent {
    return Intl.message(
      'In year 2014,\nwe founded KUAS Information Technology Club!\n\nIf you"re enthusiastic or drawn to our projects, join our classes and talks or come by to chat!',
      name: 'aboutItcContent',
      desc: '',
      args: [],
    );
  }

  /// `NKUST IT Club`
  String get aboutItcTitle {
    return Intl.message(
      'NKUST IT Club',
      name: 'aboutItcTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get aboutContactUs {
    return Intl.message(
      'Contact Us',
      name: 'aboutContactUs',
      desc: '',
      args: [],
    );
  }

  /// `Open Source License`
  String get aboutOpenSourceTitle {
    return Intl.message(
      'Open Source License',
      name: 'aboutOpenSourceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open Menu`
  String get openDrawer {
    return Intl.message(
      'Open Menu',
      name: 'openDrawer',
      desc: '',
      args: [],
    );
  }

  /// `Close Menu`
  String get closeDrawer {
    return Intl.message(
      'Close Menu',
      name: 'closeDrawer',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get announcements {
    return Intl.message(
      'News',
      name: 'announcements',
      desc: '',
      args: [],
    );
  }

  /// `Offline Class Schedule`
  String get offlineCourse {
    return Intl.message(
      'Offline Class Schedule',
      name: 'offlineCourse',
      desc: '',
      args: [],
    );
  }

  /// `Course info`
  String get courseInfo {
    return Intl.message(
      'Course info',
      name: 'courseInfo',
      desc: '',
      args: [],
    );
  }

  /// `Class Schedule`
  String get course {
    return Intl.message(
      'Class Schedule',
      name: 'course',
      desc: '',
      args: [],
    );
  }

  /// `Report Card`
  String get score {
    return Intl.message(
      'Report Card',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `Absent System`
  String get leave {
    return Intl.message(
      'Absent System',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Bus Reservation`
  String get bus {
    return Intl.message(
      'Bus Reservation',
      name: 'bus',
      desc: '',
      args: [],
    );
  }

  /// `Course Selection Sim`
  String get simcourse {
    return Intl.message(
      'Course Selection Sim',
      name: 'simcourse',
      desc: '',
      args: [],
    );
  }

  /// `School Info`
  String get schoolInfo {
    return Intl.message(
      'School Info',
      name: 'schoolInfo',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get userInfo {
    return Intl.message(
      'Personal Info',
      name: 'userInfo',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get about {
    return Intl.message(
      'About Us',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guest {
    return Intl.message(
      'Guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Tap to Login`
  String get tapHereToLogin {
    return Intl.message(
      'Tap to Login',
      name: 'tapHereToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Choose Semester`
  String get pickSemester {
    return Intl.message(
      'Choose Semester',
      name: 'pickSemester',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your ID`
  String get enterUsernameHint {
    return Intl.message(
      'Please enter your ID',
      name: 'enterUsernameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get enterPasswordHint {
    return Intl.message(
      'Please enter your password',
      name: 'enterPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Check your username and password then retry`
  String get checkLoginHint {
    return Intl.message(
      'Check your username and password then retry',
      name: 'checkLoginHint',
      desc: '',
      args: [],
    );
  }

  /// `From JianGong`
  String get fromJiangong {
    return Intl.message(
      'From JianGong',
      name: 'fromJiangong',
      desc: '',
      args: [],
    );
  }

  /// `From YanChao`
  String get fromYanchao {
    return Intl.message(
      'From YanChao',
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

  /// `Mon.`
  String get mon {
    return Intl.message(
      'Mon.',
      name: 'mon',
      desc: '',
      args: [],
    );
  }

  /// `Tue.`
  String get tue {
    return Intl.message(
      'Tue.',
      name: 'tue',
      desc: '',
      args: [],
    );
  }

  /// `Wed.`
  String get wed {
    return Intl.message(
      'Wed.',
      name: 'wed',
      desc: '',
      args: [],
    );
  }

  /// `Thu.`
  String get thu {
    return Intl.message(
      'Thu.',
      name: 'thu',
      desc: '',
      args: [],
    );
  }

  /// `Fri.`
  String get fri {
    return Intl.message(
      'Fri.',
      name: 'fri',
      desc: '',
      args: [],
    );
  }

  /// `Sat.`
  String get sat {
    return Intl.message(
      'Sat.',
      name: 'sat',
      desc: '',
      args: [],
    );
  }

  /// `Sun.`
  String get sun {
    return Intl.message(
      'Sun.',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get monday {
    return Intl.message(
      'Mon',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get tuesday {
    return Intl.message(
      'Tue',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get wednesday {
    return Intl.message(
      'Wed',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get thursday {
    return Intl.message(
      'Thu',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get friday {
    return Intl.message(
      'Fri',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get saturday {
    return Intl.message(
      'Sat',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sunday {
    return Intl.message(
      'Sun',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get units {
    return Intl.message(
      'Units',
      name: 'units',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get courseHours {
    return Intl.message(
      'Hours',
      name: 'courseHours',
      desc: '',
      args: [],
    );
  }

  /// `Don"t Empty`
  String get doNotEmpty {
    return Intl.message(
      'Don"t Empty',
      name: 'doNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `student id or password error or this student id is not available`
  String get loginFail {
    return Intl.message(
      'student id or password error or this student id is not available',
      name: 'loginFail',
      desc: '',
      args: [],
    );
  }

  /// `Bus system perhaps broken!!!`
  String get busFailInfinity {
    return Intl.message(
      'Bus system perhaps broken!!!',
      name: 'busFailInfinity',
      desc: '',
      args: [],
    );
  }

  /// `Reserving...`
  String get reserving {
    return Intl.message(
      'Reserving...',
      name: 'reserving',
      desc: '',
      args: [],
    );
  }

  /// `Canceling...`
  String get canceling {
    return Intl.message(
      'Canceling...',
      name: 'canceling',
      desc: '',
      args: [],
    );
  }

  /// `Calculating...`
  String get calculating {
    return Intl.message(
      'Calculating...',
      name: 'calculating',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Units`
  String get calculateUnits {
    return Intl.message(
      'Calculate Units',
      name: 'calculateUnits',
      desc: '',
      args: [],
    );
  }

  /// `Begin Calculate`
  String get beginCalculate {
    return Intl.message(
      'Begin Calculate',
      name: 'beginCalculate',
      desc: '',
      args: [],
    );
  }

  /// `Calculation is for reference only`
  String get calculateUnitsContent {
    return Intl.message(
      'Calculation is for reference only',
      name: 'calculateUnitsContent',
      desc: '',
      args: [],
    );
  }

  /// `General education course`
  String get generalEductionCourse {
    return Intl.message(
      'General education course',
      name: 'generalEductionCourse',
      desc: '',
      args: [],
    );
  }

  /// `This account can"t use this feature or school system happend error`
  String get canNotUseFeature {
    return Intl.message(
      'This account can"t use this feature or school system happend error',
      name: 'canNotUseFeature',
      desc: '',
      args: [],
    );
  }

  /// `Add Success`
  String get addSuccess {
    return Intl.message(
      'Add Success',
      name: 'addSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Absent apply`
  String get leaveApply {
    return Intl.message(
      'Absent apply',
      name: 'leaveApply',
      desc: '',
      args: [],
    );
  }

  /// `Absent records`
  String get leaveRecords {
    return Intl.message(
      'Absent records',
      name: 'leaveRecords',
      desc: '',
      args: [],
    );
  }

  /// `Absent Content`
  String get leaveContent {
    return Intl.message(
      'Absent Content',
      name: 'leaveContent',
      desc: '',
      args: [],
    );
  }

  /// `Sheet id`
  String get leaveSheetId {
    return Intl.message(
      'Sheet id',
      name: 'leaveSheetId',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get instructorsComment {
    return Intl.message(
      'Comment',
      name: 'instructorsComment',
      desc: '',
      args: [],
    );
  }

  /// `Load offline data`
  String get loadOfflineData {
    return Intl.message(
      'Load offline data',
      name: 'loadOfflineData',
      desc: '',
      args: [],
    );
  }

  /// `Reserve Deadline`
  String get reserveDeadline {
    return Intl.message(
      'Reserve Deadline',
      name: 'reserveDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Bus Rule`
  String get busRule {
    return Intl.message(
      'Bus Rule',
      name: 'busRule',
      desc: '',
      args: [],
    );
  }

  /// `Current platform can"t use this feature.`
  String get platformError {
    return Intl.message(
      'Current platform can"t use this feature.',
      name: 'platformError',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get choseLanguageTitle {
    return Intl.message(
      'Language',
      name: 'choseLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `System Language`
  String get systemLanguage {
    return Intl.message(
      'System Language',
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

  /// `Rate App`
  String get ratingDialogTitle {
    return Intl.message(
      'Rate App',
      name: 'ratingDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you like NKUST APP?\nPlease write a comment and rating on the store\nThis is our motivation!`
  String get ratingDialogContent {
    return Intl.message(
      'Do you like NKUST APP?\nPlease write a comment and rating on the store\nThis is our motivation!',
      name: 'ratingDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `LATER`
  String get later {
    return Intl.message(
      'LATER',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `RATE NOW`
  String get rateNow {
    return Intl.message(
      'RATE NOW',
      name: 'rateNow',
      desc: '',
      args: [],
    );
  }

  /// `Offline Login`
  String get offlineLogin {
    return Intl.message(
      'Offline Login',
      name: 'offlineLogin',
      desc: '',
      args: [],
    );
  }

  /// `No Offline login data, please login at least once.`
  String get noOfflineLoginData {
    return Intl.message(
      'No Offline login data, please login at least once.',
      name: 'noOfflineLoginData',
      desc: '',
      args: [],
    );
  }

  /// `Offline login username or password Error`
  String get offlineLoginPasswordError {
    return Intl.message(
      'Offline login username or password Error',
      name: 'offlineLoginPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Offline Mode`
  String get offlineMode {
    return Intl.message(
      'Offline Mode',
      name: 'offlineMode',
      desc: '',
      args: [],
    );
  }

  /// `No offline data`
  String get noOfflineData {
    return Intl.message(
      'No offline data',
      name: 'noOfflineData',
      desc: '',
      args: [],
    );
  }

  /// `Offline Score`
  String get offlineScore {
    return Intl.message(
      'Offline Score',
      name: 'offlineScore',
      desc: '',
      args: [],
    );
  }

  /// `Offline Bus Reservations`
  String get offlineBusReservations {
    return Intl.message(
      'Offline Bus Reservations',
      name: 'offlineBusReservations',
      desc: '',
      args: [],
    );
  }

  /// `Offline absent Report`
  String get offlineLeaveData {
    return Intl.message(
      'Offline absent Report',
      name: 'offlineLeaveData',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get noData {
    return Intl.message(
      'No Data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contactFansPage {
    return Intl.message(
      'Contact',
      name: 'contactFansPage',
      desc: '',
      args: [],
    );
  }

  /// `News publication rules`
  String get newsRuleTitle {
    return Intl.message(
      'News publication rules',
      name: 'newsRuleTitle',
      desc: '',
      args: [],
    );
  }

  /// `This feature provides information about the school or student"s publication of the school.\n\nPlease contact the fan page if you need it\n`
  String get newsRuleDescription1 {
    return Intl.message(
      'This feature provides information about the school or student"s publication of the school.\n\nPlease contact the fan page if you need it\n',
      name: 'newsRuleDescription1',
      desc: '',
      args: [],
    );
  }

  /// `1. Image and upload to imgur, please use JPEG compressed file. It is recommended not to exceed 100KB. \n2. The title suggests placing the name of the event, not too long. \n3. Activity URL link. \n4. Description of the content. \n5. Must be a non-profit activity.\n\n`
  String get newsRuleDescription2 {
    return Intl.message(
      '1. Image and upload to imgur, please use JPEG compressed file. It is recommended not to exceed 100KB. \n2. The title suggests placing the name of the event, not too long. \n3. Activity URL link. \n4. Description of the content. \n5. Must be a non-profit activity.\n\n',
      name: 'newsRuleDescription2',
      desc: '',
      args: [],
    );
  }

  /// `The NKUST AP team has the final right to modify.`
  String get newsRuleDescription3 {
    return Intl.message(
      'The NKUST AP team has the final right to modify.',
      name: 'newsRuleDescription3',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `System Theme`
  String get systemTheme {
    return Intl.message(
      'System Theme',
      name: 'systemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Icon Style`
  String get iconStyle {
    return Intl.message(
      'Icon Style',
      name: 'iconStyle',
      desc: '',
      args: [],
    );
  }

  /// `Filled`
  String get filled {
    return Intl.message(
      'Filled',
      name: 'filled',
      desc: '',
      args: [],
    );
  }

  /// `Outlined`
  String get outlined {
    return Intl.message(
      'Outlined',
      name: 'outlined',
      desc: '',
      args: [],
    );
  }

  /// `Search Student ID`
  String get searchUsername {
    return Intl.message(
      'Search Student ID',
      name: 'searchUsername',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `id`
  String get id {
    return Intl.message(
      'id',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get searchResult {
    return Intl.message(
      'Result',
      name: 'searchResult',
      desc: '',
      args: [],
    );
  }

  /// `Auto Fill`
  String get autoFill {
    return Intl.message(
      'Auto Fill',
      name: 'autoFill',
      desc: '',
      args: [],
    );
  }

  /// `For first-time login, please fill in the last four number of your ID as your password`
  String get firstLoginHint {
    return Intl.message(
      'For first-time login, please fill in the last four number of your ID as your password',
      name: 'firstLoginHint',
      desc: '',
      args: [],
    );
  }

  /// `Name：%s\nStudent ID：%s\n`
  String get searchStudentIdFormat {
    return Intl.message(
      'Name：%s\nStudent ID：%s\n',
      name: 'searchStudentIdFormat',
      desc: '',
      args: [],
    );
  }

  /// `Search no data.`
  String get searchStudentIdError {
    return Intl.message(
      'Search no data.',
      name: 'searchStudentIdError',
      desc: '',
      args: [],
    );
  }

  /// `Midterm Alerts`
  String get midtermAlerts {
    return Intl.message(
      'Midterm Alerts',
      name: 'midtermAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Very Good！ No Midterm warning class for this semester~\n Please choose another semester 😋`
  String get midtermAlertsEmpty {
    return Intl.message(
      'Very Good！ No Midterm warning class for this semester~\n Please choose another semester 😋',
      name: 'midtermAlertsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Reason：%s\nRemark：%s`
  String get midtermAlertsContent {
    return Intl.message(
      'Reason：%s\nRemark：%s',
      name: 'midtermAlertsContent',
      desc: '',
      args: [],
    );
  }

  /// `Reward and Penalty`
  String get rewardAndPenalty {
    return Intl.message(
      'Reward and Penalty',
      name: 'rewardAndPenalty',
      desc: '',
      args: [],
    );
  }

  /// `Oops！No reward and penalty for this semester~\n Please choose another semester 😋`
  String get rewardAndPenaltyEmpty {
    return Intl.message(
      'Oops！No reward and penalty for this semester~\n Please choose another semester 😋',
      name: 'rewardAndPenaltyEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Counts：%s\nDate：%s`
  String get rewardAndPenaltyContent {
    return Intl.message(
      'Counts：%s\nDate：%s',
      name: 'rewardAndPenaltyContent',
      desc: '',
      args: [],
    );
  }

  /// `Campus not support this feature ~`
  String get campusNotSupport {
    return Intl.message(
      'Campus not support this feature ~',
      name: 'campusNotSupport',
      desc: '',
      args: [],
    );
  }

  /// `User can"t use this feature ~`
  String get userNotSupport {
    return Intl.message(
      'User can"t use this feature ~',
      name: 'userNotSupport',
      desc: '',
      args: [],
    );
  }

  /// `Not Login`
  String get notLogin {
    return Intl.message(
      'Not Login',
      name: 'notLogin',
      desc: '',
      args: [],
    );
  }

  /// `Not Login, please check login status.`
  String get notLoginHint {
    return Intl.message(
      'Not Login, please check login status.',
      name: 'notLoginHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Date`
  String get addDate {
    return Intl.message(
      'Add Date',
      name: 'addDate',
      desc: '',
      args: [],
    );
  }

  /// `Tutor`
  String get tutor {
    return Intl.message(
      'Tutor',
      name: 'tutor',
      desc: '',
      args: [],
    );
  }

  /// `Leave Type`
  String get leaveType {
    return Intl.message(
      'Leave Type',
      name: 'leaveType',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `Delay Reason`
  String get delayReason {
    return Intl.message(
      'Delay Reason',
      name: 'delayReason',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Uploading\nPlease waiting for finish before close App`
  String get leaveSubmitUploadHint {
    return Intl.message(
      'Uploading\nPlease waiting for finish before close App',
      name: 'leaveSubmitUploadHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Teacher`
  String get teacher {
    return Intl.message(
      'Teacher',
      name: 'teacher',
      desc: '',
      args: [],
    );
  }

  /// `Pick Teacher`
  String get pickTeacher {
    return Intl.message(
      'Pick Teacher',
      name: 'pickTeacher',
      desc: '',
      args: [],
    );
  }

  /// `Leave Proof`
  String get leaveProof {
    return Intl.message(
      'Leave Proof',
      name: 'leaveProof',
      desc: '',
      args: [],
    );
  }

  /// `Please Pick one`
  String get pleasePick {
    return Intl.message(
      'Please Pick one',
      name: 'pleasePick',
      desc: '',
      args: [],
    );
  }

  /// `Please pick date and section.`
  String get pleasePickDateAndSection {
    return Intl.message(
      'Please pick date and section.',
      name: 'pleasePickDateAndSection',
      desc: '',
      args: [],
    );
  }

  /// `Leave submit successful.`
  String get leaveSubmitSuccess {
    return Intl.message(
      'Leave submit successful.',
      name: 'leaveSubmitSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Because over time, need to fill delay reason.`
  String get leaveDelayHint {
    return Intl.message(
      'Because over time, need to fill delay reason.',
      name: 'leaveDelayHint',
      desc: '',
      args: [],
    );
  }

  /// `Please pick image`
  String get leaveProofHint {
    return Intl.message(
      'Please pick image',
      name: 'leaveProofHint',
      desc: '',
      args: [],
    );
  }

  /// `Because file big than %.1fMB, so compress to %.2f MB`
  String get imageCompressHint {
    return Intl.message(
      'Because file big than %.1fMB, so compress to %.2f MB',
      name: 'imageCompressHint',
      desc: '',
      args: [],
    );
  }

  /// `Image size must below %.1fMB, Plese pick another one.`
  String get imageTooBigHint {
    return Intl.message(
      'Image size must below %.1fMB, Plese pick another one.',
      name: 'imageTooBigHint',
      desc: '',
      args: [],
    );
  }

  /// `Date & Section`
  String get leaveDateAndSection {
    return Intl.message(
      'Date & Section',
      name: 'leaveDateAndSection',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Leave Submit`
  String get leaveSubmit {
    return Intl.message(
      'Leave Submit',
      name: 'leaveSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to leave App?`
  String get leaveAppHint {
    return Intl.message(
      'Do you want to leave App?',
      name: 'leaveAppHint',
      desc: '',
      args: [],
    );
  }

  /// `Close App`
  String get closeAppTitle {
    return Intl.message(
      'Close App',
      name: 'closeAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to close App?`
  String get closeAppHint {
    return Intl.message(
      'Do you want to close App?',
      name: 'closeAppHint',
      desc: '',
      args: [],
    );
  }

  /// `Oops Leaves Submit Fail!`
  String get leaveSubmitFail {
    return Intl.message(
      'Oops Leaves Submit Fail!',
      name: 'leaveSubmitFail',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Image Link`
  String get imageUrl {
    return Intl.message(
      'Image Link',
      name: 'imageUrl',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get url {
    return Intl.message(
      'Link',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `Expire Time`
  String get expireTime {
    return Intl.message(
      'Expire Time',
      name: 'expireTime',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Weight：%d\nImage Link：%s\nLink：%s\nExpire Time：%s\nDescription：%s`
  String get newsContentFormat {
    return Intl.message(
      'Weight：%d\nImage Link：%s\nLink：%s\nExpire Time：%s\nDescription：%s',
      name: 'newsContentFormat',
      desc: '',
      args: [],
    );
  }

  /// `Delete News`
  String get deleteNewsTitle {
    return Intl.message(
      'Delete News',
      name: 'deleteNewsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sure delete?`
  String get deleteNewsContent {
    return Intl.message(
      'Sure delete?',
      name: 'deleteNewsContent',
      desc: '',
      args: [],
    );
  }

  /// `Delete Success`
  String get deleteSuccess {
    return Intl.message(
      'Delete Success',
      name: 'deleteSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update Success`
  String get updateSuccess {
    return Intl.message(
      'Update Success',
      name: 'updateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Format Error`
  String get formatError {
    return Intl.message(
      'Format Error',
      name: 'formatError',
      desc: '',
      args: [],
    );
  }

  /// `No expiration time, please pick time.`
  String get newsExpireTimeHint {
    return Intl.message(
      'No expiration time, please pick time.',
      name: 'newsExpireTimeHint',
      desc: '',
      args: [],
    );
  }

  /// `Set No Expiration Time`
  String get setNoExpireTime {
    return Intl.message(
      'Set No Expiration Time',
      name: 'setNoExpireTime',
      desc: '',
      args: [],
    );
  }

  /// `No Expiration`
  String get noExpiration {
    return Intl.message(
      'No Expiration',
      name: 'noExpiration',
      desc: '',
      args: [],
    );
  }

  /// `Show Search Button`
  String get showSearchButton {
    return Intl.message(
      'Show Search Button',
      name: 'showSearchButton',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `School Navigation`
  String get schoolNavigation {
    return Intl.message(
      'School Navigation',
      name: 'schoolNavigation',
      desc: '',
      args: [],
    );
  }

  /// `School Map`
  String get schoolMap {
    return Intl.message(
      'School Map',
      name: 'schoolMap',
      desc: '',
      args: [],
    );
  }

  /// `Birth Month`
  String get birthMonth {
    return Intl.message(
      'Birth Month',
      name: 'birthMonth',
      desc: '',
      args: [],
    );
  }

  /// `Birth Day`
  String get birthDay {
    return Intl.message(
      'Birth Day',
      name: 'birthDay',
      desc: '',
      args: [],
    );
  }

  /// `ID card`
  String get idCardLastCode {
    return Intl.message(
      'ID card',
      name: 'idCardLastCode',
      desc: '',
      args: [],
    );
  }

  /// `Captcha`
  String get captcha {
    return Intl.message(
      'Captcha',
      name: 'captcha',
      desc: '',
      args: [],
    );
  }

  /// `Username Error`
  String get usernameError {
    return Intl.message(
      'Username Error',
      name: 'usernameError',
      desc: '',
      args: [],
    );
  }

  /// `Captcha Error`
  String get captchaError {
    return Intl.message(
      'Captcha Error',
      name: 'captchaError',
      desc: '',
      args: [],
    );
  }

  /// `Password Error`
  String get passwordError {
    return Intl.message(
      'Password Error',
      name: 'passwordError',
      desc: '',
      args: [],
    );
  }

  /// `Unkwon Error`
  String get unknownError {
    return Intl.message(
      'Unkwon Error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Only current student`
  String get onlySupportInSchool {
    return Intl.message(
      'Only current student',
      name: 'onlySupportInSchool',
      desc: '',
      args: [],
    );
  }

  /// `Admission Guide`
  String get admissionGuide {
    return Intl.message(
      'Admission Guide',
      name: 'admissionGuide',
      desc: '',
      args: [],
    );
  }

  /// `Printing`
  String get printing {
    return Intl.message(
      'Printing',
      name: 'printing',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get changeEmail {
    return Intl.message(
      'Change Email',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Add to Calendar`
  String get addToCalendar {
    return Intl.message(
      'Add to Calendar',
      name: 'addToCalendar',
      desc: '',
      args: [],
    );
  }

  /// `AP Server Error\nPlease report to fans page`
  String get apiServerError {
    return Intl.message(
      'AP Server Error\nPlease report to fans page',
      name: 'apiServerError',
      desc: '',
      args: [],
    );
  }

  /// `School Server Error\nPlease report to school`
  String get schoolServerError {
    return Intl.message(
      'School Server Error\nPlease report to school',
      name: 'schoolServerError',
      desc: '',
      args: [],
    );
  }

  /// `Classoom List`
  String get roomList {
    return Intl.message(
      'Classoom List',
      name: 'roomList',
      desc: '',
      args: [],
    );
  }

  /// `Empty classroom search`
  String get emptyClassroomSearch {
    return Intl.message(
      'Empty classroom search',
      name: 'emptyClassroomSearch',
      desc: '',
      args: [],
    );
  }

  /// `Classroom Coursetable Search`
  String get classroomCoursetableSearch {
    return Intl.message(
      'Classroom Coursetable Search',
      name: 'classroomCoursetableSearch',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<ApLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
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