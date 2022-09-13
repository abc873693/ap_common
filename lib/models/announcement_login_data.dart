import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'announcement_login_data.g.dart';

enum PermissionLevel { user, editor, admin }

@JsonSerializable()
class AnnouncementLoginData {
  AnnouncementLoginData({
    this.key,
  });

  factory AnnouncementLoginData.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementLoginDataFromJson(json);

  factory AnnouncementLoginData.fromRawJson(String str) =>
      AnnouncementLoginData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String? key;

  Map<String, dynamic> get decodedToken => JwtDecoder.decode(key!);

  bool get isExpired => JwtDecoder.isExpired(key!);

  PermissionLevel get level =>
      //ignore: avoid_dynamic_calls
      PermissionLevel.values[decodedToken['user']['permission_level'] as int];

  //ignore: avoid_dynamic_calls
  String? get loginType => decodedToken['user']['login_type'] as String;

  //ignore: avoid_dynamic_calls
  String? get username => decodedToken['user']['username'] as String;

  Map<String, dynamic> toJson() => _$AnnouncementLoginDataToJson(this);

  String toRawJson() => jsonEncode(toJson());

  AnnouncementLoginData copyWith({
    String? key,
  }) =>
      AnnouncementLoginData(
        key: key ?? this.key,
      );

  void save() {
    Preferences.setStringSecurity(
      '${ApConstants.packageName}'
      '.announcement_login_data',
      toRawJson(),
    );
  }

  static AnnouncementLoginData? load() {
    final String rawString = Preferences.getStringSecurity(
      '${ApConstants.packageName}'
          '.announcement_login_data',
      '',
    );
    if (rawString == '') {
      return null;
    } else {
      return AnnouncementLoginData.fromRawJson(rawString);
    }
  }
}
