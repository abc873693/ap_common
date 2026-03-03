import 'package:ap_common_core/src/models/phone_model.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneModel', () {
    test('should create a PhoneModel with correct values', () {
      final PhoneModel data = PhoneModel('Test Phone', '123456789');

      expect(data.name, 'Test Phone');
      expect(data.number, '123456789');
    });
  });
}
