import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Simplified course page using [ApCoursePage].
///
/// Compare with [apps/example/lib/pages/study/course_page.dart] (~110 lines)
/// — this achieves the same result with just a single widget.
class SimpleCoursePage extends StatelessWidget {
  const SimpleCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ApCoursePage(
      onLoadSemesters: () async {
        final String rawString =
            await rootBundle.loadString(FileAssets.semesters);
        return SemesterData.fromRawJson(rawString);
      },
      onLoadCourse: (Semester semester) async {
        final String rawString =
            await rootBundle.loadString(FileAssets.courses);
        return CourseData.fromRawJson(rawString);
      },
      enableCaptureCourseTable: true,
    );
  }
}
