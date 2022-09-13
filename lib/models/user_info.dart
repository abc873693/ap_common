import 'dart:convert';
import 'dart:typed_data';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  UserInfo({
    this.educationSystem,
    this.department,
    this.className,
    this.id,
    this.name,
    this.pictureUrl,
    this.pictureBytes,
    this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  factory UserInfo.fromRawJson(String str) => UserInfo.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  static UserInfo? load(String tag) {
    final String rawString = Preferences.getString(
      '${ApConstants.packageName}'
          '.user_info_$tag',
      '',
    );
    if (rawString == '') {
      return null;
    } else {
      return UserInfo.fromRawJson(rawString);
    }
  }

  String? educationSystem;
  String? department;
  String? className;
  String? id;
  String? name;
  String? pictureUrl;
  String? email;

  @JsonKey(ignore: true)
  Uint8List? pictureBytes;

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  String toRawJson() => jsonEncode(toJson());

  void save(String tag) {
    Preferences.setString(
      '${ApConstants.packageName}'
      '.user_info_$tag',
      toRawJson(),
    );
  }
}
