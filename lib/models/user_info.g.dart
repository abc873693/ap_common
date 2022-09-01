// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      educationSystem: json['educationSystem'] as String?,
      department: json['department'] as String?,
      className: json['className'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'educationSystem': instance.educationSystem,
      'department': instance.department,
      'className': instance.className,
      'id': instance.id,
      'name': instance.name,
      'pictureUrl': instance.pictureUrl,
      'email': instance.email,
    };
