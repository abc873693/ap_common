import 'dart:convert';

class AnnouncementLoginData {
  AnnouncementLoginData({
    this.key,
  });

  String key;

  AnnouncementLoginData copyWith({
    String key,
  }) =>
      AnnouncementLoginData(
        key: key ?? this.key,
      );

  factory AnnouncementLoginData.fromRawJson(String str) =>
      AnnouncementLoginData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnnouncementLoginData.fromJson(Map<String, dynamic> json) =>
      AnnouncementLoginData(
        key: json["key"] == null ? null : json["key"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
      };
}
