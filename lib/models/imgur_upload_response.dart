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
      ImgurUploadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImgurUploadResponse.fromJson(Map<String, dynamic> json) =>
      ImgurUploadResponse(
        status: json["status"] == null ? null : json["status"],
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : ImgurUploadData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "success": success == null ? null : success,
        "data": data == null ? null : data?.toJson(),
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
  dynamic? accountId;
  dynamic? accountUrl;
  dynamic? adType;
  dynamic? adUrl;
  dynamic? title;
  dynamic? description;
  String? name;
  String? type;
  int? width;
  int? height;
  int? size;
  int? views;
  dynamic? section;
  dynamic? vote;
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
    dynamic? accountId,
    dynamic? accountUrl,
    dynamic? adType,
    dynamic? adUrl,
    dynamic? title,
    dynamic? description,
    String? name,
    String? type,
    int? width,
    int? height,
    int? size,
    int? views,
    dynamic? section,
    dynamic? vote,
    int? bandwidth,
    bool? animated,
    bool? favorite,
    bool? inGallery,
    bool? inMostViral,
    bool? hasSound,
    bool? isAd,
    dynamic? nsfw,
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

  factory ImgurUploadData.fromRawJson(String str) =>
      ImgurUploadData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImgurUploadData.fromJson(Map<String, dynamic> json) =>
      ImgurUploadData(
        id: json["id"] == null ? null : json["id"],
        deletehash: json["deletehash"] == null ? null : json["deletehash"],
        accountId: json["account_id"],
        accountUrl: json["account_url"],
        adType: json["ad_type"],
        adUrl: json["ad_url"],
        title: json["title"],
        description: json["description"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        size: json["size"] == null ? null : json["size"],
        views: json["views"] == null ? null : json["views"],
        section: json["section"],
        vote: json["vote"],
        bandwidth: json["bandwidth"] == null ? null : json["bandwidth"],
        animated: json["animated"] == null ? null : json["animated"],
        favorite: json["favorite"] == null ? null : json["favorite"],
        inGallery: json["in_gallery"] == null ? null : json["in_gallery"],
        inMostViral:
            json["in_most_viral"] == null ? null : json["in_most_viral"],
        hasSound: json["has_sound"] == null ? null : json["has_sound"],
        isAd: json["is_ad"] == null ? null : json["is_ad"],
        nsfw: json["nsfw"],
        link: json["link"] == null ? null : json["link"],
        tags: json["tags"] == null
            ? null
            : List<dynamic>.from(json["tags"].map((x) => x)),
        datetime: json["datetime"] == null ? null : json["datetime"],
        mp4: json["mp4"] == null ? null : json["mp4"],
        hls: json["hls"] == null ? null : json["hls"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "deletehash": deletehash == null ? null : deletehash,
        "account_id": accountId,
        "account_url": accountUrl,
        "ad_type": adType,
        "ad_url": adUrl,
        "title": title,
        "description": description,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "size": size == null ? null : size,
        "views": views == null ? null : views,
        "section": section,
        "vote": vote,
        "bandwidth": bandwidth == null ? null : bandwidth,
        "animated": animated == null ? null : animated,
        "favorite": favorite == null ? null : favorite,
        "in_gallery": inGallery == null ? null : inGallery,
        "in_most_viral": inMostViral == null ? null : inMostViral,
        "has_sound": hasSound == null ? null : hasSound,
        "is_ad": isAd == null ? null : isAd,
        "nsfw": nsfw,
        "link": link == null ? null : link,
        "tags":
            tags == null ? null : List<dynamic>.from(tags?.map((x) => x) ?? []),
        "datetime": datetime == null ? null : datetime,
        "mp4": mp4 == null ? null : mp4,
        "hls": hls == null ? null : hls,
      };

  Map<String, dynamic> toSaveJson() => {
        "id": id == null ? null : id,
        "deletehash": deletehash == null ? null : deletehash,
        "link": link == null ? null : link,
        "datetime": datetime == null ? null : datetime,
      };

  String toSaveRawJson() => json.encode(toJson());
}
