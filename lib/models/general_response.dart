import 'dart:convert';

class GeneralResponse {
  final int statusCode;
  final String message;

  GeneralResponse({
    required this.statusCode,
    required this.message,
  });

  static const SUCCESS = 200;
  static const UNKNOWN_ERROR = 1000;
  static const PLATFORM_NOT_SUPPORT = 1001;

  static GeneralResponse success() =>
      GeneralResponse(statusCode: SUCCESS, message: '');

  static GeneralResponse unknownError() =>
      GeneralResponse(statusCode: UNKNOWN_ERROR, message: '');

  static GeneralResponse platformNotSupport() => GeneralResponse(
      statusCode: PLATFORM_NOT_SUPPORT, message: 'platform not support');

  factory GeneralResponse.fromRawJson(String str) =>
      GeneralResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        statusCode: json["code"] == null ? null : json["code"],
        message: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "description": message,
      };
}
