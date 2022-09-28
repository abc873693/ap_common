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
    required this.department,
    this.className,
    required this.id,
    required this.name,
    this.pictureUrl,
    this.pictureBytes,
    this.email,
  });

  factory UserInfo.empty() => UserInfo(
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

  final String? educationSystem;
  final String? department;
  final String? className;
  final String id;
  final String? name;
  final String? pictureUrl;
  final String? email;

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

  UserInfo copyWith({
    String? id,
    String? educationSystem,
    String? department,
    String? className,
    String? name,
    String? pictureUrl,
    String? email,
    Uint8List? pictureBytes,
  }) {
    return UserInfo(
      id: id ?? this.id,
      educationSystem: educationSystem ?? this.educationSystem,
      department: department ?? this.department,
      className: className ?? this.className,
      name: name ?? this.name,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      email: email ?? this.email,
      pictureBytes: pictureBytes ?? this.pictureBytes,
    );
  }
}
