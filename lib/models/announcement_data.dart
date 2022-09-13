import 'dart:convert';
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'announcement_data.g.dart';

@JsonSerializable()
class AnnouncementData {
  AnnouncementData({
    this.data,
  });

  factory AnnouncementData.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDataFromJson(json);

  factory AnnouncementData.fromRawJson(String str) => AnnouncementData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  List<Announcement>? data;

  Map<String, dynamic> toJson() => _$AnnouncementDataToJson(this);

  String toRawJson() => jsonEncode(toJson());

  void sortAndRandom() {
    final Random random = Random();
    for (final Announcement i in data ?? <Announcement>[]) {
      i.randomWeight = random.nextInt(1000);
    }
    data?.sort((Announcement a, Announcement b) {
      final int compare = b.weight!.compareTo(a.weight!);
      final int compareRandom = b.randomWeight!.compareTo(a.randomWeight!);
      return compare == 0 ? compareRandom : compare;
    });
  }
}

@JsonSerializable()
class Announcement {
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

  factory Announcement.fromRawJson(String str) => Announcement.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

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
  @JsonKey(name: 'application_id')
  String? applicationId;
  bool? reviewStatus;
  String? reviewDescription;
  @JsonKey(name: 'tag')
  List<String>? tags;
  @JsonKey(ignore: true)
  int? randomWeight;

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  String toRawJson() => jsonEncode(toJson());

  String toRawUpdateJson() => json.encode(toUpdateJson());

  Map<String, dynamic> toUpdateJson() => <String, dynamic>{
        'title': title,
        'weight': weight,
        'imgUrl': imgUrl,
        'url': url,
        'description': description,
        'expireTime': expireTime,
        'tag': tags,
      };

  Map<String, dynamic> toUpdateApplicationJson() => <String, dynamic>{
        'title': title,
        'weight': weight,
        'imgUrl': imgUrl,
        'url': url,
        'description': description,
        'expireTime': expireTime,
        'tag': tags,
      };

  Map<String, dynamic> toAddApplicationJson(String fcmToken) =>
      <String, dynamic>{
        'title': title,
        'weight': weight,
        'imgUrl': imgUrl,
        'url': url,
        'description': description,
        'expireTime': expireTime,
        'tag': tags,
      };
}
