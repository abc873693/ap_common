import 'package:ap_common_core/src/models/semester_data.dart';
import 'package:test/test.dart';

void main() {
  group('SemesterData', () {
    test('fromJson should return a valid SemesterData object', () {
      final Map<String, Object> json = <String, Object>{
        'data': <Map<String, String>>[
          <String, String>{
            'year': '112',
            'value': '1',
            'text': '112-1',
          }
        ],
        'default': <String, String>{
          'year': '112',
          'value': '1',
          'text': '112-1',
        },
      };

      final SemesterData data = SemesterData.fromJson(json);

      expect(data.data.length, 1);
      expect(data.data[0].year, '112');
      expect(data.defaultSemester.year, '112');
    });

    test('toJson should return a valid JSON map', () {
      const Semester semester =
          Semester(year: '112', value: '1', text: '112-1');
      const SemesterData data = SemesterData(
        data: <Semester>[semester],
        defaultSemester: Semester(year: '112', value: '1', text: '112-1'),
      );

      final Map<String, dynamic> json = data.toJson();

      expect(json['data'], isA<List<dynamic>>());
      final Map<String, dynamic> first =
          (json['data'] as List<dynamic>)[0] as Map<String, dynamic>;
      expect(first['year'], '112');
    });
  });
}
