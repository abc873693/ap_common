import 'package:ap_common_core/src/models/notification_data.dart';
import 'package:test/test.dart';

void main() {
  group('NotificationsData', () {
    test('fromJson should return a valid NotificationsData object', () {
      final Map<String, Map<String, Object>> json =
          <String, Map<String, Object>>{
        'data': <String, Object>{
          'page': 1,
          'notification': <Map<String, Object>>[
            <String, Object>{
              'link': 'https://example.com',
              'info': <String, String>{
                'title': 'Test Title',
                'department': 'CS',
                'date': '2023-01-01',
              },
            }
          ],
        },
      };

      final NotificationsData data = NotificationsData.fromJson(json);

      expect(data.data.notifications.length, 1);
      expect(data.data.notifications[0].info.title, 'Test Title');
    });

    test('toJson should return a valid JSON map', () {
      const Notifications notification = Notifications(
        link: 'https://example.com',
        info: Info(title: 'Test Title', department: 'CS', date: '2023-01-01'),
      );
      const NotificationsData data = NotificationsData(
        data: Data(notifications: <Notifications>[notification], page: 1),
      );

      final Map<String, dynamic> json = data.toJson();

      final Map<String, dynamic> jsonData =
          json['data'] as Map<String, dynamic>;
      expect(jsonData['notification'], isA<List<dynamic>>());
      final Map<String, dynamic> first =
          (jsonData['notification'] as List<dynamic>)[0]
              as Map<String, dynamic>;
      final Map<String, dynamic> info =
          first['info'] as Map<String, dynamic>;
      expect(info['title'], 'Test Title');
    });
  });
}
