import 'dart:typed_data';

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/models/notification_data.dart';
import 'package:ap_common/models/phone_model.dart';
import 'package:ap_common/scaffold/notification_scaffold.dart';
import 'package:ap_common/scaffold/phone_scaffold.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/scaffold/pdf_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/assets.dart';

class SchoolInfoPage extends StatefulWidget {
  static const String routerName = "/ShcoolInfo";

  @override
  SchoolInfoPageState createState() => SchoolInfoPageState();
}

class SchoolInfoPageState extends State<SchoolInfoPage>
    with SingleTickerProviderStateMixin {
  final phoneModelList = [
    PhoneModel("校安中心\n分機號碼：建工1 楠梓2 第一3 燕巢4 旗津5", "0800-550995"),
    PhoneModel("建工校區", ''),
    PhoneModel("校安專線", "0916-507-506"),
    PhoneModel("事務組", "(07) 381-4526 #2650"),
    PhoneModel("營繕組", "(07) 381-4526 #2630"),
    PhoneModel("課外活動組", "(07) 381-4526 #2525"),
    PhoneModel("諮商輔導中心", "(07) 381-4526 #2541"),
    PhoneModel("圖書館", "(07) 381-4526 #3100"),
    PhoneModel("校外賃居服務中心", "(07) 381-4526 #3420"),
    PhoneModel("燕巢校區", ''),
    PhoneModel("校安專線", "0925-350-995"),
    PhoneModel("校外賃居服務中心", "(07) 381-4526 #8615"),
    PhoneModel("第一校區", ''),
    PhoneModel("生輔組", "(07)601-1000 #31212"),
    PhoneModel("總務處 總機", "(07)601-1000 #31316"),
    PhoneModel("總務處 場地租借", "(07)601-1000 #31312"),
    PhoneModel("總務處 高科大會館", "(07)601-1000 #31306"),
    PhoneModel("總務處 學雜費相關(原事務組)", "(07)601-1000 #31340"),
    PhoneModel("課外活動組", "(07)601-1000 #31211"),
    PhoneModel("諮輔組", "(07)601-1000 #31241"),
    PhoneModel("圖書館", "(07)6011000 #1599"),
    PhoneModel("生輔組", "(07)6011000 #31212"),
    PhoneModel("楠梓校區", ''),
    PhoneModel("總機", "07-3617141"),
    PhoneModel("課外活動組", "07-3617141 #22070"),
    PhoneModel("旗津校區", ''),
    PhoneModel("旗津校區", "07-8100888"),
    PhoneModel("學生事務處", "07-3617141 #2052"),
    PhoneModel("課外活動組", "07-8100888 #25065"),
    PhoneModel("生活輔導組", "07-3617141 #23967"),
  ];

  NotificationState notificationState = NotificationState.loading;

  List<Notifications> notificationList = [];
  int page = 1;

  PhoneState phoneState = PhoneState.finish;

  PdfState pdfState = PdfState.loading;

  PdfController pdfController;

  ApLocalizations ap;

  TabController controller;

  int _currentIndex = 0;

  @override
  void initState() {
//    FirebaseAnalyticsUtils.instance.setCurrentScreen("SchoolInfoPage", "school_info_page.dart");
    controller = TabController(length: 3, vsync: this);
    _getNotifications();
    _getSchedules();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ap = ApLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(ap.schoolInfo),
        backgroundColor: ApTheme.of(context).blue,
      ),
      body: TabBarView(
        children: [
          NotificationScaffold(
            state: notificationState,
            notificationList: notificationList,
            onRefresh: () {
              setState(() {
                notificationList.clear();
              });
              _getNotifications();
            },
            onLoadingMore: () {
              setState(() => notificationState = NotificationState.loadingMore);
              _getNotifications();
            },
          ),
          PhoneScaffold(
            state: phoneState,
            phoneModelList: phoneModelList,
          ),
          PdfScaffold(
            state: pdfState,
            pdfController: pdfController,
            onRefresh: () => _getSchedules(),
          ),
        ],
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            controller.animateTo(_currentIndex);
          });
        },
        fixedColor: ApTheme.of(context).yellow,
        items: [
          BottomNavigationBarItem(
            icon: Icon(ApIcon.fiberNew),
            title: Text(ap.notifications),
          ),
          BottomNavigationBarItem(
            icon: Icon(ApIcon.phone),
            title: Text(ap.phones),
          ),
          BottomNavigationBarItem(
            icon: Icon(ApIcon.dateRange),
            title: Text(ap.events),
          ),
        ],
      ),
    );
  }

  _getNotifications() async {
    String rawString = await rootBundle.loadString(FileAssets.notifications);
    var data = NotificationsData.fromRawJson(rawString);
    if (mounted && data != null)
      setState(() {
        notificationList.addAll(data.data.notifications);
        notificationState = NotificationState.finish;
      });
  }

  _getSchedules() async {
    downloadFdf(
        'https://raw.githubusercontent.com/NKUST-ITC/NKUST-AP-Flutter/master/school_schedule.pdf');
  }

  void downloadFdf(String url) async {
    try {
      var response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      setState(() {
        pdfState = PdfState.finish;
        pdfController = PdfController(
          document: PdfDocument.openData(response.data),
        );
      });
    } catch (e) {
      setState(() {
        pdfState = PdfState.error;
      });
      throw e;
    }
  }
}
