import 'dart:convert';

import 'package:flutter/cupertino.dart';

class GeneralResponse {
  final int statusCode;
  final String message;

  GeneralResponse({
    @required this.statusCode,
    @required this.message,
  });

  static GeneralResponse success() =>
      GeneralResponse(statusCode: 200, message: '');

  static GeneralResponse unknownError() =>
      GeneralResponse(statusCode: 1000, message: '');

  factory GeneralResponse.fromRawJson(String str) =>
      GeneralResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        statusCode: json["code"] == null ? null : json["code"],
        message: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode == null ? null : statusCode,
        "description": message == null ? null : message,
      };
}
