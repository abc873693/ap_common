// To parse this JSON data, do
//
//     final imgurUploadResponse = imgurUploadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'imgur_upload_response.freezed.dart';
part 'imgur_upload_response.g.dart';

@freezed
abstract class ImgurUploadResponse with _$ImgurUploadResponse {

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ImgurUploadResponse({
    int? status,
    bool? success,
    ImgurUploadData? data,
  }) = _ImgurUploadResponse;
  const ImgurUploadResponse._();

  factory ImgurUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ImgurUploadResponseFromJson(json);

  factory ImgurUploadResponse.fromRawJson(String str) =>
      ImgurUploadResponse.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}

@freezed
abstract class ImgurUploadData with _$ImgurUploadData {

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ImgurUploadData({
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
  }) = _ImgurUploadData;
  const ImgurUploadData._();

  factory ImgurUploadData.fromJson(Map<String, dynamic> json) =>
      _$ImgurUploadDataFromJson(json);

  factory ImgurUploadData.fromRawJson(String str) => ImgurUploadData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());
}
