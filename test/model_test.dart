import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/models/notification_data.dart';
import 'package:ap_common/models/score_data.dart';
import 'package:ap_common/models/semester_data.dart';
import 'package:ap_common/models/user_info.dart';
import 'package:flutter_test/flutter_test.dart';

//ignore_for_file: lines_longer_than_80_chars

void main() {
  test('Announcement Data parser', () {
    const String rawData =
        '{"title":"學生會Instagram新生帳號 START","id":0,"nextId":null,"lastId":null,"weight":0,"imgUrl":"https://i.imgur.com/E56Yv90.png","url":"https://www.instagram.com/nsysu.freshman.2022/","description":"測試內容","publishedTime":null,"expireTime":"2022-09-19T20:00:00Z","applicant":null,"application_id":"2022-09-19T20:00:00Z","reviewStatus":null,"reviewDescription":null,"tag":["zh","nsysu"]}';
    final Announcement data = Announcement.fromRawJson(rawData);
    expect(data.id, 0);
    expect(data.weight, 0);
    expect(data.imgUrl, 'https://i.imgur.com/E56Yv90.png');
    expect(data.url, 'https://www.instagram.com/nsysu.freshman.2022/');
    expect(data.description, '測試內容');
    expect(data.tags!.length, 2);
  });
  test('UserInfo Data parser', () {
    const String rawData =
        '{"educationSystem":"四技日間部","department":"資訊工程系","className":"2","id":"M073040000","name":"Dash","pictureUrl":null,"email":"M073040000@student.nsysu.edu.tw"}';
    final UserInfo data = UserInfo.fromRawJson(rawData);
    expect(data.educationSystem, '四技日間部');
    expect(data.department, '資訊工程系');
    expect(data.className, '2');
    expect(data.id, 'M073040000');
    expect(data.name, 'Dash');
    expect(data.pictureUrl, null);
    expect(data.email, 'M073040000@student.nsysu.edu.tw');
  });
  test('Semester Data parser', () {
    const String rawData =
        '{"data":[{"year":"111","value":"3","text":"111學年度 暑假"},{"year":"111","value":"2","text":"111學年度 下學期"},{"year":"111","value":"1","text":"111學年度 上學期"},{"year":"111","value":"0","text":"111學年度 碩專署"},{"year":"110","value":"3","text":"110學年度 暑假"},{"year":"110","value":"2","text":"110學年度 下學期"},{"year":"110","value":"1","text":"110學年度 上學期"}],"default":{"year":"111","value":"1","text":"111學年度 上學期"},"currentIndex":2}';
    final SemesterData data = SemesterData.fromRawJson(rawData);
    expect(data.data.first.year, '111');
    expect(data.data.first.value, '3');
    expect(data.data.first.code, '1113');
    expect(data.data.first.text, '111學年度 暑假');
    expect(data.defaultSemester.text, '111學年度 上學期');
    expect(data.defaultIndex, 2);
  });
  test('Course Data parser', () {
    const String rawData =
        '{"courses":[{"code":"TA106","title":"中國戲劇史（一）","className":"劇藝系 2","group":null,"units":"2","hours":null,"required":"必修","at":null,"sectionTimes":[{"weekday":2,"index":7},{"weekday":2,"index":8}],"location":{"room":"文FA 3012","building":""},"instructors":["林芷瑩"]},{"code":"TA204","title":"導演概論","className":"劇藝系 2","group":null,"units":"2","hours":null,"required":"必修","at":null,"sectionTimes":[{"weekday":4,"index":3},{"weekday":4,"index":4}],"location":{"room":"文FA 3012","building":""},"instructors":["楊士平"]},{"code":"TA303","title":"西方名劇選讀","className":"劇藝系 2","group":null,"units":"3","hours":null,"required":"必修","at":null,"sectionTimes":[{"weekday":4,"index":6},{"weekday":4,"index":7},{"weekday":4,"index":8}],"location":{"room":"文FA 3009","building":""},"instructors":["黃資絜"]},{"code":"GEAE2625","title":"在地食物的永續發展與全球脈絡","className":"通識教育 0","group":null,"units":"3","hours":null,"required":"必修","at":null,"sectionTimes":[{"weekday":1,"index":12},{"weekday":1,"index":13},{"weekday":1,"index":14}],"location":{"room":"通GE 2006","building":""},"instructors":["林季怡"]},{"code":"GEPE202","title":"運動與健康：初級集訓班","className":"運動健康(必) 2","group":null,"units":"1","hours":null,"required":"必修","at":null,"sectionTimes":[{"weekday":1,"index":0},{"weekday":3,"index":0}],"location":{"room":"","building":""},"instructors":["羅凱暘"]},{"code":"GESL382","title":"服務學習：為長者服務，向長者學習","className":"服務學習 0","group":null,"units":"1","hours":null,"required":"必修","at":null,"sectionTimes":[{"weekday":3,"index":3},{"weekday":3,"index":4}],"location":{"room":"通GE 3013","building":""},"instructors":["王以亮"]},{"code":"GEAI1006","title":"跨文化溝通研究","className":"跨院選修(通) 0","group":null,"units":"3","hours":null,"required":"選修","at":null,"sectionTimes":[{"weekday":1,"index":6},{"weekday":1,"index":7},{"weekday":1,"index":8}],"location":{"room":"通GE 3011","building":""},"instructors":["伊藤佳代"]},{"code":"TA236","title":"現當代東亞戲劇與劇場","className":"劇藝系 2","group":null,"units":"2","hours":null,"required":"選修","at":null,"sectionTimes":[{"weekday":2,"index":3},{"weekday":2,"index":4}],"location":{"room":"文FA 3012","building":""},"instructors":["黃資絜"]},{"code":"TA254","title":"進階表演（一）","className":"劇藝系 2","group":null,"units":"3","hours":null,"required":"選修","at":null,"sectionTimes":[{"weekday":3,"index":6},{"weekday":3,"index":7},{"weekday":3,"index":8}],"location":{"room":"文FA 2017","building":""},"instructors":["何怡璉"]},{"code":"TA256","title":"聲音訓練","className":"劇藝系 1","group":null,"units":"2","hours":null,"required":"選修","at":null,"sectionTimes":[{"weekday":1,"index":3},{"weekday":1,"index":4}],"location":{"room":"文FA 2017","building":""},"instructors":["林宜誠"]},{"code":"TA275","title":"燈光設計及技術","className":"劇藝系 2","group":null,"units":"2","hours":null,"required":"選修","at":null,"sectionTimes":[{"weekday":1,"index":2},{"weekday":1,"index":3},{"weekday":1,"index":4},{"weekday":1,"index":6},{"weekday":1,"index":7},{"weekday":1,"index":8},{"weekday":1,"index":9},{"weekday":2,"index":2},{"weekday":2,"index":3},{"weekday":2,"index":4},{"weekday":2,"index":6},{"weekday":2,"index":7},{"weekday":2,"index":8},{"weekday":2,"index":9},{"weekday":3,"index":1},{"weekday":3,"index":2},{"weekday":3,"index":3},{"weekday":3,"index":4},{"weekday":3,"index":6},{"weekday":3,"index":7},{"weekday":3,"index":8},{"weekday":4,"index":1},{"weekday":4,"index":2},{"weekday":4,"index":3},{"weekday":4,"index":4},{"weekday":4,"index":6},{"weekday":4,"index":7},{"weekday":4,"index":8},{"weekday":4,"index":9},{"weekday":5,"index":2},{"weekday":5,"index":3},{"weekday":5,"index":4},{"weekday":5,"index":6},{"weekday":5,"index":7},{"weekday":5,"index":8},{"weekday":5,"index":9}],"location":{"room":"文FA 2019","building":""},"instructors":["李俊餘"]}],"timeCodes":[{"title":"A","startTime":"07:00","endTime":"07:50"},{"title":"1","startTime":"08:10","endTime":"09:00"},{"title":"2","startTime":"09:10","endTime":"10:00"},{"title":"3","startTime":"10:10","endTime":"11:00"},{"title":"4","startTime":"11:10","endTime":"12:00"},{"title":"B","startTime":"12:10","endTime":"13:00"},{"title":"5","startTime":"13:10","endTime":"14:00"},{"title":"6","startTime":"14:10","endTime":"15:00"},{"title":"7","startTime":"15:10","endTime":"16:00"},{"title":"8","startTime":"16:10","endTime":"17:00"},{"title":"9","startTime":"17:10","endTime":"18:00"},{"title":"C","startTime":"18:20","endTime":"19:10"},{"title":"D","startTime":"19:15","endTime":"20:05"},{"title":"E","startTime":"20:10","endTime":"21:00"},{"title":"F","startTime":"21:05","endTime":"21:55"}]}';
    final CourseData data = CourseData.fromRawJson(rawData);
    expect(data.courses.first.code, 'TA106');
    expect(data.courses.first.title, '中國戲劇史（一）');
    expect(data.courses.first.className, '劇藝系 2');
    expect(data.courses.first.required, '必修');
    expect(data.courses.first.location.toString(), '文FA 3012');
  });
  test('Score Data parser', () {
    const String rawData =
        '{"scores":[{"title":"英語能力訓練","units":"0","hours":"2.0","required":"【必修】","at":"【學期】","middleScore":"","semesterScore":"","remark":"停修"},{"title":"財務管理","units":"3.0","hours":"3.0","required":"【必修】","at":"【學期】","middleScore":"","semesterScore":"67.00","remark":""},{"title":"統計學(二)","units":"3.0","hours":"3.0","required":"【必修】","at":"【學期】","middleScore":"","semesterScore":"60.00","remark":""},{"title":"微積分(二)","units":"3.0","hours":"3.0","required":"【必修】","at":"【學期】","middleScore":"","semesterScore":"60.00","remark":""},{"title":"實務專題(二)","units":"1.0","hours":"3.0","required":"【必修】","at":"【學期】","middleScore":"","semesterScore":"98.00","remark":""},{"title":"管理資訊系統","units":"3.0","hours":"3.0","required":"【必修】","at":"【學期】","middleScore":"","semesterScore":"80.00","remark":""},{"title":"進階英語口語訓練","units":"3.0","hours":"3.0","required":"【選修】","at":"【學期】","middleScore":"","semesterScore":"90.00","remark":""},{"title":"Python程式設計","units":"3.0","hours":"3.0","required":"【選修】","at":"【學期】","middleScore":"100.00","semesterScore":"97.00","remark":""},{"title":"體育(四)-羽球","units":"0","hours":"2.0","required":"【必修】","at":"【學期】","middleScore":"","semesterScore":"63.00","remark":""},{"title":"服務教育(二)","units":"0","hours":"2.0","required":"【必修】","at":"【學期】","middleScore":"","semesterScore":"合格","remark":""}],"detail":{"conduct":82,"classRank":"25/34","departmentRank":"57/73","average":76.84}}';
    final ScoreData data = ScoreData.fromRawJson(rawData);
    expect(data.scores.first.units, '0');
    expect(data.scores.first.title, '英語能力訓練');
    expect(data.scores.first.required, '【必修】');
    expect(data.scores.first.at, '【學期】');
    expect(data.scores.first.middleScore, '');
    expect(data.scores.first.semesterScore, '');
    expect(data.scores.first.remark, '停修');
    expect(data.detail.conduct, 82);
    expect(data.detail.classRank, '25/34');
    expect(data.detail.departmentRank, '57/73');
    expect(data.detail.average, 76.84);
  });
  test('Notifications Data parser', () {
    const String rawData =
        '{"data":{"page":1,"notification":[{"link":"https://acad.nkust.edu.tw/p/406-1004-61931,r232.php?Lang=zh-tw","info":{"title":"公告111學年度第1學期歷年成績表更改必選修申請表單線上化，請查照。","department":"學習輔導組","date":"2022-09-16"}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61915,r232.php?Lang=zh-tw","info":{"title":"【公告】本校教學實踐研究計畫社群辦理「教學實踐研究計畫經驗線上分享」，歡迎師長踴躍報名參與","department":"教學發展中心","date":"2022-09-16 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61801,r232.php?Lang=zh-tw","info":{"title":"(9/15預告)公告111-1學期日間部及進修部【未達開課點數及人數關課課程】","department":"課務組","date":"2022-09-15 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61949,r232.php?Lang=zh-tw","info":{"title":"【公告事項】--「臺灣學術倫理教育資源中心」線上平台已 於111年9月13日22:00修復完畢，本校研究所必修學生已可登入網站 上課暨測驗，請查照。","department":"註冊組","date":"2022-09-14 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61952,r232.php?Lang=zh-tw","info":{"title":"【申請通知】--本校111學年度第1學期研究生學位考試申請及相關事宜，請查照。","department":"註冊組","date":"2022-09-12 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61947,r232.php?Lang=zh-tw","info":{"title":"【公告事項】--111學年度入學之日間部及進修部碩、博士 班新生，請至「臺灣學術倫理教育資源中心」線上平台，完成指定之 學術研究倫理線上課程，請查照。","department":"註冊組","date":"2022-09-12 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-27716,r232.php?Lang=zh-tw","info":{"title":"【線上學習不能停】高科大磨課師+線上學習資源 一次都給你!!","department":"教學發展中心","date":"2022-09-12 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61715,r232.php?Lang=zh-tw","info":{"title":"【轉知】MOOCs－臺北聯合大學系統開設「創業狂想曲-序章 我的新創時代」磨課師課程，敬請教職員生踴躍報名","department":"教學發展中心","date":"2022-09-12 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61714,r232.php?Lang=zh-tw","info":{"title":"【轉知】MOOCs－國立臺灣海洋大學開設「鯊魚知多少(2022秋季班)」磨課師課程，敬請教職員生踴躍報名","department":"教學發展中心","date":"2022-09-12 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61713,r232.php?Lang=zh-tw","info":{"title":"本(111-1)學期日間部與進修部教師登錄學生成績系統開放相關事宜，請查照。","department":"學習輔導組","date":"2022-09-12 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61709,r232.php?Lang=zh-tw","info":{"title":"【轉知】國立清華大學竹師教育學院辦理「2022第十三屆教育創新國際學術研討會」，歡迎教師踴躍投稿及參加，請查照。","department":"教學服務組","date":"2022-09-12 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61706,r232.php?Lang=zh-tw","info":{"title":"【轉知】MOOCs－長榮大學開設4門磨課師課程，敬請教職員生踴躍報名","department":"教學發展中心","date":"2022-09-12 "}},{"link":"https://higheredu.nkust.edu.tw/event/615","info":{"title":"2022年高等教育深耕計畫BEST WISH成果展暨教育趨勢論壇，歡迎師生踴躍參加。","department":"教學發展中心","date":"2022-09-08 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61646,r232.php?Lang=zh-tw","info":{"title":"111學年度第1學期課程新生初選(登記志願)篩選結果公告，請查照。","department":"課務組","date":"2022-09-08 "}},{"link":"https://acad.nkust.edu.tw/p/406-1004-61595,r232.php?Lang=zh-tw","info":{"title":"【申請通知】有關本校111學年度第1學期業界專家協同教學課程相關事宜，詳如說明。","department":"教學服務組","date":"2022-09-07 "}}]}}';
    final NotificationsData data = NotificationsData.fromRawJson(rawData);
    expect(data.data.page, 1);
    expect(
      data.data.notifications.first.link,
      'https://acad.nkust.edu.tw/p/406-1004-61931,r232.php?Lang=zh-tw',
    );
    expect(
      data.data.notifications.first.info.title,
      '公告111學年度第1學期歷年成績表更改必選修申請表單線上化，請查照。',
    );
    expect(data.data.notifications.first.info.department, '學習輔導組');
    expect(data.data.notifications.first.info.date, '2022-09-16');
  });
}
