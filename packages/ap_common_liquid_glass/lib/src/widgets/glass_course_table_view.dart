import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// iOS-style pastel colors for course cells.
///
/// These are softer, semi-transparent tones inspired by
/// Apple Calendar and iOS 26 Liquid Glass aesthetics,
/// designed to let the glass backdrop show through.
const List<Color> glassCourseColors = <Color>[
  Color(0xCC007AFF), // iOS Blue
  Color(0xCC34C759), // iOS Green
  Color(0xCCFF9500), // iOS Orange
  Color(0xCCAF52DE), // iOS Purple
  Color(0xCCFF3B30), // iOS Red
  Color(0xCC5AC8FA), // iOS Light Blue
  Color(0xCCFF2D55), // iOS Pink
  Color(0xCC30D158), // iOS Mint Green
  Color(0xCCFFCC00), // iOS Yellow
  Color(0xCC5856D6), // iOS Indigo
  Color(0xCC00C7BE), // iOS Teal
  Color(0xFFA2845E), // iOS Brown
];

/// A glass-enhanced version of [CourseTableView].
///
/// Uses iOS-style pastel colors with translucent glass
/// backgrounds, rounded corners, and subtle frosted
/// effects for a Liquid Glass aesthetic.
class GlassCourseTableView extends StatelessWidget {
  /// Creates a [GlassCourseTableView].
  const GlassCourseTableView({
    super.key,
    required this.courseData,
    required this.invisibleCourseCodes,
    this.controller,
    this.onCoursePressed,
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

  /// Resolves a course code to its display color.
  final Color Function(String courseCode)
      courseColorResolver;

  /// Key for the [RepaintBoundary] used for screenshot
  /// capture.
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
    final int weekdayCount =
        courseData.hasHoliday ? 7 : 5;
    final Map<int, Map<int, Course>> courseLookup =
        buildCourseLookup(courseData.courses);
    return SingleChildScrollView(
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        bottom: 80.0,
      ),
      child: RepaintBoundary(
        key: repaintBoundaryKey,
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
    );
  }

  Widget _buildWeekdayHeader(
    BuildContext context,
    ColorScheme colorScheme,
    int weekdayCount,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant
                .withAlpha(128),
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
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
          ],
        ),
    );
  }

  Widget _buildTimeSlotHeader(ColorScheme colorScheme) {
    return SizedBox(
      width: 48,
      height: 40,
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
            .withAlpha(26),
        border: Border(
          right: BorderSide(
            color: colorScheme.outlineVariant
                .withAlpha(128),
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
    bool isLast,
  ) {
    return Container(
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
        courseColorResolver(course.code);
    const Color onCourseColor = Colors.white;
    final String locationInfo =
        (showClassroomLocation ?? true) &&
                course.location != null
            ? course.location.toString()
            : '';
    final String instructorInfo =
        (showInstructors ?? true)
            ? course.getInstructors()
            : '';

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
        onCoursePressed?.call(
          course,
          timeCode,
          weekday,
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: courseColor.withAlpha(179),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: onCourseColor.withAlpha(51),
            width: 0.5,
          ),
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
                fontSize: span > 1 ? 13 : 9.5,
                fontWeight: FontWeight.w600,
                color: onCourseColor,
                height: 1.1,
              ),
            ),
            if (displayInfo.isNotEmpty) ...<Widget>[
              SizedBox(height: span > 1 ? 3 : 1),
              Text(
                displayInfo,
                textAlign: TextAlign.center,
                maxLines: span > 1 ? 4 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: span > 1 ? 11 : 8,
                  color: onCourseColor.withAlpha(204),
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
