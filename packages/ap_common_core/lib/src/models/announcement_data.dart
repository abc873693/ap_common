import 'dart:convert';

import 'package:ap_common_core/src/config/ap_constants.dart';
import 'package:ap_common_core/src/utilities/preference_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_data.freezed.dart';
part 'announcement_data.g.dart';

@freezed
abstract class AnnouncementData with _$AnnouncementData {

  const factory AnnouncementData({
    required List<Announcement> data,
  }) = _AnnouncementData;
  const AnnouncementData._();

  factory AnnouncementData.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDataFromJson(json);

  factory AnnouncementData.fromRawJson(String str) => AnnouncementData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  static AnnouncementData? load(String tag) {
    final String rawString = PreferenceUtil.instance.getString(
      '${ApConstants.packageName}'
          '.announcement_data_$tag',
      '',
    );
    if (rawString == '') {
      return null;
    } else {
      return AnnouncementData.fromRawJson(rawString);
    }
  }

  void save(String tag) {
    PreferenceUtil.instance.setString(
      '${ApConstants.packageName}'
      '.announcement_data_$tag',
      toRawJson(),
    );
  }

  String toRawJson() => jsonEncode(toJson());

  List<Announcement> get sortedData {
    // Sort logic moved to a getter or method as Freezed classes are immutable
    final List<Announcement> sortedData = List<Announcement>.from(data);
    sortedData.sort((Announcement a, Announcement b) {
      return b.weight.compareTo(a.weight);
    });
    return sortedData;
  }
}

@freezed
abstract class Announcement with _$Announcement {

  const factory Announcement({
    required String title,
    int? id,
    int? nextId,
    int? lastId,
    required int weight,
    required String imgUrl,
    String? url,
    required String description,
    String? publishedTime,
    String? expireTime,
    String? applicant,
    @JsonKey(name: 'application_id') String? applicationId,
    bool? reviewStatus,
    String? reviewDescription,
    @JsonKey(name: 'tag') List<String>? tags,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(0)
    int randomWeight,
  }) = _Announcement;
  const Announcement._();

  factory Announcement.empty() => const Announcement(
        title: '',
        weight: 0,
        imgUrl: '',
        description: '',
      );

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  factory Announcement.fromRawJson(String str) => Announcement.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

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
