import 'package:ap_common_core/src/models/course_data.dart' show TimeCode;
import 'package:ap_common_core/src/models/time_code.dart';
import 'package:test/test.dart';

void main() {
  group('TimeCodeConfig', () {
    test('fromJson should return a valid TimeCodeConfig object', () {
      final json = {
        'timeCodes': [
          {
            'title': '1',
            'startTime': '08:00',
            'endTime': '08:50',
          }
        ],
      };

      final data = TimeCodeConfig.fromJson(json);

      expect(data.timeCodes.length, 1);
      expect(data.timeCodes[0].title, '1');
    });

    test('toJson should return a valid JSON map', () {
      final config = TimeCodeConfig(
        timeCodes: [
          TimeCode(title: '1', startTime: '08:00', endTime: '08:50'),
        ],
      );

      final json = config.toJson();

      expect(json['timeCodes'], isA<List>());
      expect(json['timeCodes'][0]['title'], '1');
    });

    test('textList should return list of titles', () {
      final config = TimeCodeConfig(
        timeCodes: [
          TimeCode(title: '1', startTime: '08:00', endTime: '08:50'),
          TimeCode(title: '2', startTime: '09:00', endTime: '09:50'),
        ],
      );

      expect(config.textList, ['1', '2']);
    });

    test('indexOf should return correct index', () {
      final config = TimeCodeConfig(
        timeCodes: [
          TimeCode(title: '1', startTime: '08:00', endTime: '08:50'),
          TimeCode(title: '2', startTime: '09:00', endTime: '09:50'),
        ],
      );

      expect(config.indexOf('2'), 1);
      expect(config.indexOf('3'), -1);
    });
  });
}
