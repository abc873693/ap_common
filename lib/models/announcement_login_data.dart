import 'dart:convert';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum PermissionLevel { user, editor, admin }

class AnnouncementLoginData {
  AnnouncementLoginData({
    this.key,
  });

  String? key;

  AnnouncementLoginData copyWith({
    String? key,
  }) =>
      AnnouncementLoginData(
        key: key ?? this.key,
      );

  factory AnnouncementLoginData.fromRawJson(String str) =>
      AnnouncementLoginData.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory AnnouncementLoginData.fromJson(Map<String, dynamic> json) =>
      AnnouncementLoginData(
        key: json['key'] as String,
      );

  Map<String, dynamic> toJson() => {
        'key': key,
      };

  Map<String, dynamic> get decodedToken => JwtDecoder.decode(key!);

  bool get isExpired => JwtDecoder.isExpired(key!);

  PermissionLevel get level =>
      PermissionLevel.values[decodedToken['user']['permission_level'] as int];

  String? get loginType => decodedToken['user']['login_type'] as String;

  String? get username => decodedToken['user']['username'] as String;

  void save() {
    Preferences.setStringSecurity(
      '${ApConstants.packageName}'
      '.announcement_login_data',
      toRawJson(),
    );
  }

  static AnnouncementLoginData? load() {
    final String? rawString = Preferences.getStringSecurity(
      '${ApConstants.packageName}'
          '.announcement_login_data',
      '',
    );
    if (rawString == '') {
      return null;
    } else {
      return AnnouncementLoginData.fromRawJson(rawString!);
    }
  }
}
