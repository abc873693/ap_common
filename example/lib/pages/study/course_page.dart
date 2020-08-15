import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/course_notify_data.dart';
import 'package:ap_common/models/semester_data.dart';
import 'package:ap_common/scaffold/course_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/constants.dart';
import '../../res/assets.dart';

class CoursePage extends StatefulWidget {
  static const String routerName = '/course';

  @override
  CoursePageState createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  ApLocalizations ap;

  CourseState state = CourseState.loading;

  SemesterData semesterData;

  CourseData courseData;

  CourseNotifyData notifyData;

  bool isOffline = false;

  String customStateHint = '';

  String get courseNotifyCacheKey => Preferences.getString(
        ApConstants.CURRENT_SEMESTER_CODE,
        ApConstants.SEMESTER_LATEST,
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
      enableNotifyControl: true,
      courseNotifySaveKey: courseNotifyCacheKey,
      androidResourceIcon: Constants.ANDROID_DEFAULT_NOTIFICATION_NAME,
      semesterData: semesterData,
      onSelect: (index) {
        semesterData.currentIndex = index;
        _getCourseTables();
      },
      onRefresh: () async {
        await _getCourseTables();
        return null;
      },
    );
  }

  Future<bool> _loadCourseData(String value) async {
    courseData = CourseData.load(semesterData.currentSemester.text);
    if (mounted) {
      setState(() {
        isOffline = true;
        if (this.courseData == null) {
          state = CourseState.offlineEmpty;
        } else {
          state = CourseState.finish;
        }
      });
    }
    return this.courseData == null;
  }

  void _getSemester() async {
    String rawString = await rootBundle.loadString(FileAssets.semesters);
    semesterData = SemesterData.fromRawJson(rawString);
    var i = 0;
    if(semesterData.defaultSemester!=null)
    semesterData.data.forEach((option) {
      if (option.text == semesterData.defaultSemester.text) semesterData.currentIndex = i;
      i++;
    });
    _getCourseTables();
  }

  _getCourseTables() async {
    String rawString = await rootBundle.loadString(FileAssets.courses);
    courseData = CourseData.fromRawJson(rawString);
    courseData.updateIndex();
    if (mounted && courseData != null)
      setState(() {
        if (courseData?.courseTables == null)
          state = CourseState.empty;
        else
          state = CourseState.finish;
      });
  }
}
