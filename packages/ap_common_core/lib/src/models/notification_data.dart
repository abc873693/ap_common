// To parse this JSON data, do
//
//     final notificationsData = notificationsDataFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

@freezed
abstract class NotificationsData with _$NotificationsData {
  const NotificationsData._();

  const factory NotificationsData({
    required Data data,
  }) = _NotificationsData;

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

  String toRawJson() => jsonEncode(toJson());
}

@freezed
abstract class Data with _$Data {
  const Data._();

  const factory Data({
    int? page,
    @JsonKey(name: 'notification') required List<Notifications> notifications,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  factory Data.fromRawJson(String str) => Data.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

@freezed
abstract class Notifications with _$Notifications {
  const Notifications._();

  const factory Notifications({
    required String link,
    required Info info,
  }) = _Notifications;

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  factory Notifications.fromRawJson(String str) => Notifications.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

@freezed
abstract class Info with _$Info {
  const Info._();

  const factory Info({
    required String title,
    required String department,
    required String date,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  factory Info.fromRawJson(String str) => Info.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}
