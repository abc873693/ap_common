import 'package:ap_common_core/src/models/semester_data.dart';
import 'package:test/test.dart';

void main() {
  group('SemesterData', () {
    test('fromJson should return a valid SemesterData object', () {
      final json = {
        'data': [
          {
            'year': '112',
            'value': '1',
            'text': '112-1',
          }
        ],
        'default': {
          'year': '112',
          'value': '1',
          'text': '112-1',
        },
      };

      final data = SemesterData.fromJson(json);

      expect(data.data.length, 1);
      expect(data.data[0].year, '112');
      expect(data.defaultSemester.year, '112');
    });

    test('toJson should return a valid JSON map', () {
      final semester = Semester(year: '112', value: '1', text: '112-1');
      final data = SemesterData(
        data: [semester],
        defaultSemester: Semester(year: '112', value: '1', text: '112-1'),
      );

      final json = data.toJson();

      expect(json['data'], isA<List>());
      expect(json['data'][0]['year'], '112');
    });
  });
}
