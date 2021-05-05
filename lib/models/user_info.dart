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
      UserInfo.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        educationSystem: json['educationSystem'] as String,
        department: json['department'] as String,
        className: json['className'] as String,
        id: json['id'] as String,
        name: json['name'] as String,
        pictureUrl: json['pictureUrl'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        'educationSystem': educationSystem,
        'department': department,
        'className': className,
        'id': id,
        'name': name,
        'pictureUrl': pictureUrl,
        'email': email
      };

  void save(String tag) {
    Preferences.setString(
      '${ApConstants.packageName}'
      '.user_info_$tag',
      toRawJson(),
    );
  }

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
}
