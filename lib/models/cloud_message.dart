import 'package:hive/hive.dart';

part 'cloud_message.g.dart';

@HiveType(typeId: CloudMessage.typeId)
class CloudMessage extends HiveObject {
  static const int typeId = 100;

  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime? dateTime;

  @HiveField(2)
  String? content;

  @HiveField(3)
  String? url;

  @HiveField(4)
  String? imageUrl;

  @HiveField(5)
  Map<String, dynamic>? data;

  CloudMessage({
    required this.title,
    this.dateTime,
    this.content,
    this.url,
    this.imageUrl,
    this.data,
  });

  factory CloudMessage.sample() => CloudMessage(
        title: '測試',
        dateTime: DateTime.now(),
        content: '測試用訊息',
      );
}
