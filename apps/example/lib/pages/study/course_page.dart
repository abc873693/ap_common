import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/config/constants.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:ap_common_plugin/ap_common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoursePage extends StatefulWidget {
  static const String routerName = '/course';

  @override
  CoursePageState createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage> {
  CourseState state = CourseState.loading;

  SemesterData? semesterData;

  CourseData courseData = CourseData.empty();

  /// API-fetched course data (before merging custom courses).
  CourseData? _apiCourseData;

  CustomCourseData _customCourseData = CustomCourseData();

  CourseNotifyData? notifyData;

  bool isOffline = false;

  String customStateHint = '';

  final SemesterPickerController _pickerController = SemesterPickerController();

  String get courseNotifyCacheKey => PreferenceUtil.instance.getString(
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
    _pickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CourseScaffold(
      state: state,
      courseData: courseData,
      notifyData: notifyData,
      customHint: isOffline ? context.ap.offlineCourse : '',
      customStateHint: customStateHint,
      courseNotifySaveKey: courseNotifyCacheKey,
      androidResourceIcon: Constants.ANDROID_DEFAULT_NOTIFICATION_NAME,
      enableCaptureCourseTable: true,
      enableCustomCourse: true,
      customCourseData: _customCourseData,
      onCustomCourseChanged: _onCustomCourseChanged,
      semesterData: semesterData,
      semesterPickerController: _pickerController,
      onSelect: (int index) {
        semesterData = semesterData!.copyWith(currentIndex: index);
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
        semesterData = semesterData!.copyWith(currentIndex: i);
      }
      i++;
    }
    _getCourseTables();
  }

  Future<void> _getCourseTables() async {
    final String rawString = await rootBundle.loadString(FileAssets.courses);
    try {
      _apiCourseData = CourseData.fromRawJson(rawString);
      PreferenceUtil.instance.setString(
        ApConstants.currentSemesterCode,
        ApConstants.semesterLatest,
      );
      _apiCourseData!.save(courseNotifyCacheKey);
      _customCourseData = CustomCourseData.load(courseNotifyCacheKey);
      courseData =
          _apiCourseData!.mergeCustom(_customCourseData.courses);
      if (mounted) {
        final Semester semester =
            semesterData!.data[semesterData!.currentIndex];
        setState(() {
          if (courseData.courses.isEmpty) {
            state = CourseState.empty;
            _pickerController.markSemesterEmpty(semester);
          } else {
            state = CourseState.finish;
            notifyData = CourseNotifyData.load(courseNotifyCacheKey);
            _pickerController.markSemesterHasData(semester);
          }
        });
        if (courseData.courses.isNotEmpty) {
          await ApCommonPlugin.updateCourseWidget(courseData);
        }
      }
    } catch (e) {
      if (mounted) {
        final Semester semester =
            semesterData!.data[semesterData!.currentIndex];
        _pickerController.markSemesterHasData(semester);
        setState(() {
          state = CourseState.error;
        });
      }
      rethrow;
    }
  }

  void _onCustomCourseChanged(CustomCourseData updated) {
    _customCourseData = CustomCourseData(
      courses: updated.courses,
      tag: courseNotifyCacheKey,
    );
    _customCourseData.save();
    if (_apiCourseData != null && mounted) {
      setState(() {
        courseData =
            _apiCourseData!.mergeCustom(_customCourseData.courses);
        if (courseData.courses.isEmpty) {
          state = CourseState.empty;
        } else {
          state = CourseState.finish;
        }
      });
    }
  }
}
