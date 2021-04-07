import 'dart:convert';

import 'dart:typed_data';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';

class UserInfo {
  String? educationSystem;
  String? department;
  String? className;
  String? id;
  String? name;
  String? pictureUrl;
  String? email;

  Uint8List? pictureBytes;

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

  factory UserInfo.fromRawJson(String str) =>
      UserInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfo.fromJson(Map<String, dynamic> json) => new UserInfo(
        educationSystem: json["educationSystem"],
        department: json["department"],
        className: json["className"],
        id: json["id"],
        name: json["name"],
        pictureUrl: json["pictureUrl"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "educationSystem": educationSystem,
        "department": department,
        "className": className,
        "id": id,
        "name": name,
        "pictureUrl": pictureUrl,
        "email": email
      };

  void save(String tag) {
    Preferences.setString(
      '${ApConstants.PACKAGE_NAME}'
      '.user_info_$tag',
      this.toRawJson(),
    );
  }

  static UserInfo? load(String tag) {
    String rawString = Preferences.getString(
      '${ApConstants.PACKAGE_NAME}'
          '.user_info_$tag',
      '',
    );
    if (rawString == '')
      return null;
    else
      return UserInfo.fromRawJson(rawString);
  }
}
