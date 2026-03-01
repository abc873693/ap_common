import 'package:ap_common_core/src/models/notification_data.dart';
import 'package:test/test.dart';

void main() {
  group('NotificationsData', () {
    test('fromJson should return a valid NotificationsData object', () {
      final json = {
        'data': {
          'page': 1,
          'notification': [
            {
              'link': 'https://example.com',
              'info': {
                'title': 'Test Title',
                'department': 'CS',
                'date': '2023-01-01',
              },
            }
          ],
        },
      };

      final data = NotificationsData.fromJson(json);

      expect(data.data.notifications.length, 1);
      expect(data.data.notifications[0].info.title, 'Test Title');
    });

    test('toJson should return a valid JSON map', () {
      final notification = Notifications(
        link: 'https://example.com',
        info: Info(title: 'Test Title', department: 'CS', date: '2023-01-01'),
      );
      final data = NotificationsData(
        data: Data(notifications: [notification], page: 1),
      );

      final json = data.toJson();

      expect(json['data']['notification'], isA<List>());
      expect(json['data']['notification'][0]['info']['title'], 'Test Title');
    });
  });
}
