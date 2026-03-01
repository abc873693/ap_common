import 'package:ap_common_core/src/models/version_info.dart';
import 'package:test/test.dart';

void main() {
  group('VersionInfo', () {
    test('should create a VersionInfo with correct values', () {
      final data = VersionInfo(
        code: 1,
        isForceUpdate: true,
        content: 'Test Content',
      );

      expect(data.code, 1);
      expect(data.isForceUpdate, true);
      expect(data.content, 'Test Content');
    });

    test('isForceUpdate should default to false when set explicitly', () {
      final data = VersionInfo(
        code: 2,
        isForceUpdate: false,
        content: 'No update needed',
      );

      expect(data.isForceUpdate, false);
    });
  });
}
