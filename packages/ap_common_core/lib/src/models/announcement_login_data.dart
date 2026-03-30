import 'dart:convert';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'announcement_login_data.freezed.dart';
part 'announcement_login_data.g.dart';

enum PermissionLevel { user, editor, admin }

@freezed
abstract class AnnouncementLoginData with _$AnnouncementLoginData {

  const factory AnnouncementLoginData({
    required String key,
  }) = _AnnouncementLoginData;
  const AnnouncementLoginData._();

  factory AnnouncementLoginData.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementLoginDataFromJson(json);

  factory AnnouncementLoginData.fromRawJson(String str) =>
      AnnouncementLoginData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  Map<String, dynamic> get decodedToken => JwtDecoder.decode(key);

  bool get isExpired => JwtDecoder.isExpired(key);

  PermissionLevel get level =>
      //ignore: avoid_dynamic_calls
      PermissionLevel.values[decodedToken['user']['permission_level'] as int];

  //ignore: avoid_dynamic_calls
  String? get loginType => decodedToken['user']['login_type'] as String;

  //ignore: avoid_dynamic_calls
  String? get username => decodedToken['user']['username'] as String;

  String toRawJson() => jsonEncode(toJson());

  void save() {
    PreferenceUtil.instance.setStringSecurity(
      '${ApConstants.packageName}'
      '.announcement_login_data',
      toRawJson(),
    );
  }

  static AnnouncementLoginData? load() {
    final String rawString = PreferenceUtil.instance.getStringSecurity(
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
