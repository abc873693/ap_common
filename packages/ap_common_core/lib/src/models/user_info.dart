import 'dart:convert';
import 'dart:typed_data';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
abstract class UserInfo with _$UserInfo {

  const factory UserInfo({
    String? educationSystem,
    required String? department,
    String? className,
    required String id,
    required String? name,
    String? pictureUrl,
    String? email,
    @JsonKey(includeToJson: false, includeFromJson: false)
    Uint8List? pictureBytes,
  }) = _UserInfo;
  const UserInfo._();

  factory UserInfo.empty() => const UserInfo(
        id: '',
        department: '',
        name: '',
      );

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  factory UserInfo.fromRawJson(String str) => UserInfo.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  static UserInfo? load(String tag) {
    final String rawString = PreferenceUtil.instance.getString(
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

  String toRawJson() => jsonEncode(toJson());

  void save(String tag) {
    PreferenceUtil.instance.setString(
      '${ApConstants.packageName}'
      '.user_info_$tag',
      toRawJson(),
    );
  }
}
