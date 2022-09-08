import 'dart:convert';
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'announcement_data.g.dart';

@JsonSerializable()
class AnnouncementData {
  List<Announcement>? data;

  AnnouncementData({
    this.data,
  });

  factory AnnouncementData.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDataFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementDataToJson(this);

  factory AnnouncementData.fromRawJson(String str) => AnnouncementData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());

  void sortAndRandom() {
    final random = Random();
    for (final Announcement i in data ?? []) {
      i.randomWeight = random.nextInt(1000);
    }
    data?.sort((a, b) {
      final compare = b.weight!.compareTo(a.weight!);
      final compareRandom = b.randomWeight!.compareTo(a.randomWeight!);
      return compare == 0 ? compareRandom : compare;
    });
  }
}

@JsonSerializable()
class Announcement {
  String? title;
  int? id;
  int? nextId;
  int? lastId;
  int? weight;
  String? imgUrl;
  String? url;
  String? description;
  String? publishedTime;
  String? expireTime;
  String? applicant;
  String? applicationId;
  bool? reviewStatus;
  String? reviewDescription;
  @JsonKey(name: 'tag')
  List<String>? tags;
  int? randomWeight;

  Announcement({
    this.title,
    this.id,
    this.nextId,
    this.lastId,
    this.weight,
    this.imgUrl,
    this.url,
    this.description,
    this.publishedTime,
    this.expireTime,
    this.applicant,
    this.applicationId,
    this.reviewStatus,
    this.reviewDescription,
    this.tags,
    this.randomWeight,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  factory Announcement.fromRawJson(String str) => Announcement.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => jsonEncode(toJson());

  String toRawUpdateJson() => json.encode(toUpdateJson());

  Map<String, dynamic> toUpdateJson() => {
        'title': title,
        'weight': weight,
        'imgUrl': imgUrl,
        'url': url,
        'description': description,
        'expireTime': expireTime,
        'tag': tags,
      };

  Map<String, dynamic> toUpdateApplicationJson() => {
        'title': title,
        'weight': weight,
        'imgUrl': imgUrl,
        'url': url,
        'description': description,
        'expireTime': expireTime,
        'tag': tags,
      };

  Map<String, dynamic> toAddApplicationJson(String fcmToken) => {
        'title': title,
        'weight': weight,
        'imgUrl': imgUrl,
        'url': url,
        'description': description,
        'expireTime': expireTime,
        'tag': tags,
      };
}
