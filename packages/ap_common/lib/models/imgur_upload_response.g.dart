// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imgur_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImgurUploadResponse _$ImgurUploadResponseFromJson(Map<String, dynamic> json) =>
    ImgurUploadResponse(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : ImgurUploadData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImgurUploadResponseToJson(
        ImgurUploadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'data': instance.data?.toJson(),
    };

ImgurUploadData _$ImgurUploadDataFromJson(Map<String, dynamic> json) =>
    ImgurUploadData(
      id: json['id'] as String?,
      deletehash: json['deletehash'] as String?,
      accountId: json['account_id'],
      accountUrl: json['account_url'],
      adType: json['ad_type'],
      adUrl: json['ad_url'],
      title: json['title'],
      description: json['description'],
      name: json['name'] as String?,
      type: json['type'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      size: json['size'] as int?,
      views: json['views'] as int?,
      section: json['section'],
      vote: json['vote'],
      bandwidth: json['bandwidth'] as int?,
      animated: json['animated'] as bool?,
      favorite: json['favorite'] as bool?,
      inGallery: json['in_gallery'] as bool?,
      inMostViral: json['in_most_viral'] as bool?,
      hasSound: json['has_sound'] as bool?,
      isAd: json['is_ad'] as bool?,
      nsfw: json['nsfw'],
      link: json['link'] as String?,
      tags: json['tags'] as List<dynamic>?,
      datetime: json['datetime'] as int?,
      mp4: json['mp4'] as String?,
      hls: json['hls'] as String?,
    );

Map<String, dynamic> _$ImgurUploadDataToJson(ImgurUploadData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deletehash': instance.deletehash,
      'account_id': instance.accountId,
      'account_url': instance.accountUrl,
      'ad_type': instance.adType,
      'ad_url': instance.adUrl,
      'title': instance.title,
      'description': instance.description,
      'name': instance.name,
      'type': instance.type,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'views': instance.views,
      'section': instance.section,
      'vote': instance.vote,
      'bandwidth': instance.bandwidth,
      'animated': instance.animated,
      'favorite': instance.favorite,
      'in_gallery': instance.inGallery,
      'in_most_viral': instance.inMostViral,
      'has_sound': instance.hasSound,
      'is_ad': instance.isAd,
      'nsfw': instance.nsfw,
      'link': instance.link,
      'tags': instance.tags,
      'datetime': instance.datetime,
      'mp4': instance.mp4,
      'hls': instance.hls,
    };
