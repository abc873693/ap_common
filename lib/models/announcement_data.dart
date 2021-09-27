import 'dart:convert';
import 'dart:math';

class AnnouncementData {
  List<Announcement>? data;

  AnnouncementData({
    this.data,
  });

  factory AnnouncementData.fromRawJson(String str) => AnnouncementData.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  String toRawJson() => json.encode(toJson());

  factory AnnouncementData.fromJson(Map<String, dynamic> json) =>
      AnnouncementData(
        data: json['data'] == null
            ? null
            : List<Announcement>.from(
                (json['data'] as List<dynamic>).map<Announcement>(
                  // ignore: always_specify_types
                  (x) => Announcement.fromJson(x as Map<String, dynamic>),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        'data': data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  void sortAndRandom() {
    final random = Random();
    for (final i in data ?? []) {
      i.randomWeight = random.nextInt(1000);
    }
    data?.sort((a, b) {
      final compare = b.weight!.compareTo(a.weight!);
      final compareRandom = b.randomWeight!.compareTo(a.randomWeight!);
      return compare == 0 ? compareRandom : compare;
    });
  }
}

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
  List<String?>? tags;
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

  factory Announcement.fromRawJson(String str) =>
      Announcement.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  String toRawUpdateJson() => json.encode(toUpdateJson());

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        title: json['title'] as String,
        id: json['id'] as int,
        nextId: json['nextId'] as int,
        lastId: json['lastId'] as int,
        weight: json['weight'] as int,
        imgUrl: json['imgUrl'] as String,
        url: json['url'] as String,
        description: json['description'] as String,
        publishedTime: json['publishedTime'] as String,
        expireTime: json['expireTime'] as String,
        applicant: json['applicant'] as String,
        applicationId: json['application_id'] as String,
        reviewStatus: json['reviewStatus'] as bool,
        reviewDescription: json['reviewDescription'] as String,
        tags: List<String>.from(
          (json['tag'] as List<dynamic>).map(
            (dynamic x) => x,
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'nextId': nextId,
        'lastId': lastId,
        'weight': weight,
        'imgUrl': imgUrl,
        'url': url,
        'description': description,
        'publishedTime': publishedTime,
        'expireTime': expireTime,
        'applicant': applicant,
        'application_id': expireTime,
        'reviewStatus': reviewStatus,
        'reviewDescription': reviewDescription,
        'tag': tags,
      };

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
