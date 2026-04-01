import 'package:ap_common_core/ap_common_core.dart';
import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  setUpAll(() {
    injector.registerSingleton<PreferenceUtil>(() => MockPreferenceUtil());
    injector.registerSingleton<UiUtil>(() => MockUiUtil());
    injector.registerSingleton<AnalyticsUtil>(() => const MockAnalyticsUtil());
  });

  Widget buildTestApp(Widget child) {
    return TranslationProvider(
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates:
                const <LocalizationsDelegate<dynamic>>[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: child,
          );
        },
      ),
    );
  }

  group('ApCoursePage', () {
    testWidgets('should show loading state initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApCoursePage(
            onLoadSemesters: () async {
              // Never resolves during test
              await Future<void>.delayed(const Duration(seconds: 10));
              return _mockSemesterData();
            },
            onLoadCourse: (Semester semester) async {
              return CourseData.empty();
            },
          ),
        ),
      );

      // Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show course data after loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApCoursePage(
            onLoadSemesters: () async => _mockSemesterData(),
            onLoadCourse: (Semester semester) async => _mockCourseData(),
          ),
        ),
      );

      // Let futures complete
      await tester.pumpAndSettle();

      // Should show the CourseScaffold (which contains course table)
      expect(find.byType(CourseScaffold), findsOneWidget);
    });

    testWidgets('should show empty state when no courses',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApCoursePage(
            onLoadSemesters: () async => _mockSemesterData(),
            onLoadCourse: (Semester semester) async => CourseData.empty(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CourseScaffold), findsOneWidget);
    });

    testWidgets('should show error state on exception',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApCoursePage(
            onLoadSemesters: () async => throw Exception('Network error'),
            onLoadCourse: (Semester semester) async => CourseData.empty(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CourseScaffold), findsOneWidget);
    });
  });
}

SemesterData _mockSemesterData() {
  return SemesterData(
    data: <Semester>[
      const Semester(year: '112', value: '1', text: '112-1'),
      const Semester(year: '112', value: '2', text: '112-2'),
    ],
    defaultSemester: const Semester(year: '112', value: '1', text: '112-1'),
    currentIndex: 0,
  );
}

CourseData _mockCourseData() {
  return CourseData(
    courses: <Course>[
      Course(
        code: 'CS101',
        title: 'Test Course',
        className: 'A',
        group: '1',
        units: '3',
        hours: '3',
        required: 'Required',
        at: null,
        times: <SectionTime>[],
        instructors: <String>['Professor A'],
        location: Location(
          building: 'Building A',
          room: 'Room 101',
        ),
      ),
    ],
    timeCodes: <TimeCode>[],
  );
}
