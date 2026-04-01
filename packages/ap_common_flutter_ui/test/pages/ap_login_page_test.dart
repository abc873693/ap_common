import 'package:ap_common_core/ap_common_core.dart';
import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  late MockPreferenceUtil mockPrefs;

  setUpAll(() {
    mockPrefs = MockPreferenceUtil();
    injector.registerSingleton<PreferenceUtil>(() => mockPrefs);
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

  group('ApLoginPage', () {
    testWidgets('should render login form', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<bool>(
                    builder: (_) => ApLoginPage(
                      logoSource: 'Test',
                      onLogin: (String u, String p) async => true,
                    ),
                  ),
                );
              },
              child: const Text('Open Login'),
            ),
          ),
        ),
      );

      // Navigate to login page
      await tester.tap(find.text('Open Login'));
      await tester.pumpAndSettle();

      // Should find text fields and login button
      expect(find.byType(ApTextField), findsNWidgets(2));
      expect(find.byType(ApButton), findsOneWidget);
    });

    testWidgets('should render with text logo mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApLoginPage(
            logoMode: LogoMode.text,
            logoSource: 'AP',
            onLogin: (String u, String p) async => true,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(LoginScaffold), findsOneWidget);
    });

    testWidgets('should show offline login button when enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApLoginPage(
            logoSource: 'AP',
            onLogin: (String u, String p) async => true,
            enableOfflineLogin: true,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should find the offline login flat button
      expect(find.byType(ApFlatButton), findsOneWidget);
    });

    testWidgets('should show checkboxes for auto-login and remember password',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          ApLoginPage(
            logoSource: 'AP',
            onLogin: (String u, String p) async => true,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(TextCheckBox), findsNWidgets(2));
    });

    testWidgets('should load saved username from preferences',
        (WidgetTester tester) async {
      await mockPrefs.setString('pref_username', 'saved_user');

      await tester.pumpWidget(
        buildTestApp(
          ApLoginPage(
            logoSource: 'AP',
            onLogin: (String u, String p) async => true,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // The saved username should appear in the text field
      expect(find.text('saved_user'), findsOneWidget);
    });
  });
}
