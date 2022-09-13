// To parse this JSON data, do
//
//     final notificationsData = notificationsDataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'notification_data.g.dart';

@JsonSerializable()
class NotificationsData {
  NotificationsData({
    this.data,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      _$NotificationsDataFromJson(json);

  factory NotificationsData.fromRawJson(String str) =>
      NotificationsData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory NotificationsData.sample() {
    return NotificationsData.fromRawJson(
      '{ "data": { "page": 1, "notification": [ { "link": "http://kuasnews.kuas.edu.tw/files/13-1018-70766-1.php", "info": { "id": "1", "title": "2019年高科大高雄亮點日語導覽競賽", "department": "觀光系", "date": "2019-03-13" } }, { "link": "http://gec.kuas.edu.tw/files/13-1012-70765-1.php", "info": { "id": "2", "title": "快來拿獎金!!!第22屆優質通識課程學生學習檔案e化徵選活動~", "department": "通識中心", "date": "2019-03-13" } } ] } }',
    );
  }

  Data? data;

  Map<String, dynamic> toJson() => _$NotificationsDataToJson(this);

  String toRawJson() => jsonEncode(toJson());
}

@JsonSerializable()
class Data {
  Data({
    this.page,
    this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  factory Data.fromRawJson(String str) => Data.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  int? page;
  @JsonKey(name: 'notification')
  List<Notifications>? notifications;

  Map<String, dynamic> toJson() => _$DataToJson(this);

  String toRawJson() => jsonEncode(toJson());
}

@JsonSerializable()
class Notifications {
  Notifications({
    this.link,
    this.info,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  factory Notifications.fromRawJson(String str) => Notifications.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String? link;
  Info? info;

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);

  String toRawJson() => jsonEncode(toJson());
}

@JsonSerializable()
class Info {
  Info({
    this.id,
    this.title,
    this.department,
    this.date,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  factory Info.fromRawJson(String str) => Info.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  int? id;
  String? title;
  String? department;
  String? date;

  Map<String, dynamic> toJson() => _$InfoToJson(this);

  String toRawJson() => jsonEncode(toJson());
}
