import 'package:ap_common_example_liquid_glass/res/assets.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Course page using [GlassApCoursePage].
class GlassCoursePage extends StatelessWidget {
  const GlassCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassApCoursePage(
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
