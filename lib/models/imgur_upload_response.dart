// To parse this JSON data, do
//
//     final imgurUploadResponse = imgurUploadResponseFromJson(jsonString);

import 'dart:convert';

class ImgurUploadResponse {
  ImgurUploadResponse({
    this.status,
    this.success,
    this.data,
  });

  int? status;
  bool? success;
  ImgurUploadData? data;

  ImgurUploadResponse copyWith({
    int? status,
    bool? success,
    ImgurUploadData? data,
  }) =>
      ImgurUploadResponse(
        status: status ?? this.status,
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory ImgurUploadResponse.fromRawJson(String str) =>
      ImgurUploadResponse.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory ImgurUploadResponse.fromJson(Map<String, dynamic> json) =>
      ImgurUploadResponse(
        status: json['status'] as int,
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : ImgurUploadData.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'success': success,
        'data': data == null ? null : data!.toJson(),
      };
}

class ImgurUploadData {
  ImgurUploadData({
    this.id,
    this.deletehash,
    this.accountId,
    this.accountUrl,
    this.adType,
    this.adUrl,
    this.title,
    this.description,
    this.name,
    this.type,
    this.width,
    this.height,
    this.size,
    this.views,
    this.section,
    this.vote,
    this.bandwidth,
    this.animated,
    this.favorite,
    this.inGallery,
    this.inMostViral,
    this.hasSound,
    this.isAd,
    this.nsfw,
    this.link,
    this.tags,
    this.datetime,
    this.mp4,
    this.hls,
  });

  String? id;
  String? deletehash;
  dynamic accountId;
  dynamic accountUrl;
  dynamic adType;
  dynamic adUrl;
  dynamic title;
  dynamic description;
  String? name;
  String? type;
  int? width;
  int? height;
  int? size;
  int? views;
  dynamic section;
  dynamic vote;
  int? bandwidth;
  bool? animated;
  bool? favorite;
  bool? inGallery;
  bool? inMostViral;
  bool? hasSound;
  bool? isAd;
  dynamic nsfw;
  String? link;
  List<dynamic>? tags;
  int? datetime;
  String? mp4;
  String? hls;

  ImgurUploadData copyWith({
    String? id,
    String? deletehash,
    dynamic accountId,
    dynamic accountUrl,
    dynamic adType,
    dynamic adUrl,
    dynamic title,
    dynamic description,
    String? name,
    String? type,
    int? width,
    int? height,
    int? size,
    int? views,
    dynamic section,
    dynamic vote,
    int? bandwidth,
    bool? animated,
    bool? favorite,
    bool? inGallery,
    bool? inMostViral,
    bool? hasSound,
    bool? isAd,
    dynamic nsfw,
    String? link,
    List<dynamic>? tags,
    int? datetime,
    String? mp4,
    String? hls,
  }) =>
      ImgurUploadData(
        id: id ?? this.id,
        deletehash: deletehash ?? this.deletehash,
        accountId: accountId ?? this.accountId,
        accountUrl: accountUrl ?? this.accountUrl,
        adType: adType ?? this.adType,
        adUrl: adUrl ?? this.adUrl,
        title: title ?? this.title,
        description: description ?? this.description,
        name: name ?? this.name,
        type: type ?? this.type,
        width: width ?? this.width,
        height: height ?? this.height,
        size: size ?? this.size,
        views: views ?? this.views,
        section: section ?? this.section,
        vote: vote ?? this.vote,
        bandwidth: bandwidth ?? this.bandwidth,
        animated: animated ?? this.animated,
        favorite: favorite ?? this.favorite,
        inGallery: inGallery ?? this.inGallery,
        inMostViral: inMostViral ?? this.inMostViral,
        hasSound: hasSound ?? this.hasSound,
        isAd: isAd ?? this.isAd,
        nsfw: nsfw ?? this.nsfw,
        link: link ?? this.link,
        tags: tags ?? this.tags,
        datetime: datetime ?? this.datetime,
        mp4: mp4 ?? this.mp4,
        hls: hls ?? this.hls,
      );

  factory ImgurUploadData.fromRawJson(String str) => ImgurUploadData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory ImgurUploadData.fromJson(Map<String, dynamic> json) =>
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
        tags: json['tags'] == null
            ? null
            : List<dynamic>.from(
                json['tags'] as List<dynamic>,
              ),
        datetime: json['datetime'] as int?,
        mp4: json['mp4'] as String?,
        hls: json['hls'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'deletehash': deletehash,
        'account_id': accountId,
        'account_url': accountUrl,
        'ad_type': adType,
        'ad_url': adUrl,
        'title': title,
        'description': description,
        'name': name,
        'type': type,
        'width': width,
        'height': height,
        'size': size,
        'views': views,
        'section': section,
        'vote': vote,
        'bandwidth': bandwidth,
        'animated': animated,
        'favorite': favorite,
        'in_gallery': inGallery,
        'in_most_viral': inMostViral,
        'has_sound': hasSound,
        'is_ad': isAd,
        'nsfw': nsfw,
        'link': link,
        'tags': tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        'datetime': datetime,
        'mp4': mp4,
        'hls': hls,
      };

  Map<String, dynamic> toSaveJson() => {
        'id': id,
        'deletehash': deletehash,
        'link': link,
        'datetime': datetime,
      };

  String toSaveRawJson() => json.encode(toJson());
}
