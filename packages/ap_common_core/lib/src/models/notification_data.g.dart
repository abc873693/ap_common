// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationsData _$NotificationsDataFromJson(Map<String, dynamic> json) =>
    _NotificationsData(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationsDataToJson(_NotificationsData instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

_Data _$DataFromJson(Map<String, dynamic> json) => _Data(
      page: (json['page'] as num?)?.toInt(),
      notifications: (json['notification'] as List<dynamic>)
          .map((e) => Notifications.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
      'page': instance.page,
      'notification': instance.notifications.map((e) => e.toJson()).toList(),
    };

_Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    _Notifications(
      link: json['link'] as String,
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationsToJson(_Notifications instance) =>
    <String, dynamic>{
      'link': instance.link,
      'info': instance.info.toJson(),
    };

_Info _$InfoFromJson(Map<String, dynamic> json) => _Info(
      title: json['title'] as String,
      department: json['department'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$InfoToJson(_Info instance) => <String, dynamic>{
      'title': instance.title,
      'department': instance.department,
      'date': instance.date,
    };
