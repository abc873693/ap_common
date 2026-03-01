import 'package:ap_common_core/src/models/ap_support_language.dart';
import 'package:test/test.dart';

void main() {
  group('ApSupportLanguage', () {
    test('values should contain expected languages', () {
      expect(ApSupportLanguage.values, contains(ApSupportLanguage.zh));
      expect(ApSupportLanguage.values, contains(ApSupportLanguage.en));
    });

    test('code should return correct string', () {
      expect(ApSupportLanguage.zh.code, 'zh');
      expect(ApSupportLanguage.en.code, 'en');
    });
  });
}
