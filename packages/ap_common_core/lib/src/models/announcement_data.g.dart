// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementData _$AnnouncementDataFromJson(Map<String, dynamic> json) =>
    _AnnouncementData(
      data: (json['data'] as List<dynamic>)
          .map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnnouncementDataToJson(_AnnouncementData instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

_Announcement _$AnnouncementFromJson(Map<String, dynamic> json) =>
    _Announcement(
      title: json['title'] as String,
      id: (json['id'] as num?)?.toInt(),
      nextId: (json['nextId'] as num?)?.toInt(),
      lastId: (json['lastId'] as num?)?.toInt(),
      weight: (json['weight'] as num).toInt(),
      imgUrl: json['imgUrl'] as String,
      url: json['url'] as String?,
      description: json['description'] as String,
      publishedTime: json['publishedTime'] as String?,
      expireTime: json['expireTime'] as String?,
      applicant: json['applicant'] as String?,
      applicationId: json['application_id'] as String?,
      reviewStatus: json['reviewStatus'] as bool?,
      reviewDescription: json['reviewDescription'] as String?,
      tags: (json['tag'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AnnouncementToJson(_Announcement instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'nextId': instance.nextId,
      'lastId': instance.lastId,
      'weight': instance.weight,
      'imgUrl': instance.imgUrl,
      'url': instance.url,
      'description': instance.description,
      'publishedTime': instance.publishedTime,
      'expireTime': instance.expireTime,
      'applicant': instance.applicant,
      'application_id': instance.applicationId,
      'reviewStatus': instance.reviewStatus,
      'reviewDescription': instance.reviewDescription,
      'tag': instance.tags,
    };
