import 'package:ap_common_announcement_ui/ap_common_announcement_ui.dart';
import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_helpers.dart';

void main() {
  setUpAll(() {
    injector.registerSingleton<PreferenceUtil>(
      () => MockPreferenceUtil(),
    );
    injector.registerSingleton<UiUtil>(() => MockUiUtil());
    injector.registerSingleton<AnalyticsUtil>(
      () => const MockAnalyticsUtil(),
    );
    injector.registerSingleton<MediaUtil>(
      () => MockMediaUtil(),
    );
  });

  Future<void> Function(
    Announcement data, {
    bool? isApproval,
    bool? addBlackList,
  }) noopSubmit() {
    return (
      Announcement data, {
      bool? isApproval,
      bool? addBlackList,
    }) async {};
  }

  group('AnnouncementEditForm', () {
    testWidgets('should render form fields for add mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Scaffold(
            body: AnnouncementEditForm(
              mode: Mode.add,
              onSubmit: noopSubmit(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsAtLeast(3));
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets(
        'should hide tag section in application mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Scaffold(
            body: AnnouncementEditForm(
              mode: Mode.application,
              onSubmit: noopSubmit(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ActionChip), findsNothing);
    });

    testWidgets(
        'should show application hint in application mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Scaffold(
            body: AnnouncementEditForm(
              mode: Mode.application,
              organizationDomain: 'test.edu',
              onSubmit: noopSubmit(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('should populate title in edit mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Scaffold(
            body: AnnouncementEditForm(
              mode: Mode.edit,
              announcement: _mockAnnouncement(),
              onSubmit: noopSubmit(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Test Announcement'), findsOneWidget);
    });

    testWidgets('should show tags in edit mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Scaffold(
            body: AnnouncementEditForm(
              mode: Mode.edit,
              announcement: _mockAnnouncement(),
              onSubmit: noopSubmit(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('nkust'), findsOneWidget);
      expect(find.text('zh'), findsOneWidget);
      expect(find.byType(ActionChip), findsOneWidget);
    });

    testWidgets(
        'should render in editApplication mode with tags',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          Scaffold(
            body: AnnouncementEditForm(
              mode: Mode.editApplication,
              announcement: _mockAnnouncement(),
              onSubmit: noopSubmit(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      // Title field should be populated
      expect(find.text('Test Announcement'), findsOneWidget);
      // Tags should be visible (editApplication shows tags)
      expect(find.text('nkust'), findsOneWidget);
    });
  });
}

Announcement _mockAnnouncement() => const Announcement(
      title: 'Test Announcement',
      weight: 5,
      imgUrl: '',
      description: 'Test description',
      applicant: 'user@test.com',
      applicationId: 'app123',
      tags: <String>['nkust', 'zh'],
    );
