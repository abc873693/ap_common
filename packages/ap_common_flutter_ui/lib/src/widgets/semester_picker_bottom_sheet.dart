import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A pure semester picker that opens a bottom sheet.
///
/// Unlike [SemesterPicker], this widget does **not** manage
/// loading / empty states via [SemesterPickerController].
/// It simply presents all semesters and returns the
/// selected index.
///
/// Use [SemesterPickerBottomSheet.show] to open the sheet
/// programmatically without embedding the widget.
class SemesterPickerBottomSheet extends StatelessWidget {
  const SemesterPickerBottomSheet({
    super.key,
    required this.semesterData,
    this.onSelect,
    this.featureTag,
    this.currentIndex = 0,
    this.uiConfig,
  });

  final SemesterData semesterData;
  final SemesterCallback? onSelect;
  final String? featureTag;
  final int currentIndex;
  final SemesterUIConfig? uiConfig;

  /// Opens a semester picker bottom sheet and returns the
  /// selected index, or `null` if dismissed.
  static Future<int?> show({
    required BuildContext context,
    required SemesterData semesterData,
    int currentIndex = 0,
    SemesterUIConfig? uiConfig,
  }) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final Map<String, List<MapEntry<int, Semester>>>
        groupedByYear = _groupByYear(
      _getSortedSemesters(semesterData, uiConfig),
    );

    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: const Color(0x00000000),
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (
            BuildContext context,
            ScrollController scrollController,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: <Widget>[
                  _buildHandle(colorScheme),
                  _buildTitle(context, colorScheme),
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant
                        .withAlpha(128),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: groupedByYear.length,
                      itemBuilder: (
                        BuildContext context,
                        int groupIndex,
                      ) {
                        final String year =
                            groupedByYear.keys
                                .elementAt(groupIndex);
                        return _buildYearGroup(
                          context: context,
                          year: year,
                          semesters:
                              groupedByYear[year]!,
                          colorScheme: colorScheme,
                          currentIndex: currentIndex,
                          semesterData: semesterData,
                          uiConfig: uiConfig,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final Semester? current =
        semesterData.data.isNotEmpty &&
                currentIndex < semesterData.data.length
            ? semesterData.data[currentIndex]
            : null;
    final String displayText = current != null
        ? _getShortText(current, uiConfig, context.ap)
        : '';

    return Material(
      color: colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () async {
          if (featureTag != null) {
            AnalyticsUtil.instance.logEvent(
              '${featureTag}_semester_picker_click',
            );
          }
          final int? selected = await show(
            context: context,
            semesterData: semesterData,
            currentIndex: currentIndex,
            uiConfig: uiConfig,
          );
          if (selected != null && onSelect != null) {
            onSelect!(
              semesterData.data[selected],
              selected,
            );
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.calendar_month_rounded,
                size: 16,
                color: colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 6),
              Text(
                displayText,
                style: TextStyle(
                  color: colorScheme.onPrimaryContainer,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                Icons.arrow_drop_down_rounded,
                size: 20,
                color: colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Bottom-sheet sub-widgets ───────────────────────

  static Widget _buildHandle(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  static Widget _buildTitle(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.calendar_month_rounded,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
            context.ap.pickSemester,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildYearGroup({
    required BuildContext context,
    required String year,
    required List<MapEntry<int, Semester>> semesters,
    required ColorScheme colorScheme,
    required int currentIndex,
    required SemesterData semesterData,
    SemesterUIConfig? uiConfig,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child: Text(
                  context.ap.schoolYearFormat(
                    arg1: year,
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colorScheme
                        .onPrimaryContainer,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        ...semesters.map(
          (MapEntry<int, Semester> e) =>
              _buildSemesterItem(
            context: context,
            originalIndex: e.key,
            semester: e.value,
            colorScheme: colorScheme,
            currentIndex: currentIndex,
            semesterData: semesterData,
            uiConfig: uiConfig,
          ),
        ),
      ],
    );
  }

  static Widget _buildSemesterItem({
    required BuildContext context,
    required int originalIndex,
    required Semester semester,
    required ColorScheme colorScheme,
    required int currentIndex,
    required SemesterData semesterData,
    SemesterUIConfig? uiConfig,
  }) {
    final bool isSelected = originalIndex == currentIndex;
    final bool isDefault =
        originalIndex == semesterData.defaultIndex;
    final String name =
        uiConfig?.getName?.call(semester.value) ??
            _getSemesterName(semester.value, context.ap);
    final String displayName =
        name.isNotEmpty ? name : semester.text;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outlineVariant.withAlpha(77),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.of(context).pop(originalIndex);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: <Widget>[
              _buildIcon(
                semester: semester,
                colorScheme: colorScheme,
                isSelected: isSelected,
                uiConfig: uiConfig,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLabel(
                  context: context,
                  displayName: displayName,
                  semester: semester,
                  colorScheme: colorScheme,
                  isSelected: isSelected,
                  isDefault: isDefault,
                ),
              ),
              Icon(
                isSelected
                    ? Icons.check_circle_rounded
                    : Icons.circle_outlined,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildIcon({
    required Semester semester,
    required ColorScheme colorScheme,
    required bool isSelected,
    SemesterUIConfig? uiConfig,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary
            : (uiConfig?.getColor?.call(
                    semester.value,
                    colorScheme,
                  ) ??
                _getSemesterColor(
                  semester.value,
                  colorScheme,
                )),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          uiConfig?.getIcon?.call(semester.value) ??
              _getSemesterIcon(semester.value),
          size: 22,
          color: isSelected
              ? colorScheme.onPrimary
              : colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  static Widget _buildLabel({
    required BuildContext context,
    required String displayName,
    required Semester semester,
    required ColorScheme colorScheme,
    required bool isSelected,
    required bool isDefault,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child: Text(
                displayName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isDefault) ...<Widget>[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary,
                  borderRadius:
                      BorderRadius.circular(4),
                ),
                child: Text(
                  context.ap.currentSemester,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onTertiary,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(
          semester.text,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // ── Semester helpers ────────────────────────────────

  static Map<String, List<MapEntry<int, Semester>>>
      _groupByYear(
    List<MapEntry<int, Semester>> sorted,
  ) {
    final Map<String, List<MapEntry<int, Semester>>>
        result =
        <String, List<MapEntry<int, Semester>>>{};
    for (final MapEntry<int, Semester> entry in sorted) {
      result
          .putIfAbsent(
            entry.value.year,
            () => <MapEntry<int, Semester>>[],
          )
          .add(entry);
    }
    return result;
  }

  static List<MapEntry<int, Semester>>
      _getSortedSemesters(
    SemesterData semesterData,
    SemesterUIConfig? uiConfig,
  ) {
    final List<MapEntry<int, Semester>> indexed =
        <MapEntry<int, Semester>>[];
    for (int i = 0; i < semesterData.data.length; i++) {
      indexed.add(
        MapEntry<int, Semester>(i, semesterData.data[i]),
      );
    }
    indexed.sort(
      (
        MapEntry<int, Semester> a,
        MapEntry<int, Semester> b,
      ) {
        final int yearA =
            int.tryParse(a.value.year) ?? 0;
        final int yearB =
            int.tryParse(b.value.year) ?? 0;
        if (yearA != yearB) {
          return yearB.compareTo(yearA);
        }
        final int semA = uiConfig?.getSortValue
                ?.call(a.value.value) ??
            _getSemesterSortValue(a.value.value);
        final int semB = uiConfig?.getSortValue
                ?.call(b.value.value) ??
            _getSemesterSortValue(b.value.value);
        return semA.compareTo(semB);
      },
    );
    return indexed;
  }

  static String _getShortText(
    Semester semester,
    SemesterUIConfig? uiConfig, [
    ApLocalizations? ap,
  ]) {
    final String name =
        uiConfig?.getName?.call(semester.value) ??
            _getSemesterName(semester.value, ap);
    if (name.isNotEmpty) {
      return '${semester.year} $name';
    }
    return semester.text;
  }

  static int _getSemesterSortValue(String value) {
    switch (value) {
      case '4':
        return 1;
      case '6':
        return 2;
      case '7':
        return 3;
      case '2':
        return 4;
      case '3':
        return 5;
      case '1':
        return 6;
      case '5':
        return 7;
      default:
        return 99;
    }
  }

  static String _getSemesterName(
    String value, [
    ApLocalizations? ap,
  ]) {
    switch (value) {
      case '1':
        return ap?.firstSemester ?? '上學期';
      case '2':
        return ap?.secondSemester ?? '下學期';
      case '3':
        return ap?.winterSession ?? '寒修';
      case '4':
        return ap?.summerSession ?? '暑修';
      case '5':
        return ap?.preCourse ?? '先修';
      case '6':
        return ap?.summerSessionFirst ?? '暑修(一)';
      case '7':
        return ap?.summerSessionSpecial ?? '暑修(特)';
      default:
        return '';
    }
  }

  static IconData _getSemesterIcon(String value) {
    switch (value) {
      case '1':
        return Icons.looks_one_rounded;
      case '2':
        return Icons.looks_two_rounded;
      case '3':
        return Icons.ac_unit_rounded;
      case '4':
      case '6':
      case '7':
        return Icons.wb_sunny_rounded;
      case '5':
        return Icons.auto_awesome_rounded;
      default:
        return Icons.calendar_today_rounded;
    }
  }

  static Color _getSemesterColor(
    String value,
    ColorScheme colorScheme,
  ) {
    switch (value) {
      case '1':
        return colorScheme.primaryContainer
            .withAlpha(179);
      case '2':
        return colorScheme.secondaryContainer
            .withAlpha(179);
      case '3':
        return colorScheme.errorContainer
            .withAlpha(128);
      case '5':
        return colorScheme.primaryContainer
            .withAlpha(102);
      case '4':
      case '6':
      case '7':
        return colorScheme.tertiaryContainer
            .withAlpha(179);
      default:
        return colorScheme.surfaceContainerHighest;
    }
  }
}
