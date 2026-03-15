import 'package:ap_common_core/src/models/announcement_login_data.dart';
import 'package:test/test.dart';

void main() {
  group('AnnouncementLoginData', () {
    test('fromJson should return a valid AnnouncementLoginData object', () {
      final Map<String, String> json = <String, String>{
        'key': 'test_key',
      };

      final AnnouncementLoginData data = AnnouncementLoginData.fromJson(json);

      expect(data.key, 'test_key');
    });

    test('toJson should return a valid JSON map', () {
      final AnnouncementLoginData data = AnnouncementLoginData(key: 'test_key');

      final Map<String, dynamic> json = data.toJson();

      expect(json['key'], 'test_key');
    });
  });
}
