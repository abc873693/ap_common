import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_response.freezed.dart';
part 'general_response.g.dart';

@freezed
abstract class GeneralResponse with _$GeneralResponse {

  const factory GeneralResponse({
    @JsonKey(name: 'code') required int statusCode,
    @JsonKey(name: 'description') required String message,
  }) = _GeneralResponse;
  const GeneralResponse._();

  factory GeneralResponse.success() => const GeneralResponse(
        statusCode: successCode,
        message: '',
      );

  factory GeneralResponse.unknownError() => const GeneralResponse(
        statusCode: unknownErrorCode,
        message: '',
      );

  factory GeneralResponse.platformNotSupport() => const GeneralResponse(
        statusCode: platformNotSupportCode,
        message: 'platform not support',
      );

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralResponseFromJson(json);

  factory GeneralResponse.fromRawJson(String str) => GeneralResponse.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  static const int successCode = 200;
  static const int unknownErrorCode = 1000;
  static const int platformNotSupportCode = 1001;

  String toRawJson() => jsonEncode(toJson());
}
