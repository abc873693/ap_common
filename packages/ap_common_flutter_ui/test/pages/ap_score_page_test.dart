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

  group('ApScorePage', () {
    testWidgets('should show loading state initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApScorePage(
            onLoadSemesters: () async {
              await Future<void>.delayed(const Duration(seconds: 10));
              return _mockSemesterData();
            },
            onLoadScore: (Semester semester) async => _mockScoreData(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show score data after loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApScorePage(
            onLoadSemesters: () async => _mockSemesterData(),
            onLoadScore: (Semester semester) async => _mockScoreData(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ScoreScaffold), findsOneWidget);
    });

    testWidgets('should show empty state when score is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApScorePage(
            onLoadSemesters: () async => _mockSemesterData(),
            onLoadScore: (Semester semester) async => null,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ScoreScaffold), findsOneWidget);
    });

    testWidgets('should use detailBuilder when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApScorePage(
            onLoadSemesters: () async => _mockSemesterData(),
            onLoadScore: (Semester semester) async => _mockScoreData(),
            detailBuilder: (ScoreData? scoreData) => <String>[
              'Average: ${scoreData?.detail.average ?? ''}',
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ScoreScaffold), findsOneWidget);
    });

    testWidgets('should show error state on exception',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApScorePage(
            onLoadSemesters: () async => throw Exception('Network error'),
            onLoadScore: (Semester semester) async => null,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ScoreScaffold), findsOneWidget);
    });
  });
}

SemesterData _mockSemesterData() {
  return SemesterData(
    data: <Semester>[
      const Semester(year: '112', value: '1', text: '112-1'),
    ],
    defaultSemester: const Semester(year: '112', value: '1', text: '112-1'),
    currentIndex: 0,
  );
}

ScoreData _mockScoreData() {
  return ScoreData(
    scores: <Score>[
      Score(
        courseNumber: 'CS101',
        title: 'Test Course',
        units: '3.0',
        hours: null,
        required: null,
        at: null,
        middleScore: null,
        generalScore: null,
        finalScore: null,
        semesterScore: '90',
        remark: null,
      ),
    ],
    detail: Detail(
      average: 90.0,
      conduct: 85.0,
      classRank: '1/30',
      departmentRank: '5/100',
    ),
  );
}
