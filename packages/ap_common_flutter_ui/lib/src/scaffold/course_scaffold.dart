import 'dart:io';
import 'dart:ui' as ui;

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef CourseNotifyCallback = Function(
  CourseNotify? courseNotify,
  CourseNotifyState state,
);

enum CourseState { loading, finish, error, empty, offlineEmpty, custom }

enum CourseNotifyState { schedule, cancel }

const String _kCourseInvisibleKey =
    '${ApConstants.packageName}.course_invisible_';

const List<Color> courseColors = <Color>[
  Color(0xFF5C6BC0), // Indigo
  Color(0xFF26A69A), // Teal
  Color(0xFFEF5350), // Red
  Color(0xFFAB47BC), // Purple
  Color(0xFF42A5F5), // Blue
  Color(0xFFFF7043), // Deep Orange
  Color(0xFF66BB6A), // Green
  Color(0xFFFFCA28), // Amber
  Color(0xFF8D6E63), // Brown
  Color(0xFF78909C), // Blue Grey
  Color(0xFFEC407A), // Pink
  Color(0xFF7E57C2), // Deep Purple
];

class CourseConfig extends InheritedWidget {
  const CourseConfig({
    this.showSectionTime,
    this.showInstructors,
    this.showClassroomLocation,
    required super.child,
  });

  final bool? showSectionTime;
  final bool? showInstructors;
  final bool? showClassroomLocation;

  static CourseConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  @override
  bool updateShouldNotify(CourseConfig oldWidget) {
    return true;
  }
}

class CourseScaffold extends StatefulWidget {
  const CourseScaffold({
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

  /// Creates a [CourseScaffold] from a [DataState<CourseData>].
  ///
  /// This constructor simplifies usage by automatically mapping the
  /// [DataState] to the appropriate [CourseState] and extracting hints.
  ///
  /// ```dart
  /// CourseScaffold.fromDataState(
  ///   dataState: DataLoaded(courseData),
  ///   semesterData: semesterData,
  ///   onSelect: (index) => loadCourse(index),
  /// )
  /// ```
  CourseScaffold.fromDataState({
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
        courseData = dataState.dataOrNull ?? CourseData.empty(),
        customHint = dataState is DataLoaded<CourseData>
            ? dataState.hint
            : null,
        customStateHint = dataState is DataError<CourseData>
            ? dataState.hint
            : dataState is DataEmpty<CourseData>
                ? dataState.hint
                : null;

  /// 必要欄位，總共有
  /// `loading` `finish` `error` `empty` `offlineEmpty` `custom` 的狀態，
  /// 只有`finish`才會顯示課表介面，其餘都是顯示錯誤狀況
  final CourseState state;
  final String? customStateHint;
  final CourseData courseData;
  final String? title;
  final Widget? itemPicker;
  final SemesterData? semesterData;
  final Function(int index)? onSelect;
  final Function()? onSearchButtonClick;
  final Function()? onRefresh;
  final List<Widget>? actions;
  final String? customHint;
  final bool enableNotifyControl;
  final CourseNotifyData? notifyData;
  final bool autoNotifySave;
  final CourseNotifyCallback? onNotifyClick;
  final String courseNotifySaveKey;
  final bool enableAddToCalendar;
  final String? androidResourceIcon;
  final bool enableCaptureCourseTable;
  final bool? showSectionTime;
  final bool? showInstructors;
  final bool? showClassroomLocation;
  final bool? showSearchButton;

  @override
  CourseScaffoldState createState() => CourseScaffoldState();
}

class CourseScaffoldState extends State<CourseScaffold> {
  final GlobalKey _repaintBoundaryGlobalKey = GlobalKey();

  ContentStyle _contentStyle = ContentStyle.table;

  bool? showSectionTime;
  bool? showInstructors;
  bool? showClassroomLocation;
  bool? showSearchButton;
  bool? mergeCourse;

  bool get isLandscape =>
      // MediaQuery.of(context).size.shortestSide >= 680 ||
      MediaQuery.of(context).orientation == Orientation.landscape;

  List<String> invisibleCourseCodes = <String>[];

  final Map<String, Color> _courseColorMap = <String, Color>{};
  int _colorIndex = 0;

  Color _getCourseColor(String courseCode) {
    if (!_courseColorMap.containsKey(courseCode)) {
      _courseColorMap[courseCode] =
          courseColors[_colorIndex % courseColors.length];
      _colorIndex++;
    }
    return _courseColorMap[courseCode]!;
  }

  late ScrollController _scrollController;
  bool _showFab = true;

  @override
  void initState() {
    showSectionTime = widget.showSectionTime ??
        PreferenceUtil.instance.getBool(ApConstants.showSectionTime, true);
    showInstructors = widget.showInstructors ??
        PreferenceUtil.instance.getBool(ApConstants.showInstructors, true);
    showClassroomLocation = widget.showClassroomLocation ??
        PreferenceUtil.instance
            .getBool(ApConstants.showClassroomLocation, true);
    showSearchButton = widget.showSearchButton ??
        PreferenceUtil.instance
            .getBool(ApConstants.showCourseSearchButton, true);
    mergeCourse = PreferenceUtil.instance.getBool(
      '${ApConstants.packageName}.merge_course',
      true,
    );
    fetchInvisibleCourseCodes();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_showFab) {
          setState(() => _showFab = false);
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_showFab) {
          setState(() => _showFab = true);
        }
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CourseScaffold oldWidget) {
    fetchInvisibleCourseCodes();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CourseConfig(
      showSectionTime: showSectionTime,
      showInstructors: showInstructors,
      showClassroomLocation: showClassroomLocation,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  widget.title ?? context.ap.course,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.itemPicker != null) ...<Widget>[
                const SizedBox(width: 8),
                widget.itemPicker!,
              ],
              if (widget.semesterData != null &&
                  widget.itemPicker == null) ...<Widget>[
                const SizedBox(width: 8),
                SemesterPicker(
                  semesterData: widget.semesterData!,
                  currentIndex: widget.semesterData!.currentIndex,
                  onSelect: (Semester semester, int index) {
                    widget.onSelect?.call(index);
                  },
                  featureTag: 'course',
                ),
              ],
            ],
          ),
          actions: <Widget>[
            ...widget.actions ?? <Widget>[],
            if (widget.enableCaptureCourseTable)
              IconButton(
                icon: Icon(ApIcon.download),
                onPressed: _captureCourseTable,
                tooltip: context.ap.exportCourseTable,
              ),
            IconButton(
              icon: Icon(ApIcon.settings),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => CourseScaffoldSettingDialog(
                    showSectionTime: showSectionTime,
                    showInstructors: showInstructors,
                    showClassroomLocation: showClassroomLocation,
                    showSearchButton: showSearchButton,
                    mergeCourse: mergeCourse,
                    showSectionTimeOnChanged: (bool? value) {
                      setState(() => showSectionTime = value);
                      PreferenceUtil.instance.setBool(
                        ApConstants.showSectionTime,
                        showSectionTime!,
                      );
                    },
                    showInstructorsOnChanged: (bool? value) {
                      setState(() => showInstructors = value);
                      PreferenceUtil.instance.setBool(
                        ApConstants.showInstructors,
                        showInstructors!,
                      );
                    },
                    showClassroomLocationOnChanged: (bool? value) {
                      setState(() => showClassroomLocation = value);
                      PreferenceUtil.instance.setBool(
                        ApConstants.showClassroomLocation,
                        showClassroomLocation!,
                      );
                    },
                    showSearchButtonOnChanged: (bool? value) {
                      setState(() => showSearchButton = value);
                      PreferenceUtil.instance.setBool(
                        ApConstants.showCourseSearchButton,
                        showSearchButton!,
                      );
                    },
                    mergeCourseOnChanged: (bool? value) {
                      setState(() => mergeCourse = value);
                      PreferenceUtil.instance.setBool(
                        '${ApConstants.packageName}.merge_course',
                        mergeCourse!,
                      );
                    },
                  ),
                );
                AnalyticsUtil.instance.logEvent('course_setting_click');
              },
              tooltip: context.ap.courseScaffoldSetting,
            ),
          ],
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (widget.customHint != null &&
                      widget.customHint!.isNotEmpty)
                    _buildHintBanner(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await widget.onRefresh!();
                        AnalyticsUtil.instance.logEvent('course_refresh');
                        return;
                      },
                      child: _body(),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.state == CourseState.finish && isLandscape) ...<Widget>[
              const SizedBox(width: 16.0),
              Expanded(
                flex: 2,
                child: Material(
                  elevation: 12.0,
                  child: ColoredBox(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: CourseList(
                      courses: widget.courseData.courses,
                      timeCodes: widget.courseData.timeCodes,
                      invisibleCourseCodes: invisibleCourseCodes,
                      onVisibilityChanged: (
                        Course course,
                        bool visibility,
                      ) =>
                          saveInvisibleCourseCodes(
                        course: course,
                        visibility: visibility,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        floatingActionButton: AnimatedScale(
          scale: _showFab ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (!isLandscape)
                FloatingActionButton(
                  key: const ValueKey<String>('switch_content_style_button'),
                  heroTag: 'switch_content_style_button',
                  onPressed: () {
                    setState(
                      () => _contentStyle =
                          (_contentStyle == ContentStyle.table)
                              ? ContentStyle.list
                              : ContentStyle.table,
                    );
                  },
                  child: Icon(
                    _contentStyle == ContentStyle.table
                        ? Icons.list_rounded
                        : Icons.grid_view_rounded,
                  ),
                ),
              if (showSearchButton ?? true) ...<Widget>[
                if (!isLandscape) const SizedBox(height: 8),
                FloatingActionButton(
                  key: const ValueKey<String>('search_button'),
                  heroTag: 'search_button',
                  onPressed: () {
                    _pickSemester();
                    AnalyticsUtil.instance
                        .logEvent('course_search_button_click');
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String get hintContent {
    switch (widget.state) {
      case CourseState.error:
        return context.ap.clickToRetry;
      case CourseState.empty:
        return context.ap.courseEmpty;
      case CourseState.offlineEmpty:
        return context.ap.noOfflineData;
      case CourseState.custom:
        return widget.customStateHint ?? context.ap.unknownError;
      default:
        return '';
    }
  }

  Widget _buildErrorState(
    ColorScheme colorScheme,
    String message,
    IconData icon,
  ) {
    return InkWell(
      onTap: () {
        if (widget.state == CourseState.empty) {
          _pickSemester();
        } else {
          widget.onRefresh?.call();
        }
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withAlpha(77),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 40, color: colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.ap.clickToRetry,
              style: TextStyle(fontSize: 14, color: colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHintBanner() {
    return HintBanner(text: widget.customHint!);
  }

  Widget _body() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    switch (widget.state) {
      case CourseState.loading:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        );
      case CourseState.error:
        return _buildErrorState(
          colorScheme,
          context.ap.clickToRetry,
          Icons.error_outline_rounded,
        );
      case CourseState.empty:
        return _buildErrorState(
          colorScheme,
          context.ap.courseEmpty,
          Icons.event_busy_rounded,
        );
      case CourseState.offlineEmpty:
        return _buildErrorState(
          colorScheme,
          context.ap.noOfflineData,
          Icons.cloud_off_rounded,
        );
      case CourseState.custom:
        return _buildErrorState(
          colorScheme,
          widget.customStateHint ?? context.ap.unknownError,
          Icons.warning_amber_rounded,
        );
      default:
        if (isLandscape || _contentStyle == ContentStyle.table) {
          return CourseTableView(
            courseData: widget.courseData,
            invisibleCourseCodes: invisibleCourseCodes,
            controller: _scrollController,
            onCoursePressed: (
              Course course,
              TimeCode timeCode,
              int weekday,
            ) =>
                _onPressed(weekday, timeCode, course),
            courseColorResolver: _getCourseColor,
            repaintBoundaryKey: _repaintBoundaryGlobalKey,
            mergeCourse: mergeCourse,
            showSectionTime: showSectionTime,
            showInstructors: showInstructors,
            showClassroomLocation: showClassroomLocation,
          );
        } else {
          return CourseList(
            controller: _scrollController,
            courses: widget.courseData.courses,
            timeCodes: widget.courseData.timeCodes,
            invisibleCourseCodes: invisibleCourseCodes,
            onVisibilityChanged: (
              Course course,
              bool visibility,
            ) =>
                saveInvisibleCourseCodes(
              course: course,
              visibility: visibility,
            ),
          );
        }
    }
  }

  Future<void> _captureCourseTable() async {
    final RenderRepaintBoundary? boundary =
        _repaintBoundaryGlobalKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary?;
    if (boundary == null) {
      UiUtil.instance.showToast(context, context.ap.unknownError);
      return;
    }
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyyMMdd_hhmmss').format(now);
    if (byteData != null) {
      final SaveImageResult result = await MediaUtil.instance.saveImage(
        byteData: byteData,
        fileName: 'course_table_$formattedDate',
      );
      if (!mounted) return;
      switch (result) {
        case SaveImageSuccess(:final String filePath):
          final String message =
              '${context.ap.exportCourseTableSuccess}\n$filePath';
          Toast.show(message, context);
          AnalyticsUtil.instance
              .logEvent('export_course_table_image_success');
        case SaveImageError(:final String message):
          UiUtil.instance.showToast(context, message);
      }
    } else {
      if (!mounted) return;
      UiUtil.instance.showToast(context, context.ap.unknownError);
    }
  }

  void _onPressed(int weekday, TimeCode timeCode, Course course) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0x00000000),
      isScrollControlled: true,
      builder: (BuildContext builder) {
        return CourseContent(
          enableNotifyControl: widget.enableNotifyControl,
          course: course,
          notifyData: widget.notifyData,
          weekday: weekday,
          courseNotifySaveKey: widget.courseNotifySaveKey,
          timeCode: timeCode,
          courseColor: _getCourseColor(course.code),
          invisibleCourseCodes: invisibleCourseCodes,
          onVisibilityChanged: (bool visibility) => saveInvisibleCourseCodes(
            course: course,
            visibility: visibility,
          ),
        );
      },
    );
  }

  void _pickSemester() {
    if (widget.semesterData != null) {
      SemesterPicker.show(
        context: context,
        semesterData: widget.semesterData!,
        currentIndex: widget.semesterData!.currentIndex,
        onSelect: (Semester semester, int index) {
          widget.onSelect?.call(index);
        },
      );
    }
    widget.onSearchButtonClick?.call();
  }

  void saveInvisibleCourseCodes({
    required Course course,
    required bool visibility,
  }) {
    if (visibility) {
      invisibleCourseCodes.remove(course.code);
    } else {
      invisibleCourseCodes.add(course.code);
    }
    PreferenceUtil.instance.setStringList(
      '$_kCourseInvisibleKey${widget.courseNotifySaveKey}',
      invisibleCourseCodes,
    );
    setState(() {});
  }

  void fetchInvisibleCourseCodes() {
    invisibleCourseCodes = PreferenceUtil.instance.getStringList(
      '$_kCourseInvisibleKey${widget.courseNotifySaveKey}',
      <String>[],
    );
    setState(() {});
  }
}

class CourseContent extends StatefulWidget {
  const CourseContent({
    super.key,
    required this.enableNotifyControl,
    required this.course,
    required this.timeCode,
    required this.weekday,
    this.notifyData,
    this.autoNotifySave = true,
    this.onNotifyClick,
    this.courseNotifySaveKey = ApConstants.semesterLatest,
    this.enableAddToCalendar = true,
    this.androidResourceIcon,
    this.invisibleCourseCodes = const <String>[],
    this.onVisibilityChanged,
    this.courseColor,
  });

  final bool enableNotifyControl;
  final Course course;
  final TimeCode timeCode;
  final int weekday;
  final CourseNotifyData? notifyData;
  final bool autoNotifySave;
  final CourseNotifyCallback? onNotifyClick;
  final String courseNotifySaveKey;
  final bool enableAddToCalendar;
  final String? androidResourceIcon;
  final List<String> invisibleCourseCodes;
  final ValueChanged<bool>? onVisibilityChanged;
  final Color? courseColor;

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  CourseNotifyData? _notifyData;

  @override
  void initState() {
    _notifyData = widget.notifyData;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CourseContent oldWidget) {
    if (widget.notifyData != oldWidget.notifyData) {
      _notifyData = widget.notifyData;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    CourseNotifyState? state;
    if (widget.enableNotifyControl && widget.notifyData != null) {
      state = widget.notifyData!.getByCode(
                widget.course.code,
                widget.timeCode.startTime,
                widget.weekday,
              ) ==
              null
          ? CourseNotifyState.cancel
          : CourseNotifyState.schedule;
    }
    final bool visibility =
        !widget.invisibleCourseCodes.contains(widget.course.code);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color courseColor = widget.courseColor ??
        courseColors[widget.course.code.hashCode % courseColors.length];
    final Color onCourseColor =
        ThemeData.estimateBrightnessForColor(courseColor) == Brightness.dark
            ? Colors.white
            : Colors.black;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20, right: 8, top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: courseColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS)) &&
                        widget.enableAddToCalendar)
                      IconButton(
                        tooltip: context.ap.addToCalendar,
                        icon: Image.asset(
                          ApImageIcons.calendarImport,
                          color: onCourseColor,
                          height: 24.0,
                          width: 24.0,
                        ),
                        onPressed: () {
                          final DateFormat format = DateFormat('HH:mm');
                          final DateTime startTime =
                              format.parse(widget.timeCode.startTime);
                          final DateTime endTime =
                              format.parse(widget.timeCode.endTime);
                          PlatformCalendarUtil.instance.addToApp(
                            title: widget.course.title,
                            location: widget.course.location?.toString() ?? '',
                            startDate: startTime.weekTime(widget.weekday),
                            endDate: endTime.weekTime(widget.weekday),
                            timeZone: 'GMT+8',
                          );
                          AnalyticsUtil.instance
                              .logEvent('course_export_to_calendar');
                        },
                      ),
                    IconButton(
                      icon: Icon(
                        visibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: onCourseColor,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.onVisibilityChanged?.call(!visibility);
                        });
                      },
                    ),
                    if (widget.enableNotifyControl &&
                        _notifyData != null &&
                        NotificationUtil.instance.isSupport)
                      IconButton(
                        icon: Icon(
                          state == CourseNotifyState.schedule
                              ? Icons.alarm_on
                              : Icons.alarm_off,
                          color: onCourseColor,
                        ),
                        onPressed: () async {
                          CourseNotify? courseNotify = _notifyData!.getByCode(
                            widget.course.code,
                            widget.timeCode.startTime,
                            widget.weekday,
                          );
                          if (widget.autoNotifySave) {
                            if (courseNotify == null) {
                              courseNotify = CourseNotify.fromCourse(
                                id: _notifyData!.lastId + 1,
                                course: widget.course,
                                weekday: widget.weekday,
                                timeCode: widget.timeCode,
                              );
                              await NotificationUtil.instance
                                  .scheduleCourseNotify(
                                context: context,
                                courseNotify: courseNotify,
                                weekday: widget.weekday,
                                androidResourceIcon: widget.androidResourceIcon,
                              );
                              _notifyData = _notifyData!.copyWith(
                                lastId: _notifyData!.lastId + 1,
                                data: <CourseNotify>[
                                  ..._notifyData!.data,
                                  courseNotify,
                                ],
                              );
                              _notifyData!.save(widget.courseNotifySaveKey);
                              if (!context.mounted) return;
                              UiUtil.instance.showToast(
                                context,
                                context.ap.courseNotifyHint,
                              );
                              AnalyticsUtil.instance
                                  .logEvent('course_notify_schedule');
                            } else {
                              await NotificationUtil.instance.cancelNotify(
                                id: courseNotify.id,
                              );
                              final List<CourseNotify> newData = <CourseNotify>[
                                ..._notifyData!.data,
                              ];
                              newData.removeWhere((CourseNotify data) {
                                return data.id == courseNotify!.id;
                              });
                              _notifyData = _notifyData!.copyWith(
                                data: newData,
                              );
                              _notifyData!.save(widget.courseNotifySaveKey);
                              if (!context.mounted) return;
                              UiUtil.instance.showToast(
                                context,
                                context.ap.cancelNotifySuccess,
                              );
                            }
                            setState(() {});
                            AnalyticsUtil.instance
                                .logEvent('course_notify_cancel');
                          }
                          if (widget.onNotifyClick != null) {
                            if (!mounted) return;
                            widget.onNotifyClick?.call(
                              courseNotify,
                              CourseNotifyState.values[(state!.index + 1) %
                                  (CourseNotifyState.values.length)],
                            );
                          }
                        },
                      ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.course.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: onCourseColor,
                        ),
                      ),
                    ),
                    if (widget.course.required != null &&
                        widget.course.required!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: onCourseColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.course.required!,
                          style: TextStyle(
                            fontSize: 12,
                            color: onCourseColor,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.course.code,
                  style: TextStyle(
                    fontSize: 14,
                    color: onCourseColor.withAlpha(204),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                _buildDetailRow(
                  Icons.person_outline_rounded,
                  context.ap.courseDialogProfessor,
                  widget.course.getInstructors(),
                  colorScheme,
                ),
                _buildDetailRow(
                  Icons.location_on_outlined,
                  context.ap.courseDialogLocation,
                  widget.course.location?.toString() ?? '-',
                  colorScheme,
                ),
                _buildDetailRow(
                  Icons.school_outlined,
                  '學分數',
                  '${widget.course.units ?? "-"} ${context.ap.units}',
                  colorScheme,
                ),
                _buildDetailRow(
                  Icons.schedule_outlined,
                  context.ap.courseDialogTime,
                  '${widget.timeCode.startTime}-${widget.timeCode.endTime}',
                  colorScheme,
                ),
                if (widget.course.className != null &&
                    widget.course.className!.isNotEmpty)
                  _buildDetailRow(
                    Icons.class_outlined,
                    context.ap.studentClass,
                    widget.course.className!,
                    colorScheme,
                  ),
                if (widget.course.hours != null &&
                    widget.course.hours!.isNotEmpty)
                  _buildDetailRow(
                    Icons.timer_outlined,
                    context.ap.courseHours,
                    widget.course.hours!,
                    colorScheme,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    ColorScheme colorScheme,
  ) {
    if (value.isEmpty || value == '-') return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withAlpha(128),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                SelectableText(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
    required this.courses,
    this.invisibleCourseCodes = const <String>[],
    this.onVisibilityChanged,
    this.timeCodes,
    this.controller,
  });

  final List<Course> courses;
  final List<String> invisibleCourseCodes;
  final void Function(Course, bool)? onVisibilityChanged;
  final List<TimeCode>? timeCodes;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
          bottom: 80.0, left: 16.0, right: 16.0, top: 16.0,),
      itemCount: courses.length,
      itemBuilder: (_, int index) {
        final Course course = courses[index];
        final bool visibility = !invisibleCourseCodes.contains(course.code);
        final Color courseColor = courseColors[index % courseColors.length];
        final String instructors = course.getInstructors();

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outlineVariant.withAlpha(77),
            ),
          ),
          child: InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: const Color(0x00000000),
                isScrollControlled: true,
                builder: (BuildContext context) => CourseContent(
                  course: course,
                  invisibleCourseCodes: invisibleCourseCodes,
                  onVisibilityChanged: (bool visible) =>
                      onVisibilityChanged?.call(course, visible),
                  timeCode: timeCodes != null && timeCodes!.isNotEmpty
                      ? timeCodes![0]
                      : const TimeCode(
                          title: '',
                          startTime: '',
                          endTime: '',
                        ),
                  weekday:
                      course.times.isNotEmpty ? course.times.first.weekday : 1,
                  courseColor: courseColor,
                  enableNotifyControl: false,
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 4,
                    height: 60,
                    decoration: BoxDecoration(
                      color: courseColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          course.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          instructors.isNotEmpty
                              ? instructors
                              : context.ap.unknown,
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          course.location?.toString() ?? '-',
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          visibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        onPressed: () =>
                            onVisibilityChanged?.call(course, !visibility),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: courseColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${course.units ?? "-"} ${context.ap.units}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: courseColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CourseScaffoldSettingDialog extends StatefulWidget {
  const CourseScaffoldSettingDialog({
    super.key,
    required this.showSectionTime,
    required this.showInstructors,
    required this.showClassroomLocation,
    required this.showSearchButton,
    required this.mergeCourse,
    this.showSectionTimeOnChanged,
    this.showInstructorsOnChanged,
    this.showClassroomLocationOnChanged,
    this.showSearchButtonOnChanged,
    this.mergeCourseOnChanged,
  });

  final bool? showSectionTime;
  final bool? showInstructors;
  final bool? showClassroomLocation;
  final bool? showSearchButton;
  final bool? mergeCourse;
  final Function(bool?)? showSectionTimeOnChanged;
  final Function(bool?)? showInstructorsOnChanged;
  final Function(bool?)? showClassroomLocationOnChanged;
  final Function(bool?)? showSearchButtonOnChanged;
  final Function(bool?)? mergeCourseOnChanged;

  @override
  _CourseScaffoldSettingDialogState createState() =>
      _CourseScaffoldSettingDialogState();
}

class _CourseScaffoldSettingDialogState
    extends State<CourseScaffoldSettingDialog> {
  bool? showSectionTime;
  bool? showInstructors;
  bool? showClassroomLocation;
  bool? showSearchButton;
  bool? mergeCourse;

  @override
  void initState() {
    showSectionTime = widget.showSectionTime;
    showInstructors = widget.showInstructors;
    showClassroomLocation = widget.showClassroomLocation;
    showSearchButton = widget.showSearchButton;
    mergeCourse = widget.mergeCourse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultDialog(
      title: context.ap.courseScaffoldSetting,
      actionText: context.ap.confirm,
      actionFunction: () => Navigator.of(context, rootNavigator: true).pop(),
      contentPadding: EdgeInsets.zero,
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CheckboxListTile(
            title: Text(context.ap.showSectionTime),
            secondary: Icon(ApIcon.accessTime),
            value: showSectionTime,
            onChanged: (bool? value) {
              setState(() => showSectionTime = value);
              widget.showSectionTimeOnChanged?.call(value);
            },
          ),
          CheckboxListTile(
            title: Text(context.ap.showInstructors),
            secondary: Icon(ApIcon.person),
            value: showInstructors,
            onChanged: (bool? value) {
              setState(() => showInstructors = value);
              widget.showInstructorsOnChanged?.call(value);
            },
          ),
          CheckboxListTile(
            title: Text(context.ap.showClassroomLocation),
            secondary: Icon(ApIcon.locationOn),
            value: showClassroomLocation,
            onChanged: (bool? value) {
              setState(() => showClassroomLocation = value);
              widget.showClassroomLocationOnChanged?.call(value);
            },
          ),
          CheckboxListTile(
            title: const Text('連在一起'),
            secondary: const Icon(Icons.merge_type_rounded),
            value: mergeCourse,
            onChanged: (bool? value) {
              setState(() => mergeCourse = value);
              widget.mergeCourseOnChanged?.call(value);
            },
          ),
        ],
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime weekTime(int weekday) {
    final DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    ).add(
      Duration(
        days: weekday - now.weekday,
      ),
    );
  }
}
