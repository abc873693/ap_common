import 'dart:convert';

class AnnouncementData {
  List<Announcement> data;

  AnnouncementData({
    this.data,
  });

  factory AnnouncementData.fromRawJson(String str) =>
      AnnouncementData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnnouncementData.fromJson(Map<String, dynamic> json) =>
      AnnouncementData(
        data: json["data"] == null
            ? null
            : List<Announcement>.from(
                json["data"].map((x) => Announcement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Announcement {
  String title;
  int id;
  int nextId;
  int lastId;
  int weight;
  String imgUrl;
  String url;
  String description;
  String publishedTime;
  String expireTime;

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
  });

  factory Announcement.fromRawJson(String str) =>
      Announcement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  String toRawUpdateJson() => json.encode(toUpdateJson());

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        title: json["title"],
        id: json["id"],
        nextId: json["nextId"],
        lastId: json["lastId"],
        weight: json["weight"],
        imgUrl: json["imgUrl"],
        url: json["url"],
        description: json["description"],
        publishedTime: json["publishedTime"],
        expireTime: json["expireTime"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "nextId": nextId,
        "lastId": lastId,
        "weight": weight,
        "imgUrl": imgUrl,
        "url": url,
        "description": description,
        "publishedTime": publishedTime,
        "expireTime": expireTime,
      };

  Map<String, dynamic> toUpdateJson() => {
        "title": title,
        "weight": weight,
        "imgUrl": imgUrl,
        "url": url,
        "description": description,
        "expireTime": expireTime,
      };
}
