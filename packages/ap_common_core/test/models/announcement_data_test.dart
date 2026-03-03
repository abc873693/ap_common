import 'package:ap_common_core/src/models/announcement_data.dart';
import 'package:test/test.dart';

void main() {
  group('AnnouncementData', () {
    test('fromJson should return a valid AnnouncementData object', () {
      final Map<String, List<Map<String, Object>>> json =
          <String, List<Map<String, Object>>>{
        'data': <Map<String, Object>>[
          <String, Object>{
            'title': 'Test Title',
            'id': 1,
            'weight': 10,
            'imgUrl': 'https://example.com/image.png',
            'description': 'Test Description',
          }
        ],
      };

      final AnnouncementData announcementData = AnnouncementData.fromJson(json);

      expect(announcementData.data.length, 1);
      expect(announcementData.data[0].title, 'Test Title');
      expect(announcementData.data[0].id, 1);
      expect(announcementData.data[0].weight, 10);
      expect(announcementData.data[0].imgUrl, 'https://example.com/image.png');
      expect(announcementData.data[0].description, 'Test Description');
    });

    test('toJson should return a valid JSON map', () {
      const Announcement announcement = Announcement(
        title: 'Test Title',
        id: 1,
        weight: 10,
        imgUrl: 'https://example.com/image.png',
        description: 'Test Description',
      );
      final AnnouncementData announcementData =
          AnnouncementData(data: <Announcement>[announcement]);

      final Map<String, dynamic> json = announcementData.toJson();

      expect(json['data'], isA<List<dynamic>>());
      expect(json['data'][0]['title'], 'Test Title');
      expect(json['data'][0]['id'], 1);
      expect(json['data'][0]['weight'], 10);
      expect(json['data'][0]['imgUrl'], 'https://example.com/image.png');
      expect(json['data'][0]['description'], 'Test Description');
    });

    test('sortedData should return announcements sorted by weight descending',
        () {
      const Announcement a1 = Announcement(
        title: 'A1',
        id: 1,
        weight: 10,
        imgUrl: '',
        description: '',
      );
      const Announcement a2 = Announcement(
        title: 'A2',
        id: 2,
        weight: 20,
        imgUrl: '',
        description: '',
      );
      const Announcement a3 = Announcement(
        title: 'A3',
        id: 3,
        weight: 5,
        imgUrl: '',
        description: '',
      );

      final AnnouncementData announcementData =
          AnnouncementData(data: <Announcement>[a1, a2, a3]);
      final List<Announcement> sorted = announcementData.sortedData;

      expect(sorted[0].title, 'A2'); // Highest weight
      expect(sorted[1].title, 'A1');
      expect(sorted[2].title, 'A3'); // Lowest weight
    });
  });

  group('Announcement', () {
    test('empty factory should return an empty Announcement', () {
      final Announcement announcement = Announcement.empty();

      expect(announcement.title, '');
      expect(announcement.weight, 0);
      expect(announcement.imgUrl, '');
      expect(announcement.description, '');
    });

    test('toUpdateJson should return a map with update fields', () {
      const Announcement announcement = Announcement(
        title: 'Test Title',
        id: 1,
        weight: 10,
        imgUrl: 'https://example.com/image.png',
        description: 'Test Description',
        tags: <String>['tag1', 'tag2'],
      );

      final Map<String, dynamic> updateJson = announcement.toUpdateJson();

      expect(updateJson['title'], 'Test Title');
      expect(updateJson['weight'], 10);
      expect(updateJson['imgUrl'], 'https://example.com/image.png');
      expect(updateJson['tag'], <String>['tag1', 'tag2']);
    });
  });
}
