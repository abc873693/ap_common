import 'dart:io' show Platform;

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass-enhanced version of [CourseContent].
///
/// Replaces the Material bottom sheet surface with
/// [GlassCard] / [GlassContainer] while keeping all
/// internal logic (notifications, calendar, visibility)
/// identical.
class GlassCourseContent extends StatefulWidget {
  /// Creates a [GlassCourseContent].
  const GlassCourseContent({
    super.key,
    required this.enableNotifyControl,
    required this.course,
    required this.timeCode,
    required this.weekday,
    this.notifyData,
    this.autoNotifySave = true,
    this.onNotifyClick,
    this.courseNotifySaveKey =
        ApConstants.semesterLatest,
    this.enableAddToCalendar = true,
    this.androidResourceIcon,
    this.invisibleCourseCodes = const <String>[],
    this.onVisibilityChanged,
    this.courseColor,
  });

  /// Whether to show notification controls.
  final bool enableNotifyControl;

  /// The course to display details for.
  final Course course;

  /// The time code for this course slot.
  final TimeCode timeCode;

  /// The weekday number for this course slot.
  final int weekday;

  /// Notification data for course reminders.
  final CourseNotifyData? notifyData;

  /// Whether to auto-save notification changes.
  final bool autoNotifySave;

  /// Callback when notification button is pressed.
  final CourseNotifyCallback? onNotifyClick;

  /// Key used to persist notification data.
  final String courseNotifySaveKey;

  /// Whether to show the add-to-calendar button.
  final bool enableAddToCalendar;

  /// Android notification icon resource name.
  final String? androidResourceIcon;

  /// Course codes that are currently hidden.
  final List<String> invisibleCourseCodes;

  /// Called when visibility is toggled.
  final ValueChanged<bool>? onVisibilityChanged;

  /// Color for the course header.
  final Color? courseColor;

  @override
  State<GlassCourseContent> createState() =>
      _GlassCourseContentState();
}

class _GlassCourseContentState
    extends State<GlassCourseContent> {
  CourseNotifyData? _notifyData;

  @override
  void initState() {
    _notifyData = widget.notifyData;
    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant GlassCourseContent oldWidget,
  ) {
    if (widget.notifyData != oldWidget.notifyData) {
      _notifyData = widget.notifyData;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    CourseNotifyState? state;
    if (widget.enableNotifyControl &&
        widget.notifyData != null) {
      state = widget.notifyData!.getByCode(
                widget.course.code,
                widget.timeCode.startTime,
                widget.weekday,
              ) ==
              null
          ? CourseNotifyState.cancel
          : CourseNotifyState.schedule;
    }
    final bool visibility = !widget
        .invisibleCourseCodes
        .contains(widget.course.code);
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final Color courseColor = widget.courseColor ??
        courseColors[widget.course.code.hashCode %
            courseColors.length];
    final Color onCourseColor =
        ThemeData.estimateBrightnessForColor(
                    courseColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;
    return GlassCard(
      useOwnLayer: true,
      padding: EdgeInsets.zero,
      shape: const LiquidRoundedSuperellipse(
        borderRadius: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              right: 8,
              top: 12,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: courseColor,
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: <Widget>[
                _buildActionRow(
                  context,
                  state,
                  visibility,
                  onCourseColor,
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
                    if (widget.course.required !=
                            null &&
                        widget.course.required!
                            .isNotEmpty)
                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: onCourseColor
                              .withAlpha(51),
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
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
                    color: onCourseColor
                        .withAlpha(204),
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
                  widget.course.location
                          ?.toString() ??
                      '-',
                  colorScheme,
                ),
                _buildDetailRow(
                  Icons.school_outlined,
                  '學分數',
                  '${widget.course.units ?? "-"}'
                  ' ${context.ap.units}',
                  colorScheme,
                ),
                _buildDetailRow(
                  Icons.schedule_outlined,
                  context.ap.courseDialogTime,
                  '${widget.timeCode.startTime}'
                  '-${widget.timeCode.endTime}',
                  colorScheme,
                ),
                if (widget.course.className !=
                        null &&
                    widget.course.className!
                        .isNotEmpty)
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

  Widget _buildActionRow(
    BuildContext context,
    CourseNotifyState? state,
    bool visibility,
    Color onCourseColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if ((!kIsWeb &&
                (Platform.isAndroid ||
                    Platform.isIOS)) &&
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
              final DateFormat format =
                  DateFormat('HH:mm');
              final DateTime startTime =
                  format.parse(
                widget.timeCode.startTime,
              );
              final DateTime endTime =
                  format.parse(
                widget.timeCode.endTime,
              );
              PlatformCalendarUtil.instance
                  .addToApp(
                title: widget.course.title,
                location: widget.course.location
                        ?.toString() ??
                    '',
                startDate: startTime
                    .weekTime(widget.weekday),
                endDate: endTime
                    .weekTime(widget.weekday),
                timeZone: 'GMT+8',
              );
              AnalyticsUtil.instance.logEvent(
                'course_export_to_calendar',
              );
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
              widget.onVisibilityChanged
                  ?.call(!visibility);
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
              await _handleNotifyPressed(
                context,
                state,
              );
            },
          ),
      ],
    );
  }

  Future<void> _handleNotifyPressed(
    BuildContext context,
    CourseNotifyState? state,
  ) async {
    CourseNotify? courseNotify =
        _notifyData!.getByCode(
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
          androidResourceIcon:
              widget.androidResourceIcon,
        );
        _notifyData = _notifyData!.copyWith(
          lastId: _notifyData!.lastId + 1,
          data: <CourseNotify>[
            ..._notifyData!.data,
            courseNotify,
          ],
        );
        _notifyData!
            .save(widget.courseNotifySaveKey);
        if (!context.mounted) return;
        UiUtil.instance.showToast(
          context,
          context.ap.courseNotifyHint,
        );
        AnalyticsUtil.instance.logEvent(
          'course_notify_schedule',
        );
      } else {
        await NotificationUtil.instance
            .cancelNotify(
          id: courseNotify.id,
        );
        final List<CourseNotify> newData =
            <CourseNotify>[
          ..._notifyData!.data,
        ];
        newData.removeWhere(
          (CourseNotify data) =>
              data.id == courseNotify!.id,
        );
        _notifyData = _notifyData!.copyWith(
          data: newData,
        );
        _notifyData!
            .save(widget.courseNotifySaveKey);
        if (!context.mounted) return;
        UiUtil.instance.showToast(
          context,
          context.ap.cancelNotifySuccess,
        );
      }
      setState(() {});
      AnalyticsUtil.instance.logEvent(
        'course_notify_cancel',
      );
    }
    if (widget.onNotifyClick != null) {
      if (!mounted) return;
      widget.onNotifyClick?.call(
        courseNotify,
        CourseNotifyState.values[
            (state!.index + 1) %
                (CourseNotifyState.values.length)],
      );
    }
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    ColorScheme colorScheme,
  ) {
    if (value.isEmpty || value == '-') {
      return const SizedBox();
    }
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: <Widget>[
          GlassCard(
            useOwnLayer: true,
            padding: EdgeInsets.zero,
            width: 36,
            height: 36,
            child: Center(
              child: Icon(
                icon,
                size: 18,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme
                        .onSurfaceVariant,
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
