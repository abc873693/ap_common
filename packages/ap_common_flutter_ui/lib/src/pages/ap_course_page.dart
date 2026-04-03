import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// A ready-to-use course page that handles semester loading and
/// state management internally using [DataState].
///
/// Instead of managing [CourseState], [SemesterData], [CourseData] manually,
/// just provide data-fetching callbacks:
///
/// ```dart
/// ApCoursePage(
///   onLoadSemesters: () => api.getSemesters(),
///   onLoadCourse: (semester) => api.getCourseData(semester),
/// )
/// ```
class ApCoursePage extends StatefulWidget {
  const ApCoursePage({
    super.key,
    required this.onLoadSemesters,
    required this.onLoadCourse,
    this.title,
    this.enableNotifyControl = true,
    this.enableAddToCalendar = true,
    this.enableCaptureCourseTable = false,
    this.androidResourceIcon,
    this.actions,
    this.showSectionTime,
    this.showInstructors,
    this.showClassroomLocation,
    this.courseNotifySaveKey,
  });

  /// Load the semester list. Called once on init.
  final Future<SemesterData> Function() onLoadSemesters;

  /// Load course data for the given [Semester].
  final Future<CourseData> Function(Semester semester) onLoadCourse;

  final String? title;
  final bool enableNotifyControl;
  final bool enableAddToCalendar;
  final bool enableCaptureCourseTable;
  final String? androidResourceIcon;
  final List<Widget>? actions;
  final bool? showSectionTime;
  final bool? showInstructors;
  final bool? showClassroomLocation;
  final String? courseNotifySaveKey;

  @override
  State<ApCoursePage> createState() => _ApCoursePageState();
}

class _ApCoursePageState extends State<ApCoursePage> {
  DataState<CourseData> _state = const DataLoading<CourseData>();
  SemesterData? _semesterData;
  CourseNotifyData? _notifyData;

  String get _notifyCacheKey =>
      widget.courseNotifySaveKey ??
      PreferenceUtil.instance.getString(
        ApConstants.currentSemesterCode,
        ApConstants.semesterLatest,
      );

  @override
  void initState() {
    super.initState();
    _loadSemesters();
  }

  Future<void> _loadSemesters() async {
    try {
      _semesterData = await widget.onLoadSemesters();
      _loadCourse();
    } catch (_) {
      if (mounted) {
        setState(() => _state = const DataError<CourseData>());
      }
    }
  }

  Future<void> _loadCourse() async {
    if (_semesterData == null) return;
    setState(() => _state = const DataLoading<CourseData>());
    try {
      final Semester semester =
          _semesterData!.data[_semesterData!.currentIndex];
      final CourseData courseData = await widget.onLoadCourse(semester);
      if (mounted) {
        setState(() {
          if (courseData.courses.isEmpty) {
            _state = const DataEmpty<CourseData>();
          } else {
            _state = DataLoaded<CourseData>(courseData);
            _notifyData = CourseNotifyData.load(_notifyCacheKey);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _state = DataError<CourseData>(hint: e.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CourseScaffold(
      state: _state.when(
        loading: () => CourseState.loading,
        loaded: (_, __) => CourseState.finish,
        error: (_) => CourseState.error,
        empty: (_) => CourseState.empty,
      ),
      courseData: _state.dataOrNull ?? CourseData.empty(),
      notifyData: _notifyData,
      title: widget.title,
      customHint: _state is DataLoaded<CourseData>
          ? (_state as DataLoaded<CourseData>).hint
          : null,
      customStateHint: _state is DataError<CourseData>
          ? (_state as DataError<CourseData>).hint
          : null,
      courseNotifySaveKey: _notifyCacheKey,
      semesterData: _semesterData,
      enableNotifyControl: widget.enableNotifyControl,
      enableAddToCalendar: widget.enableAddToCalendar,
      enableCaptureCourseTable: widget.enableCaptureCourseTable,
      androidResourceIcon: widget.androidResourceIcon,
      actions: widget.actions,
      showSectionTime: widget.showSectionTime,
      showInstructors: widget.showInstructors,
      showClassroomLocation: widget.showClassroomLocation,
      onSelect: (int index) {
        _semesterData = _semesterData!.copyWith(currentIndex: index);
        _loadCourse();
      },
      onRefresh: () async {
        await _loadCourse();
        return null;
      },
    );
  }
}
