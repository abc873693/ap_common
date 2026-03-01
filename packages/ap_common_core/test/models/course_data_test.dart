import 'package:ap_common_core/src/models/course_data.dart';
import 'package:test/test.dart';

void main() {
  group('CourseData', () {
    test('fromJson should return a valid CourseData object', () {
      final json = {
        'courses': [
          {
            'code': 'CS101',
            'title': 'Intro to CS',
            'className': '1A',
            'group': 'A',
            'units': '3.0',
            'hours': '3.0',
            'required': 'Required',
            'at': 'Mon 1-3',
            'sectionTimes': [
              {'weekday': 1, 'index': 0}
            ],
            'instructors': ['John Doe'],
            'location': {'room': '101', 'building': 'Room'},
          }
        ],
        'timeCodes': [
          {'title': '1', 'startTime': '08:00', 'endTime': '08:50'}
        ],
      };

      final data = CourseData.fromJson(json);

      expect(data.courses.length, 1);
      expect(data.courses[0].title, 'Intro to CS');
      expect(data.timeCodes.length, 1);
    });

    test('toJson should return a valid JSON map', () {
      final course = Course(
        code: 'CS101',
        title: 'Intro to CS',
        units: '3.0',
        times: [SectionTime(weekday: 1, index: 0)],
        instructors: ['John Doe'],
      );
      final timeCode =
          TimeCode(title: '1', startTime: '08:00', endTime: '08:50');
      final data = CourseData(courses: [course], timeCodes: [timeCode]);

      final json = data.toJson();

      expect(json['courses'], isA<List>());
      expect(json['courses'][0]['title'], 'Intro to CS');
    });
  });
}
