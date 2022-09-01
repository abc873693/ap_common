// To parse this JSON data, do
//
//     final imgurUploadResponse = imgurUploadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'imgur_upload_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ImgurUploadResponse {
  ImgurUploadResponse({
    this.status,
    this.success,
    this.data,
  });

  int? status;
  bool? success;
  ImgurUploadData? data;

  factory ImgurUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ImgurUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImgurUploadResponseToJson(this);

  factory ImgurUploadResponse.fromRawJson(String str) =>
      ImgurUploadResponse.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

@JsonSerializable(fieldRename: FieldRename.snake)
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

  factory ImgurUploadData.fromJson(Map<String, dynamic> json) =>
      _$ImgurUploadDataFromJson(json);

  Map<String, dynamic> toJson() => _$ImgurUploadDataToJson(this);

  factory ImgurUploadData.fromRawJson(String str) => ImgurUploadData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}
