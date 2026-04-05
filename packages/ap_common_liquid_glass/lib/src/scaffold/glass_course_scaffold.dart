import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// A glass-enhanced version of [CourseScaffold].
///
/// Currently delegates to the original [CourseScaffold] while the
/// app tree is wrapped in [LiquidGlassWidgets.wrap] via
/// [LiquidGlassApApp]. The glass theme bridge ensures glass widgets
/// used within the scaffold pick up the correct tint colors.
///
/// Course scaffold has deeply integrated state management (course
/// table rendering, notification control, screenshot capture) that
/// makes partial widget replacement impractical. Instead, this
/// wrapper ensures the scaffold operates correctly within a
/// Liquid Glass context.
class GlassCourseScaffold extends StatelessWidget {
  const GlassCourseScaffold({
    super.key,
    required this.state,
    required this.courseData,
    this.title,
    this.customHint,
    this.semesterData,
    this.onSelect,
    this.onRefresh,
    this.actions,
    this.enableNotifyControl = true,
    this.notifyData,
    this.autoNotifySave = true,
    this.onNotifyClick,
    this.courseNotifySaveKey = ApConstants.semesterLatest,
    this.customStateHint,
    this.itemPicker,
    this.onSearchButtonClick,
    this.enableAddToCalendar = true,
    this.androidResourceIcon,
    this.enableCaptureCourseTable = false,
    this.showSectionTime,
    this.showInstructors,
    this.showClassroomLocation,
    this.showSearchButton,
  });

  /// Creates from a [DataState<CourseData>].
  GlassCourseScaffold.fromDataState({
    super.key,
    required DataState<CourseData> dataState,
    this.title,
    this.semesterData,
    this.onSelect,
    this.onRefresh,
    this.actions,
    this.enableNotifyControl = true,
    this.notifyData,
    this.autoNotifySave = true,
    this.onNotifyClick,
    this.courseNotifySaveKey = ApConstants.semesterLatest,
    this.itemPicker,
    this.onSearchButtonClick,
    this.enableAddToCalendar = true,
    this.androidResourceIcon,
    this.enableCaptureCourseTable = false,
    this.showSectionTime,
    this.showInstructors,
    this.showClassroomLocation,
    this.showSearchButton,
  })  : state = dataState.when(
          loading: () => CourseState.loading,
          loaded: (_, __) => CourseState.finish,
          error: (_) => CourseState.error,
          empty: (_) => CourseState.empty,
        ),
        courseData =
            dataState.dataOrNull ?? CourseData.empty(),
        customHint =
            dataState is DataLoaded<CourseData>
                ? dataState.hint
                : null,
        customStateHint =
            dataState is DataError<CourseData>
                ? dataState.hint
                : dataState is DataEmpty<CourseData>
                    ? dataState.hint
                    : null;

  final CourseState state;
  final CourseData courseData;
  final String? title;
  final String? customHint;
  final SemesterData? semesterData;
  final Function(int index)? onSelect;
  final Future<CourseData?>? Function()? onRefresh;
  final List<Widget>? actions;
  final bool enableNotifyControl;
  final CourseNotifyData? notifyData;
  final bool autoNotifySave;
  final CourseNotifyCallback? onNotifyClick;
  final String courseNotifySaveKey;
  final String? customStateHint;
  final Widget? itemPicker;
  final Function()? onSearchButtonClick;
  final bool enableAddToCalendar;
  final String? androidResourceIcon;
  final bool enableCaptureCourseTable;
  final bool? showSectionTime;
  final bool? showInstructors;
  final bool? showClassroomLocation;
  final bool? showSearchButton;

  @override
  Widget build(BuildContext context) {
    return CourseScaffold(
      state: state,
      courseData: courseData,
      title: title,
      customHint: customHint,
      semesterData: semesterData,
      onSelect: onSelect,
      onRefresh: onRefresh,
      actions: actions,
      enableNotifyControl: enableNotifyControl,
      notifyData: notifyData,
      autoNotifySave: autoNotifySave,
      onNotifyClick: onNotifyClick,
      courseNotifySaveKey: courseNotifySaveKey,
      customStateHint: customStateHint,
      itemPicker: itemPicker,
      onSearchButtonClick: onSearchButtonClick,
      enableAddToCalendar: enableAddToCalendar,
      androidResourceIcon: androidResourceIcon,
      enableCaptureCourseTable:
          enableCaptureCourseTable,
      showSectionTime: showSectionTime,
      showInstructors: showInstructors,
      showClassroomLocation: showClassroomLocation,
      showSearchButton: showSearchButton,
    );
  }
}
