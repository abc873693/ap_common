import 'package:ap_common_flutter_ui/src/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Toast constants', () {
    test('lengthShort should be 1', () {
      expect(Toast.lengthShort, 1);
    });

    test('lengthLong should be 2', () {
      expect(Toast.lengthLong, 2);
    });

    test('bottom should be 0', () {
      expect(Toast.bottom, 0);
    });

    test('center should be 1', () {
      expect(Toast.center, 1);
    });

    test('top should be 2', () {
      expect(Toast.top, 2);
    });
  });

  group('ToastWidget', () {
    testWidgets('should position at bottom when gravity is 0',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Stack(
            children: <Widget>[
              ToastWidget(
                widget: SizedBox(),
                gravity: Toast.bottom,
              ),
            ],
          ),
        ),
      );

      final Positioned positioned =
          tester.widget<Positioned>(find.byType(Positioned));
      expect(positioned.top, isNull);
      expect(positioned.bottom, isNotNull);
    });

    testWidgets('should position at top when gravity is 2',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Stack(
            children: <Widget>[
              ToastWidget(
                widget: SizedBox(),
                gravity: Toast.top,
              ),
            ],
          ),
        ),
      );

      final Positioned positioned =
          tester.widget<Positioned>(find.byType(Positioned));
      expect(positioned.top, isNotNull);
      expect(positioned.bottom, isNull);
    });
  });
}
