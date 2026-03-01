import 'package:ap_common_core/src/models/user_info.dart';
import 'package:test/test.dart';

void main() {
  group('UserInfo', () {
    test('fromJson should return a valid UserInfo object', () {
      final json = {
        'id': '123',
        'name': 'Test User',
        'department': 'CS',
        'className': '4A',
        'educationSystem': 'Bachelor',
        'email': 'test@example.com',
        'pictureUrl': 'https://example.com/profile.png',
      };

      final userInfo = UserInfo.fromJson(json);

      expect(userInfo.id, '123');
      expect(userInfo.name, 'Test User');
      expect(userInfo.department, 'CS');
      expect(userInfo.className, '4A');
      expect(userInfo.educationSystem, 'Bachelor');
      expect(userInfo.email, 'test@example.com');
      expect(userInfo.pictureUrl, 'https://example.com/profile.png');
    });

    test('toJson should return a valid JSON map', () {
      final userInfo = UserInfo(
        id: '123',
        name: 'Test User',
        department: 'CS',
        className: '4A',
        educationSystem: 'Bachelor',
        email: 'test@example.com',
        pictureUrl: 'https://example.com/profile.png',
      );

      final json = userInfo.toJson();

      expect(json['id'], '123');
      expect(json['name'], 'Test User');
      expect(json['department'], 'CS');
      expect(json['className'], '4A');
      expect(json['educationSystem'], 'Bachelor');
      expect(json['email'], 'test@example.com');
      expect(json['pictureUrl'], 'https://example.com/profile.png');
    });

    test('empty factory should return an empty UserInfo', () {
      final userInfo = UserInfo.empty();

      expect(userInfo.id, '');
      expect(userInfo.name, '');
      expect(userInfo.department, '');
    });

    test('copyWith should return a new object with updated fields', () {
      final userInfo = UserInfo(
        id: '123',
        name: 'Test User',
        department: 'CS',
      );

      final updatedUserInfo = userInfo.copyWith(name: 'New Name');

      expect(updatedUserInfo.id, '123');
      expect(updatedUserInfo.name, 'New Name');
      expect(updatedUserInfo.department, 'CS');
    });
  });
}
