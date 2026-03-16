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

enum _ContentStyle { list, table }

const double _courseHeight = 64.0;

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

  ApLocalizations get app => ApLocalizations.of(context);

  _ContentStyle _contentStyle = _ContentStyle.table;

  bool? showSectionTime;
  bool? showInstructors;
  bool? showClassroomLocation;
  bool? showSearchButton;
  bool? mergeCourse;

  bool get isLandscape =>
      // MediaQuery.of(context).size.shortestSide >= 680 ||
      MediaQuery.of(context).orientation == Orientation.landscape;

  List<String> invisibleCourseCodes = <String>[];

  late Map<int, Map<int, Course>> _courseLookup;

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
    _buildCourseLookup();
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
    if (widget.courseData != oldWidget.courseData) {
      _buildCourseLookup();
    }
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
                  widget.title ?? app.course,
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
                tooltip: ApLocalizations.of(context).exportCourseTable,
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
              tooltip: ApLocalizations.of(context).courseScaffoldSetting,
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
                          (_contentStyle == _ContentStyle.table)
                              ? _ContentStyle.list
                              : _ContentStyle.table,
                    );
                  },
                  child: Icon(
                    _contentStyle == _ContentStyle.table
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
        return app.clickToRetry;
      case CourseState.empty:
        return app.courseEmpty;
      case CourseState.offlineEmpty:
        return app.noOfflineData;
      case CourseState.custom:
        return widget.customStateHint ?? app.unknownError;
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
              app.clickToRetry,
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
          app.clickToRetry,
          Icons.error_outline_rounded,
        );
      case CourseState.empty:
        return _buildErrorState(
          colorScheme,
          app.courseEmpty,
          Icons.event_busy_rounded,
        );
      case CourseState.offlineEmpty:
        return _buildErrorState(
          colorScheme,
          app.noOfflineData,
          Icons.cloud_off_rounded,
        );
      case CourseState.custom:
        return _buildErrorState(
          colorScheme,
          widget.customStateHint ?? app.unknownError,
          Icons.warning_amber_rounded,
        );
      default:
        if (isLandscape || _contentStyle == _ContentStyle.table) {
          final int weekdayCount = widget.courseData.hasHoliday ? 7 : 5;
          return SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 80.0,
            ),
            child: RepaintBoundary(
              key: _repaintBoundaryGlobalKey,
              child: ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: <Widget>[
                    _buildWeekdayHeader(colorScheme, weekdayCount),
                    _buildCourseGrid(
                        colorScheme, weekdayCount, widget.courseData.timeCodes),
                  ],
                ),
              ),
            ),
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
      UiUtil.instance.showToast(context, app.unknownError);
      return;
    }
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyyMMdd_hhmmss').format(now);
    if (byteData != null) {
      if (!mounted) return;
      await MediaUtil.instance.saveImage(
        context,
        byteData: byteData,
        fileName: 'course_table_$formattedDate',
        successMessage: ApLocalizations.of(context).exportCourseTableSuccess,
        onSuccess: (GeneralResponse r) => Toast.show(
          r.message,
          context,
        ),
        onError: (GeneralResponse e) => Toast.show(
          e.message,
          context,
        ),
      );
      AnalyticsUtil.instance.logEvent('export_course_table_image_success');
    } else {
      if (!mounted) return;
      UiUtil.instance.showToast(context, app.unknownError);
    }
  }

  Widget _buildWeekdayHeader(ColorScheme colorScheme, int weekdayCount) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withAlpha(77),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withAlpha(128),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          _buildTimeSlotHeader(colorScheme),
          for (int i = 0; i < weekdayCount; i++)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  ApLocalizations.of(context).weekdaysCourse[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotHeader(ColorScheme colorScheme) {
    return Container(
      width: 48,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildCourseGrid(
    ColorScheme colorScheme,
    int weekdayCount,
    List<TimeCode> timeCodes,
  ) {
    final int minIndex = widget.courseData.minTimeCodeIndex;
    final int maxIndex = widget.courseData.maxTimeCodeIndex;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTimeColumn(colorScheme, timeCodes, minIndex, maxIndex),
        for (int weekday = 1; weekday <= weekdayCount; weekday++)
          Expanded(
            child: _buildWeekdayColumn(
              colorScheme,
              weekday,
              weekdayCount,
              minIndex,
              maxIndex,
            ),
          ),
      ],
    );
  }

  Widget _buildTimeColumn(
    ColorScheme colorScheme,
    List<TimeCode> timeCodes,
    int minIndex,
    int maxIndex,
  ) {
    return Column(
      children: <Widget>[
        for (int i = minIndex; i <= maxIndex; i++)
          _buildTimeSlot(
            colorScheme,
            i < timeCodes.length ? timeCodes[i] : null,
            i,
            i == maxIndex,
          ),
      ],
    );
  }

  Widget _buildWeekdayColumn(
    ColorScheme colorScheme,
    int weekday,
    int weekdayCount,
    int minIndex,
    int maxIndex,
  ) {
    final List<Widget> children = <Widget>[];
    for (int i = minIndex; i <= maxIndex; i++) {
      final Course? course = _getCourseAt(weekday, i);
      final bool isInvisible =
          course != null && invisibleCourseCodes.contains(course.code);

      if (course == null || isInvisible) {
        children.add(
          _buildEmptyCell(
            colorScheme,
            weekday < weekdayCount,
            i == maxIndex,
          ),
        );
      } else {
        int span = 1;
        if (mergeCourse ?? true) {
          while (i + span <= maxIndex &&
              _getCourseAt(weekday, i + span) == course) {
            span++;
          }
        }
        children.add(
          _buildCourseCell(
            colorScheme,
            weekday,
            i,
            course,
            span,
            weekday < weekdayCount,
            i + span - 1 == maxIndex,
          ),
        );
        i += span - 1;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  Widget _buildTimeSlot(
    ColorScheme colorScheme,
    TimeCode? timeCode,
    int timeIndex,
    bool isLast,
  ) {
    return Container(
      width: 48,
      height: _courseHeight,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withAlpha(77),
        border: Border(
          right: BorderSide(
            color: colorScheme.outlineVariant.withAlpha(128),
          ),
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: colorScheme.outlineVariant.withAlpha(77),
                  width: 0.5,
                ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            timeCode?.title ?? '${timeIndex + 1}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          if (timeCode != null && (showSectionTime ?? true)) ...<Widget>[
            const SizedBox(height: 2),
            Text(
              timeCode.startTime,
              style: TextStyle(
                fontSize: 9,
                color: colorScheme.onSurfaceVariant.withAlpha(179),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyCell(
    ColorScheme colorScheme,
    bool showRightBorder,
    bool isLast,
  ) {
    return Container(
      height: _courseHeight,
      decoration: BoxDecoration(
        border: Border(
          right: showRightBorder
              ? BorderSide(
                  color: colorScheme.outlineVariant.withAlpha(51),
                  width: 0.5,
                )
              : BorderSide.none,
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: colorScheme.outlineVariant.withAlpha(77),
                  width: 0.5,
                ),
        ),
      ),
    );
  }

  Widget _buildCourseCell(
    ColorScheme colorScheme,
    int weekday,
    int timeIndex,
    Course course,
    int span,
    bool showRightBorder,
    bool isLast,
  ) {
    return Container(
      height: _courseHeight * span,
      decoration: BoxDecoration(
        border: Border(
          right: showRightBorder
              ? BorderSide(
                  color: colorScheme.outlineVariant.withAlpha(51),
                  width: 0.5,
                )
              : BorderSide.none,
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: colorScheme.outlineVariant.withAlpha(77),
                  width: 0.5,
                ),
        ),
      ),
      child: _buildCourseCard(colorScheme, weekday, timeIndex, course, span),
    );
  }

  void _buildCourseLookup() {
    _courseLookup = <int, Map<int, Course>>{};
    for (final Course course in widget.courseData.courses) {
      for (final SectionTime time in course.times) {
        _courseLookup
            .putIfAbsent(
              time.weekday,
              () => <int, Course>{},
            )[time.index] = course;
      }
    }
  }

  Course? _getCourseAt(int weekday, int timeIndex) {
    return _courseLookup[weekday]?[timeIndex];
  }

  Widget _buildCourseCard(
    ColorScheme colorScheme,
    int weekday,
    int timeIndex,
    Course course,
    int span,
  ) {
    final Color courseColor = _getCourseColor(course.code);
    final String locationInfo =
        (showClassroomLocation ?? true) && course.location != null
            ? course.location.toString()
            : '';
    final String instructorInfo =
        (showInstructors ?? true) ? course.getInstructors() : '';

    final Color onCourseColor =
        ThemeData.estimateBrightnessForColor(courseColor) == Brightness.dark
            ? Colors.white
            : Colors.black;

    final String displayInfo = <String>[
      if (instructorInfo.isNotEmpty) instructorInfo,
      if (locationInfo.isNotEmpty) locationInfo,
    ].join('\n');

    return GestureDetector(
      onTap: () {
        final TimeCode timeCode = timeIndex < widget.courseData.timeCodes.length
            ? widget.courseData.timeCodes[timeIndex]
            : TimeCode(title: '?', startTime: '?', endTime: '?');
        _onPressed(weekday, timeCode, course);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        decoration: BoxDecoration(
          color: courseColor.withAlpha(230),
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: courseColor.withAlpha(77),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              course.title,
              textAlign: TextAlign.center,
              maxLines: span > 1 ? 4 : 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: span > 1 ? 14 : 9.5,
                fontWeight: FontWeight.w600,
                color: onCourseColor,
                height: 1.1,
              ),
            ),
            if (displayInfo.isNotEmpty) ...<Widget>[
              SizedBox(height: span > 1 ? 4 : 2),
              Text(
                displayInfo,
                textAlign: TextAlign.center,
                maxLines: span > 1 ? 4 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: span > 1 ? 12 : 8.5,
                  color: onCourseColor.withAlpha(217),
                  height: 1.0,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _onPressed(int weekday, TimeCode timeCode, Course course) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Color(0x00000000),
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
      showDialog(
        context: context,
        builder: (_) => SimpleOptionDialog(
          title: app.pickSemester,
          items: widget.semesterData!.semesters,
          index: widget.semesterData!.currentIndex,
          onSelected: widget.onSelect,
        ),
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
    final ApLocalizations app = ApLocalizations.current;

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
                        tooltip: ApLocalizations.of(context).addToCalendar,
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
                                ApLocalizations.of(context).courseNotifyHint,
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
                                ApLocalizations.of(context).cancelNotifySuccess,
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
                  app.courseDialogProfessor,
                  widget.course.getInstructors(),
                  colorScheme,
                ),
                _buildDetailRow(
                  Icons.location_on_outlined,
                  app.courseDialogLocation,
                  widget.course.location?.toString() ?? '-',
                  colorScheme,
                ),
                _buildDetailRow(
                  Icons.school_outlined,
                  '學分數',
                  '${widget.course.units ?? "-"} ${app.units}',
                  colorScheme,
                ),
                _buildDetailRow(
                  Icons.schedule_outlined,
                  app.courseDialogTime,
                  '${widget.timeCode.startTime}-${widget.timeCode.endTime}',
                  colorScheme,
                ),
                if (widget.course.className != null &&
                    widget.course.className!.isNotEmpty)
                  _buildDetailRow(
                    Icons.class_outlined,
                    app.studentClass,
                    widget.course.className!,
                    colorScheme,
                  ),
                if (widget.course.hours != null &&
                    widget.course.hours!.isNotEmpty)
                  _buildDetailRow(
                    Icons.timer_outlined,
                    app.courseHours,
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
    final ApLocalizations app = ApLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
 
    return ListView.builder(
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
          bottom: 80.0, left: 16.0, right: 16.0, top: 16.0),
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
                backgroundColor: Color(0x00000000),
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
                              : app.unknown,
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
                          '${course.units ?? "-"} ${app.units}',
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
    final ApLocalizations ap = ApLocalizations.current;
    return DefaultDialog(
      title: ap.courseScaffoldSetting,
      actionText: ApLocalizations.current.confirm,
      actionFunction: () => Navigator.of(context, rootNavigator: true).pop(),
      contentPadding: EdgeInsets.zero,
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CheckboxListTile(
            title: Text(ap.showSectionTime),
            secondary: Icon(ApIcon.accessTime),
            value: showSectionTime,
            onChanged: (bool? value) {
              setState(() => showSectionTime = value);
              widget.showSectionTimeOnChanged?.call(value);
            },
          ),
          CheckboxListTile(
            title: Text(ap.showInstructors),
            secondary: Icon(ApIcon.person),
            value: showInstructors,
            onChanged: (bool? value) {
              setState(() => showInstructors = value);
              widget.showInstructorsOnChanged?.call(value);
            },
          ),
          CheckboxListTile(
            title: Text(ap.showClassroomLocation),
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
