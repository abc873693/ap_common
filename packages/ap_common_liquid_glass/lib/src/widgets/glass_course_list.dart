import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_course_content.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass-enhanced version of [CourseList].
///
/// Replaces Material [Card] surfaces with [GlassCard] for
/// each course item while keeping the layout and
/// interactions identical.
class GlassCourseList extends StatelessWidget {
  /// Creates a [GlassCourseList].
  const GlassCourseList({
    super.key,
    required this.courses,
    this.invisibleCourseCodes = const <String>[],
    this.onVisibilityChanged,
    this.timeCodes,
    this.controller,
  });

  /// The list of courses to display.
  final List<Course> courses;

  /// Course codes that should be hidden in the grid.
  final List<String> invisibleCourseCodes;

  /// Called when a course's visibility is toggled.
  final void Function(Course, bool)?
      onVisibilityChanged;

  /// Time code definitions.
  final List<TimeCode>? timeCodes;

  /// Optional scroll controller.
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return ListView.builder(
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        bottom: 80.0,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      itemCount: courses.length,
      itemBuilder: (_, int index) {
        final Course course = courses[index];
        final bool visibility =
            !invisibleCourseCodes
                .contains(course.code);
        final Color courseColor =
            courseColors[index % courseColors.length];
        final String instructors =
            course.getInstructors();

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            useOwnLayer: true,
            padding: EdgeInsets.zero,
            child: InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor:
                      const Color(0x00000000),
                  isScrollControlled: true,
                  builder:
                      (BuildContext context) =>
                          GlassCourseContent(
                    course: course,
                    invisibleCourseCodes:
                        invisibleCourseCodes,
                    onVisibilityChanged:
                        (bool visible) =>
                            onVisibilityChanged
                                ?.call(
                      course,
                      visible,
                    ),
                    timeCode: timeCodes != null &&
                            timeCodes!.isNotEmpty
                        ? timeCodes![0]
                        : const TimeCode(
                            title: '',
                            startTime: '',
                            endTime: '',
                          ),
                    weekday: course.times.isNotEmpty
                        ? course.times.first.weekday
                        : 1,
                    courseColor: courseColor,
                    enableNotifyControl: false,
                  ),
                );
              },
              borderRadius:
                  BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 4,
                      height: 60,
                      decoration: BoxDecoration(
                        color: courseColor,
                        borderRadius:
                            BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            course.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w600,
                              color: colorScheme
                                  .onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            instructors.isNotEmpty
                                ? instructors
                                : context.ap.unknown,
                            style: TextStyle(
                              fontSize: 13,
                              color: colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                          Text(
                            course.location
                                    ?.toString() ??
                                '-',
                            style: TextStyle(
                              fontSize: 13,
                              color: colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          visualDensity:
                              VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(),
                          icon: Icon(
                            visibility
                                ? Icons
                                    .visibility_outlined
                                : Icons
                                    .visibility_off_outlined,
                            size: 20,
                            color: colorScheme
                                .onSurfaceVariant,
                          ),
                          onPressed: () =>
                              onVisibilityChanged
                                  ?.call(
                            course,
                            !visibility,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: courseColor
                                .withAlpha(26),
                            borderRadius:
                                BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Text(
                            '${course.units ?? "-"}'
                            ' ${context.ap.units}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w600,
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
          ),
        );
      },
    );
  }
}
