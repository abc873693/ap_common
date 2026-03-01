import 'package:ap_common_core/src/models/announcement_data.dart';
import 'package:test/test.dart';

void main() {
  group('AnnouncementData', () {
    test('fromJson should return a valid AnnouncementData object', () {
      final json = {
        'data': [
          {
            'title': 'Test Title',
            'id': 1,
            'weight': 10,
            'imgUrl': 'https://example.com/image.png',
            'description': 'Test Description',
          }
        ],
      };

      final announcementData = AnnouncementData.fromJson(json);

      expect(announcementData.data.length, 1);
      expect(announcementData.data[0].title, 'Test Title');
      expect(announcementData.data[0].id, 1);
      expect(announcementData.data[0].weight, 10);
      expect(announcementData.data[0].imgUrl, 'https://example.com/image.png');
      expect(announcementData.data[0].description, 'Test Description');
    });

    test('toJson should return a valid JSON map', () {
      final announcement = Announcement(
        title: 'Test Title',
        id: 1,
        weight: 10,
        imgUrl: 'https://example.com/image.png',
        description: 'Test Description',
      );
      final announcementData = AnnouncementData(data: [announcement]);

      final json = announcementData.toJson();

      expect(json['data'], isA<List>());
      expect(json['data'][0]['title'], 'Test Title');
      expect(json['data'][0]['id'], 1);
      expect(json['data'][0]['weight'], 10);
      expect(json['data'][0]['imgUrl'], 'https://example.com/image.png');
      expect(json['data'][0]['description'], 'Test Description');
    });

    test(
        'sortAndRandom should sort announcements by weight and then randomWeight',
        () {
      final a1 = Announcement(
        title: 'A1',
        id: 1,
        weight: 10,
        imgUrl: '',
        description: '',
        randomWeight: 100,
      );
      final a2 = Announcement(
        title: 'A2',
        id: 2,
        weight: 20,
        imgUrl: '',
        description: '',
        randomWeight: 50,
      );
      final a3 = Announcement(
        title: 'A3',
        id: 3,
        weight: 10,
        imgUrl: '',
        description: '',
        randomWeight: 200,
      );

      final announcementData = AnnouncementData(data: [a1, a2, a3]);
      announcementData.sortAndRandom();

      expect(announcementData.data[0].title, 'A2'); // Highest weight
      expect(announcementData.data[1].title,
          'A3'); // Same weight, higher randomWeight
      expect(announcementData.data[2].title,
          'A1'); // Same weight, lower randomWeight
    });
  });

  group('Announcement', () {
    test('empty factory should return an empty Announcement', () {
      final announcement = Announcement.empty();

      expect(announcement.title, '');
      expect(announcement.id, 0);
      expect(announcement.weight, 0);
      expect(announcement.imgUrl, '');
      expect(announcement.description, '');
    });

    test('toUpdateJson should return a map with update fields', () {
      final announcement = Announcement(
        title: 'Test Title',
        id: 1,
        weight: 10,
        imgUrl: 'https://example.com/image.png',
        description: 'Test Description',
        tags: ['tag1', 'tag2'],
      );

      final updateJson = announcement.toUpdateJson();

      expect(updateJson['title'], 'Test Title');
      expect(updateJson['weight'], 10);
      expect(updateJson['imgUrl'], 'https://example.com/image.png');
      expect(updateJson['tag'], ['tag1', 'tag2']);
    });
  });
}
