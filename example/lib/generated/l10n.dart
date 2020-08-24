// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class AppLocalizations {
  AppLocalizations();
  
  static AppLocalizations current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      AppLocalizations.current = AppLocalizations();
      
      return AppLocalizations.current;
    });
  } 

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `NKUST AP`
  String get appName {
    return Intl.message(
      'NKUST AP',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `* Fix a part of school affairs system feature.`
  String get updateNoteContent {
    return Intl.message(
      '* Fix a part of school affairs system feature.',
      name: 'updateNoteContent',
      desc: '',
      args: [],
    );
  }

  /// `https://github.com/NKUST-ITC/NKUST-AP-Flutter\n\nThis project is licensed under the terms of the MIT license:\nThe MIT License (MIT)\n\nCopyright © 2018 Rainvisitor\n\nThis project is Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.`
  String get aboutOpenSourceContent {
    return Intl.message(
      'https://github.com/NKUST-ITC/NKUST-AP-Flutter\n\nThis project is licensed under the terms of the MIT license:\nThe MIT License (MIT)\n\nCopyright © 2018 Rainvisitor\n\nThis project is Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.',
      name: 'aboutOpenSourceContent',
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

  /// `To YanChao, Scheduled date：`
  String get busJiangongReservations {
    return Intl.message(
      'To YanChao, Scheduled date：',
      name: 'busJiangongReservations',
      desc: '',
      args: [],
    );
  }

  /// `To JianGong, Scheduled date：`
  String get busYanchaoReservations {
    return Intl.message(
      'To JianGong, Scheduled date：',
      name: 'busYanchaoReservations',
      desc: '',
      args: [],
    );
  }

  /// `To YanChao, Departure time：`
  String get busJiangong {
    return Intl.message(
      'To YanChao, Departure time：',
      name: 'busJiangong',
      desc: '',
      args: [],
    );
  }

  /// `To JianGong, Departure time：`
  String get busYanchao {
    return Intl.message(
      'To JianGong, Departure time：',
      name: 'busYanchao',
      desc: '',
      args: [],
    );
  }

  /// `√ To YanChao, Departure time：`
  String get busJiangongReserved {
    return Intl.message(
      '√ To YanChao, Departure time：',
      name: 'busJiangongReserved',
      desc: '',
      args: [],
    );
  }

  /// `√ To JianGong, Departure time：`
  String get busYanchaoReserved {
    return Intl.message(
      '√ To JianGong, Departure time：',
      name: 'busYanchaoReserved',
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

  /// `Bus Penalty`
  String get busViolationRecords {
    return Intl.message(
      'Bus Penalty',
      name: 'busViolationRecords',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid`
  String get unpaid {
    return Intl.message(
      'Unpaid',
      name: 'unpaid',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
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

  /// `JianGong`
  String get jiangong {
    return Intl.message(
      'JianGong',
      name: 'jiangong',
      desc: '',
      args: [],
    );
  }

  /// `YanChao`
  String get yanchao {
    return Intl.message(
      'YanChao',
      name: 'yanchao',
      desc: '',
      args: [],
    );
  }

  /// `first`
  String get first {
    return Intl.message(
      'first',
      name: 'first',
      desc: '',
      args: [],
    );
  }

  /// `Nanzi`
  String get nanzi {
    return Intl.message(
      'Nanzi',
      name: 'nanzi',
      desc: '',
      args: [],
    );
  }

  /// `Qijin`
  String get qijin {
    return Intl.message(
      'Qijin',
      name: 'qijin',
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

  /// `Can't reserve`
  String get canNotReserve {
    return Intl.message(
      'Can\'t reserve',
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

  /// `Oops! You haven't reserved any bus~\n Ride public transport to save the Earth 😋`
  String get busNoReservation {
    return Intl.message(
      'Oops! You haven\'t reserved any bus~\n Ride public transport to save the Earth 😋',
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

  /// `You have not chosen a date!\n Please choose a date first %s`
  String get busNotPick {
    return Intl.message(
      'You have not chosen a date!\n Please choose a date first %s',
      name: 'busNotPick',
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

  /// `Bus Reservation`
  String get bus {
    return Intl.message(
      'Bus Reservation',
      name: 'bus',
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

  /// `From First`
  String get fromFirst {
    return Intl.message(
      'From First',
      name: 'fromFirst',
      desc: '',
      args: [],
    );
  }

  /// `Destination`
  String get destination {
    return Intl.message(
      'Destination',
      name: 'destination',
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

  /// `Bus system perhaps broken!!!`
  String get busFailInfinity {
    return Intl.message(
      'Bus system perhaps broken!!!',
      name: 'busFailInfinity',
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

  /// `No Expiration`
  String get noExpiration {
    return Intl.message(
      'No Expiration',
      name: 'noExpiration',
      desc: '',
      args: [],
    );
  }

  /// `Punch`
  String get punch {
    return Intl.message(
      'Punch',
      name: 'punch',
      desc: '',
      args: [],
    );
  }

  /// `Punch Success`
  String get punchSuccess {
    return Intl.message(
      'Punch Success',
      name: 'punchSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Non Course Time`
  String get nonCourseTime {
    return Intl.message(
      'Non Course Time',
      name: 'nonCourseTime',
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

  /// `Bus Reservation\n`
  String get busRuleResevationRuleTitle {
    return Intl.message(
      'Bus Reservation\n',
      name: 'busRuleResevationRuleTitle',
      desc: '',
      args: [],
    );
  }

  /// `• Go to `
  String get busRuleTravelby {
    return Intl.message(
      '• Go to ',
      name: 'busRuleTravelby',
      desc: '',
      args: [],
    );
  }

  /// ` Bus Reservation System can reserve bus in 14 days\n in need to follow office of general affairs's time requirement\n`
  String get busRuleFourteenDay {
    return Intl.message(
      ' Bus Reservation System can reserve bus in 14 days\n in need to follow office of general affairs\'s time requirement\n',
      name: 'busRuleFourteenDay',
      desc: '',
      args: [],
    );
  }

  /// `■ The classes before 9 A.M.：Please do resevation in 15 hours ago.\n■ The classes after 9 A.M.：Please do resevation in 5 hours ago\n`
  String get busRuleReservationTime {
    return Intl.message(
      '■ The classes before 9 A.M.：Please do resevation in 15 hours ago.\n■ The classes after 9 A.M.：Please do resevation in 5 hours ago\n',
      name: 'busRuleReservationTime',
      desc: '',
      args: [],
    );
  }

  /// `• Cancelation Time\n`
  String get busRuleCancellingTitle {
    return Intl.message(
      '• Cancelation Time\n',
      name: 'busRuleCancellingTitle',
      desc: '',
      args: [],
    );
  }

  /// `■ The classes before 9 A.M.：Please do calcelation in 15 hours ago.\n■ The classes after 9 A.M.：Please do calcelation in 5 hours ago\n`
  String get busRuleCancelingTime {
    return Intl.message(
      '■ The classes before 9 A.M.：Please do calcelation in 15 hours ago.\n■ The classes after 9 A.M.：Please do calcelation in 5 hours ago\n',
      name: 'busRuleCancelingTime',
      desc: '',
      args: [],
    );
  }

  /// `• All students, teachers and staff reserve bus should be follow the rule，if you late or absent from class or work, please be responsible of whatever you do.\n`
  String get busRuleBusRuleFollow {
    return Intl.message(
      '• All students, teachers and staff reserve bus should be follow the rule，if you late or absent from class or work, please be responsible of whatever you do.\n',
      name: 'busRuleBusRuleFollow',
      desc: '',
      args: [],
    );
  }

  /// `Take Bus\n`
  String get busRuleTakeOn {
    return Intl.message(
      'Take Bus\n',
      name: 'busRuleTakeOn',
      desc: '',
      args: [],
    );
  }

  /// `• Every time take bus need pay 20 NTD`
  String get busRuleTwentyDollars {
    return Intl.message(
      '• Every time take bus need pay 20 NTD',
      name: 'busRuleTwentyDollars',
      desc: '',
      args: [],
    );
  }

  /// `（Use coin when you don't got Student ID，Please prepare 20 dollars coin first.）\n`
  String get busRulePrepareCoins {
    return Intl.message(
      '（Use coin when you don\'t got Student ID，Please prepare 20 dollars coin first.）\n',
      name: 'busRulePrepareCoins',
      desc: '',
      args: [],
    );
  }

  /// `• Please take your student or staff ID(Before you get student or staff ID, Please use your ID) take bus\n`
  String get busRuleIdCard {
    return Intl.message(
      '• Please take your student or staff ID(Before you get student or staff ID, Please use your ID) take bus\n',
      name: 'busRuleIdCard',
      desc: '',
      args: [],
    );
  }

  /// `• If you don't take any ID, please line up standby zone\n`
  String get busRuleNoIdCard {
    return Intl.message(
      '• If you don\'t take any ID, please line up standby zone\n',
      name: 'busRuleNoIdCard',
      desc: '',
      args: [],
    );
  }

  /// `Please follow the bus schedule (ex. 8:20 and 9:30 is different class), People can't take bus and get violation point who don	 follow rule.\n`
  String get busRuleFollowingTime {
    return Intl.message(
      'Please follow the bus schedule (ex. 8:20 and 9:30 is different class), People can\'t take bus and get violation point who don	 follow rule.\n',
      name: 'busRuleFollowingTime',
      desc: '',
      args: [],
    );
  }

  /// `• Late or don't reserved passenger, please line up standby zone waiting.\nStandby\n• If you can't pass verification(ex. Don't reserved)，Please change to standby zone waiting.\n• Standby passenger can get on the bus in order after waiting all reserved passangers got on the bus.\n`
  String get busRuleLateAndNoReservation {
    return Intl.message(
      '• Late or don\'t reserved passenger, please line up standby zone waiting.\nStandby\n• If you can\'t pass verification(ex. Don\'t reserved)，Please change to standby zone waiting.\n• Standby passenger can get on the bus in order after waiting all reserved passangers got on the bus.\n',
      name: 'busRuleLateAndNoReservation',
      desc: '',
      args: [],
    );
  }

  /// `Standby\n`
  String get busRuleStandbyTitle {
    return Intl.message(
      'Standby\n',
      name: 'busRuleStandbyTitle',
      desc: '',
      args: [],
    );
  }

  /// `• If you don't take the bus but you reserved already，It's a violation，and you get a violation point(ex. 8:20 and 9:30 is different class\n• If your class teacher take temporary leave、transfer cause you need take the bus early or lately，you need apply to class department then，deparment bus system administator will logout violation.\n`
  String get busRuleStandbyRule {
    return Intl.message(
      '• If you don\'t take the bus but you reserved already，It\'s a violation，and you get a violation point(ex. 8:20 and 9:30 is different class\n• If your class teacher take temporary leave、transfer cause you need take the bus early or lately，you need apply to class department then，deparment bus system administator will logout violation.\n',
      name: 'busRuleStandbyRule',
      desc: '',
      args: [],
    );
  }

  /// `Fine\n`
  String get busRuleFineTitle {
    return Intl.message(
      'Fine\n',
      name: 'busRuleFineTitle',
      desc: '',
      args: [],
    );
  }

  /// `• Fine Calculation，violation times below 3 times don't get point, From 4th violation begin recording point，every point should be pay off fine equal to bus fare.\n• Violation point recording until the end of the semester(1st Semester ended at 1/31，2nd Semester ended at 8/31)，violation point will restart recording. When you not paid off fine，next semester will stop your reservation right until you pay off fine.\n• Go to the auto payment machine or Office of General Affairs cashier pay off fine after you print violation statement by yourself, After paid off, go to Office of General Affairs General Affairs Division write off payment by receipt(Write off payment need receipt on the day.)，After write off and the next day 4A.M. will be reserve class after 9.A.M..\n• If you have any suspicion about violation point，please go to Office of General Affairs General Affairs Division check violation directly in 10 days(included holidays).\n`
  String get busRuleFineRule {
    return Intl.message(
      '• Fine Calculation，violation times below 3 times don\'t get point, From 4th violation begin recording point，every point should be pay off fine equal to bus fare.\n• Violation point recording until the end of the semester(1st Semester ended at 1/31，2nd Semester ended at 8/31)，violation point will restart recording. When you not paid off fine，next semester will stop your reservation right until you pay off fine.\n• Go to the auto payment machine or Office of General Affairs cashier pay off fine after you print violation statement by yourself, After paid off, go to Office of General Affairs General Affairs Division write off payment by receipt(Write off payment need receipt on the day.)，After write off and the next day 4A.M. will be reserve class after 9.A.M..\n• If you have any suspicion about violation point，please go to Office of General Affairs General Affairs Division check violation directly in 10 days(included holidays).\n',
      name: 'busRuleFineRule',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
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