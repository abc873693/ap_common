import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// A semester picker that opens a grouped bottom sheet.
///
/// Unlike [SemesterPicker], this widget does **not**
/// manage loading / empty states via
/// [SemesterPickerController].
/// It simply presents all semesters grouped by year and
/// returns the selected index.
///
/// The bottom-sheet UI is provided by
/// [OptionPickerBottomSheet].
///
/// Use [SemesterPickerBottomSheet.show] to open the
/// sheet programmatically without embedding the widget.
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

  /// Opens a semester picker bottom sheet and returns
  /// the selected index, or `null` if dismissed.
  static Future<int?> show({
    required BuildContext context,
    required SemesterData semesterData,
    int currentIndex = 0,
    SemesterUIConfig? uiConfig,
  }) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    return OptionPickerBottomSheet.showGrouped(
      context: context,
      title: context.ap.pickSemester,
      titleIcon: Icons.calendar_month_rounded,
      groups: _toGroups(
        semesterData,
        uiConfig,
        colorScheme,
        context.ap,
      ),
      selectedValue: currentIndex,
      defaultValue: semesterData.defaultIndex,
      defaultLabel: context.ap.currentSemester,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final Semester? current =
        semesterData.data.isNotEmpty &&
                currentIndex <
                    semesterData.data.length
            ? semesterData.data[currentIndex]
            : null;
    final String displayText = current != null
        ? _getShortText(
            current,
            uiConfig,
            context.ap,
          )
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
          if (selected != null &&
              onSelect != null) {
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
                color:
                    colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 6),
              Text(
                displayText,
                style: TextStyle(
                  color: colorScheme
                      .onPrimaryContainer,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                Icons.arrow_drop_down_rounded,
                size: 20,
                color:
                    colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Data conversion ────────────────────────────

  static List<PickerOptionGroup> _toGroups(
    SemesterData semesterData,
    SemesterUIConfig? uiConfig,
    ColorScheme colorScheme,
    ApLocalizations ap,
  ) {
    final List<MapEntry<int, Semester>> sorted =
        _getSortedSemesters(semesterData, uiConfig);

    final Map<String,
            List<MapEntry<int, Semester>>>
        byYear = <String,
            List<MapEntry<int, Semester>>>{};
    for (final MapEntry<int, Semester> e in sorted) {
      byYear
          .putIfAbsent(
            e.value.year,
            () => <MapEntry<int, Semester>>[],
          )
          .add(e);
    }

    return byYear.entries
        .map(
          (MapEntry<String,
                  List<MapEntry<int, Semester>>>
              entry) =>
              PickerOptionGroup(
            title: ap.schoolYearFormat(
              arg1: entry.key,
            ),
            options: entry.value
                .map(
                  (MapEntry<int, Semester> e) =>
                      _toPickerOption(
                    e.key,
                    e.value,
                    uiConfig,
                    colorScheme,
                    ap,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  static PickerOption _toPickerOption(
    int index,
    Semester semester,
    SemesterUIConfig? uiConfig,
    ColorScheme colorScheme,
    ApLocalizations ap,
  ) {
    final String name =
        uiConfig?.getName?.call(semester.value) ??
            _getSemesterName(semester.value, ap);
    return PickerOption(
      value: index,
      label:
          name.isNotEmpty ? name : semester.text,
      subtitle: semester.text,
      icon: uiConfig?.getIcon
              ?.call(semester.value) ??
          _getSemesterIcon(semester.value),
      iconBackgroundColor: uiConfig?.getColor
              ?.call(semester.value, colorScheme) ??
          _getSemesterColor(
            semester.value,
            colorScheme,
          ),
    );
  }

  // ── Semester helpers ───────────────────────────

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

  static List<MapEntry<int, Semester>>
      _getSortedSemesters(
    SemesterData semesterData,
    SemesterUIConfig? uiConfig,
  ) {
    final List<MapEntry<int, Semester>> indexed =
        <MapEntry<int, Semester>>[];
    for (int i = 0;
        i < semesterData.data.length;
        i++) {
      indexed.add(
        MapEntry<int, Semester>(
          i,
          semesterData.data[i],
        ),
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
