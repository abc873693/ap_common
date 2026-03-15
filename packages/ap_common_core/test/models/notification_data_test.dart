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
      final Notifications notification = Notifications(
        link: 'https://example.com',
        info: Info(title: 'Test Title', department: 'CS', date: '2023-01-01'),
      );
      final NotificationsData data = NotificationsData(
        data: Data(notifications: <Notifications>[notification], page: 1),
      );

      final Map<String, dynamic> json = data.toJson();

      expect(json['data']['notification'], isA<List<dynamic>>());
      expect(json['data']['notification'][0]['info']['title'], 'Test Title');
    });
  });
}
