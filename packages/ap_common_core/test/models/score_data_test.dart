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
            'semesterScore': '90',
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
        semesterScore: '90',
      );
      final data = ScoreData(scores: [score], detail: Detail());

      final json = data.toJson();

      expect(json['scores'], isA<List>());
      expect(json['scores'][0]['title'], 'Intro to CS');
    });

    test('ScoreData.empty() should return empty ScoreData', () {
      final data = ScoreData.empty();

      expect(data.scores, isEmpty);
      expect(data.detail.average, isNull);
    });
  });

  group('Detail', () {
    test('isCreditEmpty should return true when credits are null', () {
      final detail = Detail();
      expect(detail.isCreditEmpty, isTrue);
    });

    test('isCreditEmpty should return false when creditTaken is set', () {
      final detail = Detail(creditTaken: 15.0);
      expect(detail.isCreditEmpty, isFalse);
    });
  });
}
