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
    expect(data.defaultSemester!.text, '111學年度 上學期');
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
        '{"data":{"page":1,"notification":[{"link":"http://acad.nkust.edu.tw/p/406-1004-35062,r232.php","info":{"id":0,"title":"109學年度五專及四技新生入學成績優異獎勵，請於109年9月9日前提出申請，請查照。","date":"2020-08-20"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-35364,r232.php","info":{"id":1,"title":"【109.09.02(三)~09.04(五)停機公告】本校教學平臺停機維護通知。","date":"2020-08-25"}},{"link":"https://acad.nkust.edu.tw/var/file/4/1004/img/1071/2019ncov-11.pdf","info":{"id":2,"title":"本校因應新型冠狀病毒肺炎疫情停課、補課及復課措施(另開新視窗)","date":"2020-03-27"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-32275,r232.php","info":{"id":3,"title":"108學年度第2學期辦理離校手續及領取學位證書等注意事項，請查照。","date":"2020-05-19"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-33777,r232.php","info":{"id":4,"title":"公告本校109學年度第1學期核准轉系(所、科、學位學程)學生名單","date":"2020-06-24"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-33942,r232.php","info":{"id":5,"title":"公告本校109學年度第一學期【日間部】開學須知，請查照。","date":"2020-07-03"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-32325,r232.php","info":{"id":6,"title":"本校108學年度日間五專及大學部畢業學業成績優良名單，請查照。","date":"2020-05-20"}},{"link":"https://ada.nkust.edu.tw/p/404-1057-35003.php","info":{"id":7,"title":"109學年度日間部境外臺生因應疫情返臺就學銜接專案計畫碩士班單獨招生「網路報到入口」","date":"2020-08-20"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-35077,r232.php","info":{"id":8,"title":"109學年度境外臺生因應疫情返臺就學銜接專案計畫報到須知","date":"2020-08-20"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-34935,r232.php","info":{"id":9,"title":"【轉知】靜宜大學「劍及履及！計畫書撰寫與問題發展」","date":"2020-08-14"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-34934,r232.php","info":{"id":10,"title":"【轉知】泛太平洋聯盟「課程方案發展實作工作坊」","date":"2020-08-14"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-34884,r232.php","info":{"id":11,"title":"【轉知研習訊息】有關華夏科技大學智慧車輛系舉辦「AI教學與研究的最佳利器：SI-EYE深度學習圖像檢測」一案，歡迎本校師生踴躍報名參加，請查照。","date":"2020-08-12"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-34787,r232.php","info":{"id":12,"title":"【轉知】中臺科技大學「108年教學實踐研究成果發表暨專題演講工作坊」","date":"2020-08-10"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-34750,r232.php","info":{"id":13,"title":"【徵才結果公告】有關109年07月23日教務處選才專案辦公室徵聘專案助理乙名遴選結果","date":"2020-08-07"}},{"link":"http://acad.nkust.edu.tw/p/406-1004-34688,r232.php","info":{"id":14,"title":"【轉知研習訊息】有關109年「社會經濟資料服務平台(SEGIS)」實機操作教育訓練計畫一案，歡迎本校同仁踴躍報名參加，請查照。","date":"2020-08-06"}}]}}';
    final NotificationsData data = NotificationsData.fromRawJson(rawData);
    expect(data.data!.page, 1);
    expect(
      data.data!.notifications!.first.link,
      'http://acad.nkust.edu.tw/p/406-1004-35062,r232.php',
    );
    expect(
      data.data!.notifications!.first.info!.title,
      '109學年度五專及四技新生入學成績優異獎勵，請於109年9月9日前提出申請，請查照。',
    );
    expect(data.data!.notifications!.first.info!.department, null);
    expect(data.data!.notifications!.first.info!.date, '2020-08-20');
  });
}
