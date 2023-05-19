import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/course_notify_data.dart';
import 'package:ap_common/models/semester_data.dart';
import 'package:ap_common/scaffold/course_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:ap_common_example/config/constants.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoursePage extends StatefulWidget {
  static const String routerName = '/course';

  @override
  CoursePageState createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  late ApLocalizations ap;

  CourseState state = CourseState.loading;

  SemesterData? semesterData;

  CourseData courseData = CourseData.empty();

  CourseNotifyData? notifyData;

  bool isOffline = false;

  String customStateHint = '';

  String get courseNotifyCacheKey => Preferences.getString(
        ApConstants.currentSemesterCode,
        ApConstants.semesterLatest,
      );

  @override
  void initState() {
    _getSemester();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ap = ApLocalizations.of(context);
    return CourseScaffold(
      state: state,
      courseData: courseData,
      notifyData: notifyData,
      customHint: isOffline ? ap.offlineCourse : '',
      customStateHint: customStateHint,
      courseNotifySaveKey: courseNotifyCacheKey,
      androidResourceIcon: Constants.ANDROID_DEFAULT_NOTIFICATION_NAME,
      enableCaptureCourseTable: true,
      semesterData: semesterData,
      onSelect: (int index) {
        semesterData!.currentIndex = index;
        _getCourseTables();
      },
      onRefresh: () async {
        await _getCourseTables();
        return null;
      },
    );
  }

  Future<void> _getSemester() async {
    final String rawString = await rootBundle.loadString(FileAssets.semesters);
    semesterData = SemesterData.fromRawJson(rawString);
    for (int i = 0; i < semesterData!.data.length; i++) {
      final Semester option = semesterData!.data[i];
      if (option.text == semesterData!.defaultSemester.text) {
        semesterData!.currentIndex = i;
      }
      i++;
    }
    _getCourseTables();
  }

  Future<void> _getCourseTables() async {
    final String rawString = await rootBundle.loadString(FileAssets.courses);
    courseData = CourseData.fromRawJson(rawString);
    Preferences.setString(
      ApConstants.currentSemesterCode,
      ApConstants.semesterLatest,
    );
    courseData.save(courseNotifyCacheKey);
    if (mounted) {
      setState(() {
        if (courseData.courses.isEmpty) {
          state = CourseState.empty;
        } else {
          state = CourseState.finish;
          notifyData = CourseNotifyData.load(courseNotifyCacheKey);
        }
      });
    }
  }
}
