import 'package:ap_common_core/src/models/score_data.dart';
import 'package:test/test.dart';

void main() {
  group('ScoreData', () {
    test('fromJson should return a valid ScoreData object', () {
      final json = {
        'scores': [
          {
            'courseNumber': 'CS101',
            'title': 'Intro to CS',
            'units': '3.0',
            'hours': null,
            'required': null,
            'at': null,
            'middleScore': null,
            'generalScore': null,
            'finalScore': null,
            'semesterScore': '90',
            'remark': null,
          }
        ],
        'detail': {
          'average': 85.5,
          'conduct': 90.0,
          'classRank': '5/50',
          'departmentRank': '10/200',
        },
      };

      final data = ScoreData.fromJson(json);

      expect(data.scores.length, 1);
      expect(data.scores[0].title, 'Intro to CS');
      expect(data.detail.average, 85.5);
    });

    test('toJson should return a valid JSON map', () {
      final score = Score(
        courseNumber: 'CS101',
        title: 'Intro to CS',
        units: '3.0',
        hours: null,
        required: null,
        at: null,
        middleScore: null,
        generalScore: null,
        finalScore: null,
        semesterScore: '90',
        remark: null,
      );
      final data = ScoreData(scores: [score], detail: const Detail());

      final json = data.toJson();

      expect(json['scores'], isA<List>());
      expect(json['scores'][0]['title'], 'Intro to CS');
    });

    test('ScoreData.empty() should return empty ScoreData', () {
      final data = ScoreData.empty();

      expect(data.scores, isEmpty);
      expect(data.detail.average, 0.0);
    });
  });

  group('Detail', () {
    test('Detail() should have all nullable fields as null', () {
      const detail = Detail();
      expect(detail.creditTaken, isNull);
      expect(detail.average, isNull);
    });

    test('Detail.empty() should have default zero values', () {
      final detail = Detail.empty();
      expect(detail.creditTaken, 0.0);
      expect(detail.average, 0.0);
    });
  });
}
