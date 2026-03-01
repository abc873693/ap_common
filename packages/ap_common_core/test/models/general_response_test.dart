import 'package:ap_common_core/src/models/general_response.dart';
import 'package:test/test.dart';

void main() {
  group('GeneralResponse', () {
    test('fromJson should return a valid GeneralResponse object', () {
      final json = {
        'code': 200,
        'description': 'Success',
      };

      final data = GeneralResponse.fromJson(json);

      expect(data.statusCode, 200);
      expect(data.message, 'Success');
    });

    test('toJson should return a valid JSON map', () {
      final data = GeneralResponse(statusCode: 200, message: 'Success');

      final json = data.toJson();

      expect(json['code'], 200);
      expect(json['description'], 'Success');
    });
  });
}
