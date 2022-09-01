// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsData _$NotificationsDataFromJson(Map<String, dynamic> json) =>
    NotificationsData(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationsDataToJson(NotificationsData instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      page: json['page'] as int?,
      notifications: (json['notification'] as List<dynamic>?)
          ?.map((e) => Notifications.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'page': instance.page,
      'notification': instance.notifications?.map((e) => e.toJson()).toList(),
    };

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      link: json['link'] as String?,
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'link': instance.link,
      'info': instance.info?.toJson(),
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      id: json['id'] as int?,
      title: json['title'] as String?,
      department: json['department'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'department': instance.department,
      'date': instance.date,
    };
