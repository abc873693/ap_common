// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

class NewsResponse {
  List<News> data;

  NewsResponse({
    this.data,
  });

  factory NewsResponse.fromRawJson(String str) =>
      NewsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        data: json["data"] == null
            ? null
            : List<News>.from(json["data"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class News {
  String title;
  int weight;
  String imageUrl;
  String url;
  String description;
  DateTime expireTime;

  News({
    this.title,
    this.weight,
    this.imageUrl,
    this.url,
    this.description,
    this.expireTime,
  });

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(Map<String, dynamic> json) => News(
        title: json["title"] == null ? null : json["title"],
        weight: json["weight"] == null ? null : json["weight"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        url: json["url"] == null ? null : json["url"],
        description: json["description"] == null ? null : json["description"],
        expireTime: json["expireTime"] == null
            ? null
            : DateTime.parse(json["expireTime"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "weight": weight == null ? null : weight,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "url": url == null ? null : url,
        "description": description == null ? null : description,
        "expireTime": expireTime == null ? null : expireTime.toIso8601String(),
      };
}
