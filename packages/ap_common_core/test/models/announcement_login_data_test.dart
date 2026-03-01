import 'package:ap_common_core/src/models/announcement_login_data.dart';
import 'package:test/test.dart';

void main() {
  group('AnnouncementLoginData', () {
    test('fromJson should return a valid AnnouncementLoginData object', () {
      final json = {
        'key': 'test_key',
      };

      final data = AnnouncementLoginData.fromJson(json);

      expect(data.key, 'test_key');
    });

    test('toJson should return a valid JSON map', () {
      final data = AnnouncementLoginData(key: 'test_key');

      final json = data.toJson();

      expect(json['key'], 'test_key');
    });
  });
}
