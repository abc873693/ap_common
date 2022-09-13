import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'general_response.g.dart';

@JsonSerializable()
class GeneralResponse {
  GeneralResponse({
    required this.statusCode,
    required this.message,
  });

  factory GeneralResponse.success() => GeneralResponse(
        statusCode: successCode,
        message: '',
      );

  factory GeneralResponse.unknownError() => GeneralResponse(
        statusCode: unknownErrorCode,
        message: '',
      );

  factory GeneralResponse.platformNotSupport() => GeneralResponse(
        statusCode: platformNotSupportCode,
        message: 'platform not support',
      );

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralResponseFromJson(json);

  factory GeneralResponse.fromRawJson(String str) => GeneralResponse.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  @JsonKey(name: 'code')
  final int statusCode;

  @JsonKey(name: 'description')
  final String message;

  static const int successCode = 200;
  static const int unknownErrorCode = 1000;
  static const int platformNotSupportCode = 1001;

  Map<String, dynamic> toJson() => _$GeneralResponseToJson(this);

  String toRawJson() => jsonEncode(toJson());
}
