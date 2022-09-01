// To parse this JSON data, do
//
//     final notificationsData = notificationsDataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'notification_data.g.dart';

@JsonSerializable()
class NotificationsData {
  Data? data;

  NotificationsData({
    this.data,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      _$NotificationsDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsDataToJson(this);

  factory NotificationsData.fromRawJson(String str) =>
      NotificationsData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());

  factory NotificationsData.sample() {
    return NotificationsData.fromRawJson(
      '{ "data": { "page": 1, "notification": [ { "link": "http://kuasnews.kuas.edu.tw/files/13-1018-70766-1.php", "info": { "id": "1", "title": "2019年高科大高雄亮點日語導覽競賽", "department": "觀光系", "date": "2019-03-13" } }, { "link": "http://gec.kuas.edu.tw/files/13-1012-70765-1.php", "info": { "id": "2", "title": "快來拿獎金!!!第22屆優質通識課程學生學習檔案e化徵選活動~", "department": "通識中心", "date": "2019-03-13" } } ] } }',
    );
  }
}

@JsonSerializable()
class Data {
  int? page;
  @JsonKey(name: 'notification')
  List<Notifications>? notifications;

  Data({
    this.page,
    this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  factory Data.fromRawJson(String str) => Data.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

@JsonSerializable()
class Notifications {
  String? link;
  Info? info;

  Notifications({
    this.link,
    this.info,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);

  factory Notifications.fromRawJson(String str) => Notifications.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

@JsonSerializable()
class Info {
  int? id;
  String? title;
  String? department;
  String? date;

  Info({
    this.id,
    this.title,
    this.department,
    this.date,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);

  factory Info.fromRawJson(String str) => Info.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}
