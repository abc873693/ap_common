import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// The display style for course content.
enum ContentStyle { list, table }

/// Height of each course time slot cell.
const double courseHeight = 64.0;

/// Builds a lookup map from (weekday, timeIndex) to [Course].
///
/// Returns a nested map where the outer key is the weekday number
/// and the inner key is the time slot index.
Map<int, Map<int, Course>> buildCourseLookup(
  List<Course> courses,
) {
  final Map<int, Map<int, Course>> lookup =
      <int, Map<int, Course>>{};
  for (final Course course in courses) {
    for (final SectionTime time in course.times) {
      lookup
          .putIfAbsent(
            time.weekday,
            () => <int, Course>{},
          )[time.index] = course;
    }
  }
  return lookup;
}

/// A widget that renders a course timetable grid.
///
/// This widget encapsulates all the grid rendering logic for
/// displaying courses in a table layout, including weekday headers,
/// time slot columns, and course cards.
class CourseTableView extends StatelessWidget {
  /// Creates a [CourseTableView].
  const CourseTableView({
    super.key,
    required this.courseData,
    required this.invisibleCourseCodes,
    this.controller,
    this.onCoursePressed,
    this.onEmptyCellPressed,
    required this.courseColorResolver,
    this.repaintBoundaryKey,
    this.mergeCourse,
    this.showSectionTime,
    this.showInstructors,
    this.showClassroomLocation,
  });

  /// The course data to display.
  final CourseData courseData;

  /// Course codes that should be hidden in the grid.
  final List<String> invisibleCourseCodes;

  /// Optional scroll controller for the grid.
  final ScrollController? controller;

  /// Callback when a course cell is tapped.
  final void Function(
    Course course,
    TimeCode timeCode,
    int weekday,
  )? onCoursePressed;

  /// Callback when an empty cell is tapped (e.g. for adding
  /// a custom course).
  final void Function(int weekday, int timeIndex)?
      onEmptyCellPressed;

  /// Resolves a [Course] to its display color.
  final Color Function(Course course) courseColorResolver;

  /// Key for the [RepaintBoundary] used for screenshot capture.
  final GlobalKey? repaintBoundaryKey;

  /// Whether to merge adjacent identical course cells.
  final bool? mergeCourse;

  /// Whether to show time information in time slot cells.
  final bool? showSectionTime;

  /// Whether to show instructor names on course cards.
  final bool? showInstructors;

  /// Whether to show classroom location on course cards.
  final bool? showClassroomLocation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final int weekdayCount = courseData.hasHoliday ? 7 : 5;
    final Map<int, Map<int, Course>> courseLookup =
        buildCourseLookup(courseData.courses);
    return SingleChildScrollView(
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 80.0,
      ),
      child: RepaintBoundary(
        key: repaintBoundaryKey,
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
              _buildWeekdayHeader(
                context,
                colorScheme,
                weekdayCount,
              ),
              _buildCourseGrid(
                context,
                colorScheme,
                weekdayCount,
                courseData.timeCodes,
                courseLookup,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeekdayHeader(
    BuildContext context,
    ColorScheme colorScheme,
    int weekdayCount,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withAlpha(77),
        border: Border(
          bottom: BorderSide(
            color:
                colorScheme.outlineVariant.withAlpha(128),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          _buildTimeSlotHeader(colorScheme),
          for (int i = 0; i < weekdayCount; i++)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Text(
                  context.ap.weekdaysCourse[i],
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
    BuildContext context,
    ColorScheme colorScheme,
    int weekdayCount,
    List<TimeCode> timeCodes,
    Map<int, Map<int, Course>> courseLookup,
  ) {
    final int minIndex = courseData.minTimeCodeIndex;
    final int maxIndex = courseData.maxTimeCodeIndex;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTimeColumn(
          colorScheme,
          timeCodes,
          minIndex,
          maxIndex,
        ),
        for (int weekday = 1;
            weekday <= weekdayCount;
            weekday++)
          Expanded(
            child: _buildWeekdayColumn(
              colorScheme,
              weekday,
              weekdayCount,
              minIndex,
              maxIndex,
              courseLookup,
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
    Map<int, Map<int, Course>> courseLookup,
  ) {
    final List<Widget> children = <Widget>[];
    for (int i = minIndex; i <= maxIndex; i++) {
      final Course? course =
          courseLookup[weekday]?[i];
      final bool isInvisible = course != null &&
          invisibleCourseCodes.contains(course.code);

      if (course == null || isInvisible) {
        children.add(
          _buildEmptyCell(
            colorScheme,
            weekday < weekdayCount,
            i == maxIndex,
            weekday: weekday,
            timeIndex: i,
          ),
        );
      } else {
        int span = 1;
        if (mergeCourse ?? true) {
          while (i + span <= maxIndex &&
              courseLookup[weekday]?[i + span] ==
                  course) {
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
      height: courseHeight,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest
            .withAlpha(77),
        border: Border(
          right: BorderSide(
            color:
                colorScheme.outlineVariant.withAlpha(128),
          ),
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: colorScheme.outlineVariant
                      .withAlpha(77),
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
          if (timeCode != null &&
              (showSectionTime ?? true)) ...<Widget>[
            const SizedBox(height: 2),
            Text(
              timeCode.startTime,
              style: TextStyle(
                fontSize: 9,
                color: colorScheme.onSurfaceVariant
                    .withAlpha(179),
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
    bool isLast, {
    required int weekday,
    required int timeIndex,
  }) {
    return GestureDetector(
      onTap: onEmptyCellPressed != null
          ? () => onEmptyCellPressed!(weekday, timeIndex)
          : null,
      child: Container(
        height: courseHeight,
        decoration: BoxDecoration(
          border: Border(
            right: showRightBorder
                ? BorderSide(
                    color: colorScheme.outlineVariant
                        .withAlpha(51),
                    width: 0.5,
                  )
                : BorderSide.none,
            bottom: isLast
                ? BorderSide.none
                : BorderSide(
                    color: colorScheme.outlineVariant
                        .withAlpha(77),
                    width: 0.5,
                  ),
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
      height: courseHeight * span,
      decoration: BoxDecoration(
        border: Border(
          right: showRightBorder
              ? BorderSide(
                  color: colorScheme.outlineVariant
                      .withAlpha(51),
                  width: 0.5,
                )
              : BorderSide.none,
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: colorScheme.outlineVariant
                      .withAlpha(77),
                  width: 0.5,
                ),
        ),
      ),
      child: _buildCourseCard(
        colorScheme,
        weekday,
        timeIndex,
        course,
        span,
      ),
    );
  }

  Widget _buildCourseCard(
    ColorScheme colorScheme,
    int weekday,
    int timeIndex,
    Course course,
    int span,
  ) {
    final Color courseColor =
        courseColorResolver(course);
    final String locationInfo =
        (showClassroomLocation ?? true) &&
                course.location != null
            ? course.location.toString()
            : '';
    final String instructorInfo =
        (showInstructors ?? true)
            ? course.getInstructors()
            : '';

    final Color onCourseColor =
        ThemeData.estimateBrightnessForColor(courseColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;

    final String displayInfo = <String>[
      if (instructorInfo.isNotEmpty) instructorInfo,
      if (locationInfo.isNotEmpty) locationInfo,
    ].join('\n');

    return GestureDetector(
      onTap: () {
        final TimeCode timeCode =
            timeIndex < courseData.timeCodes.length
                ? courseData.timeCodes[timeIndex]
                : const TimeCode(
                    title: '?',
                    startTime: '?',
                    endTime: '?',
                  );
        onCoursePressed?.call(course, timeCode, weekday);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 6,
        ),
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
}
