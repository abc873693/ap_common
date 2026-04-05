import 'dart:ui' as ui;

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_course_content.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_course_list.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_course_table_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

const String _kCourseInvisibleKey =
    '${ApConstants.packageName}.course_invisible_';

/// A glass-enhanced version of [CourseScaffold].
///
/// Replaces the Material [AppBar] with [GlassAppBar] and the
/// [FloatingActionButton]s with [GlassButton] widgets while
/// reusing the body content widgets ([CourseTableView],
/// [CourseList], etc.) from the original scaffold.
class GlassCourseScaffold extends StatefulWidget {
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
  GlassCourseScaffoldState createState() =>
      GlassCourseScaffoldState();
}

class GlassCourseScaffoldState
    extends State<GlassCourseScaffold> {
  final GlobalKey _repaintBoundaryGlobalKey = GlobalKey();

  ContentStyle _contentStyle = ContentStyle.table;

  bool? showSectionTime;
  bool? showInstructors;
  bool? showClassroomLocation;
  bool? showSearchButton;
  bool? mergeCourse;

  bool get isLandscape =>
      MediaQuery.of(context).orientation ==
      Orientation.landscape;

  List<String> invisibleCourseCodes = <String>[];

  final Map<String, Color> _courseColorMap =
      <String, Color>{};
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
        PreferenceUtil.instance.getBool(
          ApConstants.showSectionTime,
          true,
        );
    showInstructors = widget.showInstructors ??
        PreferenceUtil.instance.getBool(
          ApConstants.showInstructors,
          true,
        );
    showClassroomLocation =
        widget.showClassroomLocation ??
            PreferenceUtil.instance.getBool(
              ApConstants.showClassroomLocation,
              true,
            );
    showSearchButton = widget.showSearchButton ??
        PreferenceUtil.instance.getBool(
          ApConstants.showCourseSearchButton,
          true,
        );
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
      } else if (_scrollController
              .position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_showFab) {
          setState(() => _showFab = true);
        }
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant GlassCourseScaffold oldWidget,
  ) {
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
    return AdaptiveLiquidGlassLayer(
      child: CourseConfig(
      showSectionTime: showSectionTime,
      showInstructors: showInstructors,
      showClassroomLocation: showClassroomLocation,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(
          title: Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  widget.title ?? context.ap.course,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.itemPicker !=
                  null) ...<Widget>[
                const SizedBox(width: 8),
                widget.itemPicker!,
              ],
              if (widget.semesterData != null &&
                  widget.itemPicker ==
                      null) ...<Widget>[
                const SizedBox(width: 8),
                SemesterPicker(
                  semesterData:
                      widget.semesterData!,
                  currentIndex: widget
                      .semesterData!.currentIndex,
                  onSelect: (
                    Semester semester,
                    int index,
                  ) {
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
                tooltip:
                    context.ap.exportCourseTable,
              ),
            IconButton(
              icon: Icon(ApIcon.settings),
              onPressed: _openSettings,
              tooltip:
                  context.ap.courseScaffoldSetting,
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
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (widget.customHint != null &&
                      widget.customHint!.isNotEmpty)
                    HintBanner(
                      text: widget.customHint!,
                    ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await widget.onRefresh!();
                        AnalyticsUtil.instance
                            .logEvent(
                          'course_refresh',
                        );
                        return;
                      },
                      child: _body(),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.state ==
                    CourseState.finish &&
                isLandscape) ...<Widget>[
              const SizedBox(width: 16.0),
              Expanded(
                flex: 2,
                child: GlassCard(
                  useOwnLayer: true,
                  padding: EdgeInsets.zero,
                  child: GlassCourseList(
                    courses:
                        widget.courseData.courses,
                    timeCodes:
                        widget.courseData.timeCodes,
                    invisibleCourseCodes:
                        invisibleCourseCodes,
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
            ],
          ],
        ),
        floatingActionButton: AnimatedScale(
          scale: _showFab ? 1.0 : 0.0,
          duration:
              const Duration(milliseconds: 250),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: <Widget>[
              if (!isLandscape)
                GlassButton(
                  key: const ValueKey<String>(
                    'switch_content_style_button',
                  ),
                  icon: Icon(
                    _contentStyle ==
                            ContentStyle.table
                        ? Icons.list_rounded
                        : Icons.grid_view_rounded,
                  ),
                  onTap: () {
                    setState(
                      () => _contentStyle =
                          (_contentStyle ==
                                  ContentStyle.table)
                              ? ContentStyle.list
                              : ContentStyle.table,
                    );
                  },
                  useOwnLayer: true,
                ),
              if (showSearchButton ??
                  true) ...<Widget>[
                if (!isLandscape)
                  const SizedBox(height: 8),
                GlassButton(
                  key: const ValueKey<String>(
                    'search_button',
                  ),
                  icon: const Icon(Icons.search),
                  onTap: () {
                    _pickSemester();
                    AnalyticsUtil.instance.logEvent(
                      'course_search_button_click',
                    );
                  },
                  useOwnLayer: true,
                ),
              ],
            ],
          ),
        ),
      ),
      ),
    );
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
            GlassCard(
              useOwnLayer: true,
              width: 80,
              height: 80,
              padding: EdgeInsets.zero,
              shape:
                  const LiquidRoundedSuperellipse(
                borderRadius: 20,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 40,
                  color: colorScheme.primary,
                ),
              ),
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
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
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
          widget.customStateHint ??
              context.ap.unknownError,
          Icons.warning_amber_rounded,
        );
      default:
        if (isLandscape ||
            _contentStyle == ContentStyle.table) {
          return GlassCourseTableView(
            courseData: widget.courseData,
            invisibleCourseCodes:
                invisibleCourseCodes,
            controller: _scrollController,
            onCoursePressed: (
              Course course,
              TimeCode timeCode,
              int weekday,
            ) =>
                _onPressed(weekday, timeCode, course),
            courseColorResolver: _getCourseColor,
            repaintBoundaryKey:
                _repaintBoundaryGlobalKey,
            mergeCourse: mergeCourse,
            showSectionTime: showSectionTime,
            showInstructors: showInstructors,
            showClassroomLocation:
                showClassroomLocation,
          );
        } else {
          return GlassCourseList(
            controller: _scrollController,
            courses: widget.courseData.courses,
            timeCodes: widget.courseData.timeCodes,
            invisibleCourseCodes:
                invisibleCourseCodes,
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
        _repaintBoundaryGlobalKey.currentContext!
                .findRenderObject()
            as RenderRepaintBoundary?;
    if (boundary == null) {
      UiUtil.instance.showToast(
        context,
        context.ap.unknownError,
      );
      return;
    }
    final ui.Image image =
        await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final DateTime now = DateTime.now();
    final String formattedDate =
        DateFormat('yyyyMMdd_hhmmss').format(now);
    if (byteData != null) {
      final SaveImageResult result =
          await MediaUtil.instance.saveImage(
        byteData: byteData,
        fileName: 'course_table_$formattedDate',
      );
      if (!mounted) return;
      switch (result) {
        case SaveImageSuccess(:final String filePath):
          final String message =
              '${context.ap.exportCourseTableSuccess}'
              '\n$filePath';
          Toast.show(message, context);
          AnalyticsUtil.instance.logEvent(
            'export_course_table_image_success',
          );
        case SaveImageError(:final String message):
          UiUtil.instance.showToast(context, message);
      }
    } else {
      if (!mounted) return;
      UiUtil.instance.showToast(
        context,
        context.ap.unknownError,
      );
    }
  }

  void _onPressed(
    int weekday,
    TimeCode timeCode,
    Course course,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0x00000000),
      isScrollControlled: true,
      builder: (BuildContext builder) {
        return GlassCourseContent(
          enableNotifyControl:
              widget.enableNotifyControl,
          course: course,
          notifyData: widget.notifyData,
          weekday: weekday,
          courseNotifySaveKey:
              widget.courseNotifySaveKey,
          timeCode: timeCode,
          courseColor: _getCourseColor(course.code),
          invisibleCourseCodes: invisibleCourseCodes,
          onVisibilityChanged: (bool visibility) =>
              saveInvisibleCourseCodes(
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
        currentIndex:
            widget.semesterData!.currentIndex,
        onSelect: (Semester semester, int index) {
          widget.onSelect?.call(index);
        },
      );
    }
    widget.onSearchButtonClick?.call();
  }

  void _openSettings() {
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
        showClassroomLocationOnChanged:
            (bool? value) {
          setState(
            () => showClassroomLocation = value,
          );
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
    AnalyticsUtil.instance
        .logEvent('course_setting_click');
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
      '$_kCourseInvisibleKey'
      '${widget.courseNotifySaveKey}',
      invisibleCourseCodes,
    );
    setState(() {});
  }

  void fetchInvisibleCourseCodes() {
    invisibleCourseCodes =
        PreferenceUtil.instance.getStringList(
      '$_kCourseInvisibleKey'
      '${widget.courseNotifySaveKey}',
      <String>[],
    );
    setState(() {});
  }
}
