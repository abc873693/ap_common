import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass-enhanced version of [SemesterPicker].
///
/// Replaces Material widgets with Liquid Glass equivalents while
/// maintaining the same API surface. The inline chip button uses
/// [GlassCard] and [Icons], and the bottom sheet uses
/// [GlassSheet] with glass-styled semester items.
class GlassSemesterPicker extends StatefulWidget {
  const GlassSemesterPicker({
    super.key,
    required this.semesterData,
    this.onSelect,
    this.featureTag,
    this.currentIndex = 0,
    this.uiConfig,
    this.controller,
  });

  final SemesterData semesterData;
  final SemesterCallback? onSelect;
  final String? featureTag;
  final int currentIndex;
  final SemesterUIConfig? uiConfig;
  final SemesterPickerController? controller;

  @override
  GlassSemesterPickerState createState() =>
      GlassSemesterPickerState();

  /// Shows a glass-styled semester picker bottom sheet.
  static void show({
    required BuildContext context,
    required SemesterData semesterData,
    int currentIndex = 0,
    SemesterCallback? onSelect,
    String? featureTag,
    Set<String>? loadingSemesters,
    Set<String>? emptySemesters,
    SemesterUIConfig? uiConfig,
    SemesterPickerController? controller,
  }) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final List<MapEntry<int, Semester>> sortedSemesters =
        _getSortedSemesters(semesterData, uiConfig);

    final Map<String, List<MapEntry<int, Semester>>>
        groupedByYear =
        <String, List<MapEntry<int, Semester>>>{};
    for (final MapEntry<int, Semester> entry
        in sortedSemesters) {
      final String year = entry.value.year;
      groupedByYear.putIfAbsent(
        year,
        () => <MapEntry<int, Semester>>[],
      );
      groupedByYear[year]!.add(entry);
    }

    // Prefer controller's sets; fall back to explicit
    // parameters.
    final Set<String>? effectiveLoading =
        controller?.loadingSemesters ?? loadingSemesters;
    final Set<String>? effectiveEmpty =
        controller?.emptySemesters ?? emptySemesters;

    VoidCallback? onControllerChanged;
    GlassSheet.show<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        if (controller != null) {
          controller.attachSheetNavigator(
            Navigator.of(sheetContext),
          );
        }
        return StatefulBuilder(
          builder: (
            BuildContext context,
            StateSetter setSheetState,
          ) {
            if (onControllerChanged == null &&
                controller != null) {
              onControllerChanged =
                  () => setSheetState(() {});
              controller
                  .addListener(onControllerChanged!);
            }
            return SizedBox(
              height: MediaQuery.of(context)
                      .size
                      .height *
                  0.6,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_month_rounded,
                          color:
                              colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          context.ap.pickSemester,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                            color: colorScheme
                                .onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const GlassDivider(),
                  Expanded(
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount:
                          groupedByYear.length,
                      itemBuilder: (
                        BuildContext context,
                        int groupIndex,
                      ) {
                        final String year =
                            groupedByYear.keys
                                .elementAt(
                          groupIndex,
                        );
                        final List<
                                MapEntry<int,
                                    Semester>>
                            semesters =
                            groupedByYear[year]!;

                        return _buildYearGroup(
                          context: context,
                          year: year,
                          semesters: semesters,
                          colorScheme:
                              colorScheme,
                          currentIndex:
                              currentIndex,
                          semesterData:
                              semesterData,
                          onSelect: onSelect,
                          loadingSemesters:
                              effectiveLoading,
                          emptySemesters:
                              effectiveEmpty,
                          setSheetState:
                              setSheetState,
                          uiConfig: uiConfig,
                          controller: controller,
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
    ).whenComplete(() {
      if (onControllerChanged != null) {
        controller
            ?.removeListener(onControllerChanged!);
      }
      controller?.detachSheetNavigator();
    });
  }

  static Widget _buildYearGroup({
    required BuildContext context,
    required String year,
    required List<MapEntry<int, Semester>> semesters,
    required ColorScheme colorScheme,
    required int currentIndex,
    required SemesterData semesterData,
    SemesterCallback? onSelect,
    Set<String>? loadingSemesters,
    Set<String>? emptySemesters,
    required StateSetter setSheetState,
    SemesterUIConfig? uiConfig,
    SemesterPickerController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Row(
            children: <Widget>[
              GlassCard(
                useOwnLayer: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                shape:
                    const LiquidRoundedSuperellipse(
                  borderRadius: 8,
                ),
                child: Text(
                  context.ap
                      .schoolYearFormat(arg1: year),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:
                        colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        ...semesters.map(
          (MapEntry<int, Semester> entry) =>
              _buildSemesterItem(
            context: context,
            originalIndex: entry.key,
            semester: entry.value,
            colorScheme: colorScheme,
            currentIndex: currentIndex,
            semesterData: semesterData,
            onSelect: onSelect,
            loadingSemesters: loadingSemesters,
            emptySemesters: emptySemesters,
            setSheetState: setSheetState,
            uiConfig: uiConfig,
            controller: controller,
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
    SemesterCallback? onSelect,
    Set<String>? loadingSemesters,
    Set<String>? emptySemesters,
    required StateSetter setSheetState,
    SemesterUIConfig? uiConfig,
    SemesterPickerController? controller,
  }) {
    final bool isSelected =
        originalIndex == currentIndex;
    final bool isDefault =
        originalIndex == semesterData.defaultIndex;
    final bool isEmpty =
        emptySemesters?.contains(semester.code) ??
            false;
    final bool isLoading =
        loadingSemesters?.contains(semester.code) ??
            false;
    final bool isDisabled = isEmpty || isLoading;
    final String semesterName =
        uiConfig?.getName?.call(semester.value) ??
            _getSemesterName(
              semester.value,
              context.ap,
            );
    final String displayName = semesterName.isNotEmpty
        ? semesterName
        : semester.text;

    return Opacity(
      opacity: isEmpty ? 0.5 : 1.0,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 4),
        child: GlassCard(
          useOwnLayer: true,
          padding: EdgeInsets.zero,
          child: GestureDetector(
            onTap: isDisabled
                ? null
                : () {
                    if (onSelect != null) {
                      if (controller != null) {
                        controller
                            .markSemesterLoading(
                          semester,
                        );
                        onSelect(
                          semester,
                          originalIndex,
                        );
                      } else if (loadingSemesters !=
                          null) {
                        loadingSemesters
                            .add(semester.code);
                        setSheetState(() {});
                        onSelect(
                          semester,
                          originalIndex,
                        );
                      } else {
                        Navigator.of(context).pop();
                        onSelect(
                          semester,
                          originalIndex,
                        );
                      }
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isEmpty
                          ? colorScheme.outlineVariant
                              .withAlpha(77)
                          : isLoading
                              ? colorScheme.primary
                                  .withAlpha(77)
                              : isSelected
                                  ? colorScheme
                                      .primary
                                  : (uiConfig
                                          ?.getColor
                                          ?.call(
                                        semester
                                            .value,
                                        colorScheme,
                                      ) ??
                                      _getSemesterColor(
                                        semester
                                            .value,
                                        colorScheme,
                                      )),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child:
                                  GlassProgressIndicator
                                      .circular(),
                            )
                          : Icon(
                              isEmpty
                                  ? Icons
                                      .block_rounded
                                  : (uiConfig?.getIcon
                                          ?.call(
                                        semester
                                            .value,
                                      ) ??
                                      _getSemesterIcon(
                                        semester
                                            .value,
                                      )),
                              size: 22,
                              color: isEmpty
                                  ? colorScheme
                                      .onSurfaceVariant
                                  : isSelected
                                      ? colorScheme
                                          .onPrimary
                                      : colorScheme
                                          .onPrimaryContainer,
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                displayName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w600,
                                  color: isEmpty
                                      ? colorScheme
                                          .onSurfaceVariant
                                      : isLoading
                                          ? colorScheme
                                              .primary
                                          : isSelected
                                              ? colorScheme
                                                  .primary
                                              : colorScheme
                                                  .onSurface,
                                ),
                                overflow: TextOverflow
                                    .ellipsis,
                              ),
                            ),
                            if (isLoading) ...<Widget>[
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color: colorScheme
                                      .primary
                                      .withAlpha(26),
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    4,
                                  ),
                                ),
                                child: Text(
                                  context.ap
                                      .semesterLoading,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight
                                            .w500,
                                    color:
                                        colorScheme
                                            .primary,
                                  ),
                                ),
                              ),
                            ] else if (
                                isEmpty) ...<Widget>[
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color: colorScheme
                                      .outlineVariant
                                      .withAlpha(77),
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    4,
                                  ),
                                ),
                                child: Text(
                                  context.ap
                                      .semesterNoData,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight
                                            .w500,
                                    color: colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ] else if (
                                isDefault) ...<Widget>[
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color: colorScheme
                                      .tertiary,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    4,
                                  ),
                                ),
                                child: Text(
                                  context.ap
                                      .currentSemester,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                    color: colorScheme
                                        .onTertiary,
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
                            color: colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: GlassProgressIndicator
                          .circular(),
                    )
                  else if (isEmpty)
                    Icon(
                      Icons.lock_outline_rounded,
                      color:
                          colorScheme.outlineVariant,
                      size: 20,
                    )
                  else if (isSelected)
                    Icon(
                      Icons
                          .check_circle_rounded,
                      color: colorScheme.primary,
                    )
                  else
                    Icon(
                      Icons.circle_outlined,
                      color:
                          colorScheme.outlineVariant,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // Duplicated helpers (private in SemesterPickerState)
  // ----------------------------------------------------------

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
        return Icons.looks_one_rounded;
      case '3':
        return Icons.ac_unit_rounded;
      case '4':
      case '6':
      case '7':
        return Icons.brightness_6;
      case '5':
        return Icons.auto_awesome_rounded;
      default:
        return Icons.calendar_month_rounded;
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

  static String _getShortSemesterText(
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
}

/// State for [GlassSemesterPicker].
class GlassSemesterPickerState
    extends State<GlassSemesterPicker> {
  late SemesterData semesterData;
  Semester? selectSemester;
  late int currentIndex;

  final Set<String> _emptySemesters = <String>{};
  final Set<String> _loadingSemesters = <String>{};
  BuildContext? _sheetContext;
  StateSetter? _sheetSetState;

  @override
  void initState() {
    semesterData = widget.semesterData;
    currentIndex = widget.currentIndex;
    if (semesterData.data.isNotEmpty &&
        currentIndex < semesterData.data.length) {
      selectSemester =
          semesterData.data[currentIndex];
    }
    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant GlassSemesterPicker oldWidget,
  ) {
    if (oldWidget.semesterData !=
            widget.semesterData ||
        oldWidget.currentIndex !=
            widget.currentIndex) {
      semesterData = widget.semesterData;
      currentIndex = widget.currentIndex;
      if (semesterData.data.isNotEmpty &&
          currentIndex < semesterData.data.length) {
        selectSemester =
            semesterData.data[currentIndex];
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final String displayText = selectSemester != null
        ? GlassSemesterPicker._getShortSemesterText(
            selectSemester!,
            widget.uiConfig,
            context.ap,
          )
        : '';

    return GestureDetector(
      onTap: () {
        if (selectSemester != null) pickSemester();
        if (widget.featureTag != null) {
          AnalyticsUtil.instance.logEvent(
            '${widget.featureTag}_item_picker_click',
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.calendar_month_rounded,
            size: 16,
            color: colorScheme.onSurface,
          ),
          const SizedBox(width: 6),
          Text(
            displayText,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.arrow_drop_down,
            size: 14,
            color: colorScheme.onSurface,
          ),
        ],
      ),
    );
  }

  /// Mark a semester as empty (no data).
  void markSemesterEmpty(Semester semester) {
    _loadingSemesters.remove(semester.code);
    _emptySemesters.add(semester.code);
    _sheetSetState?.call(() {});
    if (mounted) setState(() {});
  }

  /// Mark a semester as having data. Auto-closes
  /// the bottom sheet.
  void markSemesterHasData(Semester semester) {
    _loadingSemesters.remove(semester.code);
    _emptySemesters.remove(semester.code);
    if (_sheetContext != null &&
        Navigator.of(_sheetContext!).canPop()) {
      Navigator.of(_sheetContext!).pop();
      _sheetContext = null;
      _sheetSetState = null;
    }
    if (mounted) setState(() {});
  }

  /// Mark a semester as loading.
  void markSemesterLoading(Semester semester) {
    _loadingSemesters.add(semester.code);
    _sheetSetState?.call(() {});
    if (mounted) setState(() {});
  }

  /// Whether the given semester is marked empty.
  bool isSemesterEmpty(Semester semester) {
    return _emptySemesters.contains(semester.code);
  }

  /// Whether the given semester is currently loading.
  bool isSemesterLoading(Semester semester) {
    return _loadingSemesters.contains(semester.code);
  }

  /// Opens the semester picker bottom sheet.
  void pickSemester() {
    final SemesterPickerController? ctrl =
        widget.controller;
    GlassSemesterPicker.show(
      context: context,
      semesterData: semesterData,
      currentIndex: currentIndex,
      onSelect: (Semester semester, int index) {
        HapticFeedback.selectionClick();
        if (ctrl != null) {
          ctrl.markSemesterLoading(semester);
        } else {
          markSemesterLoading(semester);
        }
        currentIndex = index;
        selectSemester =
            semesterData.data[currentIndex];
        widget.onSelect?.call(
          semesterData.data[currentIndex],
          currentIndex,
        );
        if (mounted) setState(() {});
      },
      featureTag: widget.featureTag,
      loadingSemesters:
          ctrl != null ? null : _loadingSemesters,
      emptySemesters:
          ctrl != null ? null : _emptySemesters,
      uiConfig: widget.uiConfig,
      controller: ctrl,
    );
  }
}
