import 'package:ap_common_core/src/models/course_data.dart';
import 'package:test/test.dart';

void main() {
  group('CourseData', () {
    test('fromJson should return a valid CourseData object', () {
      final Map<String, List<Map<String, Object>>> json =
          <String, List<Map<String, Object>>>{
        'courses': <Map<String, Object>>[
          <String, Object>{
            'code': 'CS101',
            'title': 'Intro to CS',
            'className': '1A',
            'group': 'A',
            'units': '3.0',
            'hours': '3.0',
            'required': 'Required',
            'at': 'Mon 1-3',
            'sectionTimes': <Map<String, int>>[
              <String, int>{'weekday': 1, 'index': 0}
            ],
            'instructors': <String>['John Doe'],
            'location': <String, String>{'room': '101', 'building': 'Room'},
          }
        ],
        'timeCodes': <Map<String, String>>[
          <String, String>{
            'title': '1',
            'startTime': '08:00',
            'endTime': '08:50',
          }
        ],
      };

      final CourseData data = CourseData.fromJson(json);

      expect(data.courses.length, 1);
      expect(data.courses[0].title, 'Intro to CS');
      expect(data.timeCodes.length, 1);
    });

    test('toJson should return a valid JSON map', () {
      final Course course = Course(
        code: 'CS101',
        title: 'Intro to CS',
        units: '3.0',
        times: <SectionTime>[SectionTime(weekday: 1, index: 0)],
        instructors: <String>['John Doe'],
      );
      final TimeCode timeCode =
          TimeCode(title: '1', startTime: '08:00', endTime: '08:50');
      final CourseData data = CourseData(
        courses: <Course>[course],
        timeCodes: <TimeCode>[timeCode],
      );

      final Map<String, dynamic> json = data.toJson();

      expect(json['courses'], isA<List<dynamic>>());
      expect(json['courses'][0]['title'], 'Intro to CS');
    });
  });
}
