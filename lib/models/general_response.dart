import 'dart:convert';

class GeneralResponse {
  final int statusCode;
  final String message;

  GeneralResponse({
    required this.statusCode,
    required this.message,
  });

  static const int successCode = 200;
  static const int unknownErrorCode = 1000;
  static const int platformNotSupportCode = 1001;

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

  factory GeneralResponse.fromRawJson(String str) => GeneralResponse.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        statusCode: json['code'] as int,
        message: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'code': statusCode,
        'description': message,
      };
}
