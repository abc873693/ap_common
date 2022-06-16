import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/models/course_notify_data.dart';
import 'package:ap_common/models/general_response.dart';
import 'package:ap_common/models/semester_data.dart';
import 'package:ap_common/resources/ap_colors.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/resources/resources.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:ap_common/widgets/default_dialog.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/item_picker.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

export 'package:ap_common/models/course_data.dart';

typedef CourseNotifyCallback = Function(
  CourseNotify? courseNotify,
  CourseNotifyState state,
);

enum CourseState { loading, finish, error, empty, offlineEmpty, custom }

enum CourseNotifyState { schedule, cancel }

enum _ContentStyle { list, table }

const _courseHeight = 55.0;

class CourseConfig extends InheritedWidget {
  final bool? showSectionTime;
  final bool? showInstructors;
  final bool? showClassroomLocation;

  const CourseConfig({
    this.showSectionTime,
    this.showInstructors,
    this.showClassroomLocation,
    required Widget child,
  }) : super(child: child);

  static CourseConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  @override
  bool updateShouldNotify(CourseConfig oldWidget) {
    return true;
  }
}

class CourseScaffold extends StatefulWidget {
  /// 必要欄位，總共有
  /// `loading` `finish` `error` `empty` `offlineEmpty` `custom` 的狀態，
  /// 只有`finish`才會顯示課表介面，其餘都是顯示錯誤狀況
  final CourseState state;
  final String? customStateHint;
  final CourseData courseData;
  final String? title;
  final Widget? itemPicker;
  final SemesterData? semesterData;
  final Function(int index)? onSelect;
  final Function()? onSearchButtonClick;
  final Function()? onRefresh;
  final List<Widget>? actions;
  final String? customHint;
  final bool enableNotifyControl;
  final CourseNotifyData? notifyData;
  final bool autoNotifySave;
  final CourseNotifyCallback? onNotifyClick;
  final String courseNotifySaveKey;
  final bool enableAddToCalendar;
  final String? androidResourceIcon;
  final bool enableCaptureCourseTable;
  final bool? showSectionTime;
  final bool? showInstructors;
  final bool? showClassroomLocation;
  final bool? showSearchButton;

  const CourseScaffold({
    Key? key,
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
  }) : super(key: key);

  @override
  CourseScaffoldState createState() => CourseScaffoldState();
}

class CourseScaffoldState extends State<CourseScaffold> {
  final GlobalKey _repaintBoundaryGlobalKey = GlobalKey();

  ApLocalizations get app => ApLocalizations.of(context);

  _ContentStyle _contentStyle = _ContentStyle.table;

  bool? showSectionTime;
  bool? showInstructors;
  bool? showClassroomLocation;
  bool? showSearchButton;

  bool get isTablet =>
      MediaQuery.of(context).size.shortestSide >= 680 ||
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  void initState() {
    showSectionTime = widget.showSectionTime ??
        Preferences.getBool(ApConstants.showSectionTime, true);
    showInstructors = widget.showInstructors ??
        Preferences.getBool(ApConstants.showInstructors, true);
    showClassroomLocation = widget.showClassroomLocation ??
        Preferences.getBool(ApConstants.showClassroomLocation, true);
    showSearchButton = widget.showSearchButton ??
        Preferences.getBool(ApConstants.showCourseSearchButton, true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CourseConfig(
      showSectionTime: showSectionTime,
      showInstructors: showInstructors,
      showClassroomLocation: showClassroomLocation,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? app.course),
          actions: [
            ...widget.actions ?? [],
            if (widget.enableCaptureCourseTable)
              IconButton(
                icon: Icon(ApIcon.download),
                onPressed: _captureCourseTable,
                tooltip: ApLocalizations.of(context).exportCourseTable,
              ),
            IconButton(
              icon: Icon(ApIcon.settings),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => CourseScaffoldSettingDialog(
                    showSectionTime: showSectionTime,
                    showInstructors: showInstructors,
                    showClassroomLocation: showClassroomLocation,
                    showSearchButton: showSearchButton,
                    showSectionTimeOnChanged: (value) {
                      setState(() => showSectionTime = value);
                      Preferences.setBool(
                        ApConstants.showSectionTime,
                        showSectionTime!,
                      );
                    },
                    showInstructorsOnChanged: (value) {
                      setState(() => showInstructors = value);
                      Preferences.setBool(
                        ApConstants.showInstructors,
                        showInstructors!,
                      );
                    },
                    showClassroomLocationOnChanged: (value) {
                      setState(() => showClassroomLocation = value);
                      Preferences.setBool(
                        ApConstants.showClassroomLocation,
                        showClassroomLocation!,
                      );
                    },
                    showSearchButtonOnChanged: (value) {
                      setState(() => showSearchButton = value);
                      Preferences.setBool(
                        ApConstants.showCourseSearchButton,
                        showSearchButton!,
                      );
                    },
                  ),
                );
                AnalyticsUtils.instance?.logEvent('course_setting_click');
              },
              tooltip: ApLocalizations.of(context).courseScaffoldSetting,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (widget.semesterData != null || widget.itemPicker != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
//              ItemPicker(
//                onSelected: (int index) {},
//                items: widget.years,
//                currentIndex: widget.yearIndex,
//              ),
                        if (widget.semesterData != null &&
                            widget.itemPicker == null)
                          Expanded(
                            child: ItemPicker(
                              dialogTitle: app.pickSemester,
                              onSelected: widget.onSelect,
                              items: widget.semesterData!.semesters,
                              currentIndex: widget.semesterData!.currentIndex,
                              featureTag: 'course',
                            ),
                          ),
                        if (widget.itemPicker != null) widget.itemPicker!,
                      ],
                    ),
                  if (widget.customHint != null &&
                      widget.customHint!.isNotEmpty)
                    Text(
                      widget.customHint!,
                      style: TextStyle(color: ApTheme.of(context).grey),
                      textAlign: TextAlign.center,
                    ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await widget.onRefresh!();
                        AnalyticsUtils.instance?.logEvent('course_refresh');
                        return;
                      },
                      child: _body(),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.state == CourseState.finish && isTablet) ...[
              const SizedBox(width: 16.0),
              Expanded(
                flex: 2,
                child: Material(
                  elevation: 12.0,
                  child: Container(
                    color: ApTheme.of(context).courseListTabletBackground,
                    child: CourseList(
                      courses: widget.courseData.courses ?? [],
                      timeCodes: widget.courseData.timeCodes,
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: showSearchButton!
            ? FloatingActionButton(
                onPressed: () {
                  AnalyticsUtils.instance
                      ?.logEvent('course_search_button_click');
                  _pickSemester();
                },
                child: const Icon(Icons.search),
              )
            : null,
        bottomNavigationBar: isTablet
            ? null
            : BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      iconSize: _contentStyle == _ContentStyle.table ? 24 : 20,
                      color: _contentStyle == _ContentStyle.table
                          ? ApTheme.of(context).yellow
                          : ApTheme.of(context).grey,
                      icon: const Icon(Icons.grid_on),
                      onPressed: () {
                        setState(() => _contentStyle = _ContentStyle.table);
                      },
                    ),
                    IconButton(
                      iconSize: _contentStyle == _ContentStyle.list ? 24 : 20,
                      color: _contentStyle == _ContentStyle.list
                          ? ApTheme.of(context).yellow
                          : ApTheme.of(context).grey,
                      icon: const Icon(Icons.format_list_bulleted),
                      onPressed: () {
                        setState(() => _contentStyle = _ContentStyle.list);
                      },
                    ),
                    if (showSearchButton!) Container(height: 0),
                  ],
                ),
              ),
      ),
    );
  }

  String get hintContent {
    switch (widget.state) {
      case CourseState.error:
        return app.clickToRetry;
      case CourseState.empty:
        return app.courseEmpty;
      case CourseState.offlineEmpty:
        return app.noOfflineData;
      case CourseState.custom:
        return widget.customStateHint ?? app.unknownError;
      default:
        return '';
    }
  }

  Widget _body() {
    switch (widget.state) {
      case CourseState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case CourseState.empty:
      case CourseState.error:
      case CourseState.offlineEmpty:
      case CourseState.custom:
        return InkWell(
          onTap: () {
            if (widget.state == CourseState.empty) {
              _pickSemester();
            } else {
              widget.onRefresh?.call();
            }
          },
          child: HintContent(
            icon: ApIcon.classIcon,
            content: hintContent,
          ),
        );
      default:
        if (isTablet || _contentStyle == _ContentStyle.table) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: RepaintBoundary(
              key: _repaintBoundaryGlobalKey,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: renderCourseTable(),
                ),
              ),
            ),
          );
        } else {
          return CourseList(
            courses: widget.courseData.courses ?? [],
            timeCodes: widget.courseData.timeCodes,
          );
        }
    }
  }

  Future<void> _captureCourseTable() async {
    final RenderRepaintBoundary? boundary =
        _repaintBoundaryGlobalKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary?;
    if (boundary == null) {
      ApUtils.showToast(context, app.unknownError);
      return;
    }
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyyMMdd_hhmmss').format(now);
    if (byteData != null) {
      if (!mounted) return;
      await ApUtils.saveImage(
        context,
        byteData: byteData,
        successMessage: 'course_table_$formattedDate',
        fileName: ApLocalizations.of(context).exportCourseTableSuccess,
        onSuccess: (GeneralResponse r) => Toast.show(
          r.message,
          context,
        ),
        onError: (GeneralResponse e) => Toast.show(
          e.message,
          context,
        ),
      );
      AnalyticsUtils.instance?.logEvent('export_course_table_image_success');
    } else {
      if (!mounted) return;
      ApUtils.showToast(context, app.unknownError);
    }
  }

  BorderSide get _innerBorderSide => BorderSide(
        width: 0.5,
        color: ApTheme.of(context).courseBorder,
      );

  List<Widget> renderCourseTable() {
    final timeCodes = widget.courseData.timeCodes;
    final maxTimeCode = widget.courseData.maxTimeCodeIndex!;
    final minTimeCode = widget.courseData.minTimeCodeIndex!;
    final hasHoliday = widget.courseData.hasHoliday;
    final columns = <Column>[
      Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [],
      )
    ];
    columns[0].children.add(
          _weekBorder(''),
        );
    for (var i = minTimeCode; i < maxTimeCode + 1; i++) {
      columns[0].children.add(
            TimeCodeBorder(
              timeCode: timeCodes![i],
              hasHoliday: hasHoliday,
            ),
          );
    }
    final List<List<CourseBorder>> courseBorderCollection = [
      [],
      [],
      [],
      [],
      [],
      if (hasHoliday) ...[
        [],
        [],
      ]
    ];
    for (var i = 0; i < courseBorderCollection.length; i++) {
      for (var j = 0; j < maxTimeCode - minTimeCode + 1; j++) {
        courseBorderCollection[i].add(
          const CourseBorder(),
        );
      }
    }
    for (var i = 0; i < widget.courseData.courses!.length; i++) {
      final course = widget.courseData.courses![i];
      for (var j = 0; j < (course.times?.length ?? 0); j++) {
        final time = course.times![j];
        final timeCodeIndex = time.index!;
        final courseBorderIndex = timeCodeIndex - minTimeCode;
        final len = ApColors.colors.length;
        final color = ApColors.colors[i % len][300 + 100 * (i ~/ len)];
        courseBorderCollection[time.weekDayIndex][courseBorderIndex] =
            CourseBorder(
          sectionTime: time,
          timeCode: widget.courseData.timeCodes![timeCodeIndex],
          course: course,
          color: color,
          onPressed: _onPressed,
        );
      }
    }
    for (var i = 0; i < courseBorderCollection.length; i++) {
      final courseBorders = courseBorderCollection[i];
      for (var j = 0; j < courseBorders.length; j++) {
        int repeat = 0;
        if (courseBorders[j].course != null) {
          for (var k = j + 1; k < courseBorders.length; k++) {
            if (courseBorders[k].course != null &&
                courseBorders[j].course!.title ==
                    courseBorders[k].course!.title) {
              repeat++;
            } else {
              break;
            }
          }
        }
        if (repeat != 0) {
          final timeCode = courseBorders[j].timeCode!.copyWith();
          timeCode.endTime = courseBorders[j + repeat].timeCode!.endTime;
          courseBorders[j] = CourseBorder(
            timeCode: timeCode,
            sectionTime: courseBorders[j].sectionTime,
            course: courseBorders[j].course,
            height: _courseHeight * (repeat + 1),
            color: courseBorders[j].color,
            border: (j + repeat > courseBorders.length)
                ? Border(
                    left: _innerBorderSide,
                    right: (i == courseBorderCollection.length - 1)
                        ? BorderSide.none
                        : _innerBorderSide,
                    top: _innerBorderSide,
                  )
                : null,
            onPressed: _onPressed,
          );
          for (var k = j + 1; k < j + repeat + 1; k++) {
            courseBorders[k] = CourseBorder(
              course: courseBorders[k].course,
              height: 0.0,
              width: 0.0,
            );
          }
          j += repeat;
          repeat = 0;
        } else if (j == courseBorders.length - 1) {
          courseBorders[j] = CourseBorder(
            course: courseBorders[j].course,
            color: courseBorders[j].color,
            border: Border(
              left: _innerBorderSide,
              right: _innerBorderSide,
              top: _innerBorderSide,
              bottom: _innerBorderSide,
            ),
            onPressed: _onPressed,
            sectionTime: courseBorders[j].sectionTime,
            timeCode: courseBorders[j].timeCode,
          );
        }
      }
      columns.add(
        Column(
          children: [
            _weekBorder(app.weekdaysCourse[i]),
            ...courseBorderCollection[i],
          ],
        ),
      );
    }
    return [
      columns[0],
      for (var i = 1; i < columns.length; i++)
        Expanded(
          child: columns[i],
        )
    ];
  }

  void _onPressed(int weekday, TimeCode timeCode, Course course) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (builder) {
        return CourseContent(
          enableNotifyControl: widget.enableNotifyControl,
          course: course,
          notifyData: widget.notifyData,
          weekday: weekday,
          courseNotifySaveKey: widget.courseNotifySaveKey,
          timeCode: timeCode,
        );
      },
    );
  }

  Widget _weekBorder(String text) => Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(bottom: _innerBorderSide),
        ),
        height: 30.0,
        child: Text(
          text,
          style: TextStyle(
            color: ApTheme.of(context).blueText,
            fontSize: 14.0,
          ),
        ),
      );

  void _pickSemester() {
    if (widget.semesterData != null) {
      showDialog(
        context: context,
        builder: (_) => SimpleOptionDialog(
          title: app.pickSemester,
          items: widget.semesterData!.semesters,
          index: widget.semesterData!.currentIndex,
          onSelected: widget.onSelect,
        ),
      );
    }
    widget.onSearchButtonClick?.call();
  }
}

class CourseContent extends StatefulWidget {
  final bool enableNotifyControl;
  final Course course;
  final TimeCode timeCode;
  final int weekday;
  final CourseNotifyData? notifyData;
  final bool autoNotifySave;
  final CourseNotifyCallback? onNotifyClick;
  final String courseNotifySaveKey;
  final bool enableAddToCalendar;
  final String? androidResourceIcon;

  const CourseContent({
    Key? key,
    required this.enableNotifyControl,
    required this.course,
    required this.timeCode,
    required this.weekday,
    this.notifyData,
    this.autoNotifySave = true,
    this.onNotifyClick,
    this.courseNotifySaveKey = ApConstants.semesterLatest,
    this.enableAddToCalendar = true,
    this.androidResourceIcon,
  }) : super(key: key);

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  @override
  Widget build(BuildContext context) {
    CourseNotifyState? _state;
    if (widget.enableNotifyControl && widget.notifyData != null) {
      _state = widget.notifyData!.getByCode(
                widget.course.code,
                widget.timeCode.startTime,
                widget.weekday,
              ) ==
              null
          ? CourseNotifyState.cancel
          : CourseNotifyState.schedule;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.course.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: ApTheme.of(context).blueAccent,
                  ),
                ),
              ),
              if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS)) &&
                  widget.enableAddToCalendar)
                IconButton(
                  tooltip: ApLocalizations.of(context).addToCalendar,
                  icon: Image.asset(
                    ApImageIcons.calendarImport,
                    color: Theme.of(context).iconTheme.color,
                    height: 24.0,
                    width: 24.0,
                  ),
                  onPressed: () async {
                    final format = DateFormat('HH:mm');
                    final startTime = format.parse(widget.timeCode.startTime);
                    final endTime = format.parse(widget.timeCode.endTime);
                    final Event event = Event(
                      title: widget.course.title!,
                      location: widget.course.location?.toString() ?? '',
                      startDate: startTime.weekTime(widget.weekday),
                      endDate: endTime.weekTime(widget.weekday),
                      timeZone: 'GMT+8',
                    );
                    Add2Calendar.addEvent2Cal(event);
                    AnalyticsUtils.instance
                        ?.logEvent('course_export_to_calendar');
                  },
                ),
              if (widget.enableNotifyControl &&
                  widget.notifyData != null &&
                  NotificationUtils.isSupport)
                IconButton(
                  icon: Icon(
                    _state == CourseNotifyState.schedule
                        ? Icons.alarm_on
                        : Icons.alarm_off,
                  ),
                  onPressed: () async {
                    var courseNotify = widget.notifyData!.getByCode(
                      widget.course.code,
                      widget.timeCode.startTime,
                      widget.weekday,
                    );
                    if (widget.autoNotifySave) {
                      if (courseNotify == null) {
                        courseNotify = CourseNotify.fromCourse(
                          id: widget.notifyData!.lastId + 1,
                          course: widget.course,
                          weekday: widget.weekday,
                          timeCode: widget.timeCode,
                        );
                        await NotificationUtils.scheduleCourseNotify(
                          context: context,
                          courseNotify: courseNotify,
                          day: NotificationUtils.getDay(widget.weekday),
                          androidResourceIcon: widget.androidResourceIcon,
                        );
                        widget.notifyData!.lastId++;
                        widget.notifyData!.data.add(courseNotify);
                        if (!mounted) return;
                        ApUtils.showToast(
                          context,
                          ApLocalizations.of(context).courseNotifyHint,
                        );
                        AnalyticsUtils.instance
                            ?.logEvent('course_notify_schedule');
                      } else {
                        await NotificationUtils.cancelCourseNotify(
                          id: courseNotify.id,
                        );
                        widget.notifyData!.data.removeWhere((data) {
                          return data.id == courseNotify!.id;
                        });
                        if (!mounted) return;
                        ApUtils.showToast(
                          context,
                          ApLocalizations.of(context).cancelNotifySuccess,
                        );
                      }
                      widget.notifyData!.save();
                      setState(() {});
                      AnalyticsUtils.instance?.logEvent('course_notify_cancel');
                    }
                    if (widget.onNotifyClick != null) {
                      if (!mounted) return;
                      widget.onNotifyClick!(
                        courseNotify,
                        CourseNotifyState.values[(_state!.index + 1) %
                            (CourseNotifyState.values.length)],
                      );
                    }
                  },
                )
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.course.getInstructors(),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: ApTheme.of(context).grey,
                      ),
                    ),
                    if (widget.course.location != null)
                      Text(
                        widget.course.location?.toString() ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: ApTheme.of(context).greyText,
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '${widget.timeCode.startTime}-${widget.timeCode.endTime}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: ApTheme.of(context).greyText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class TimeCodeBorder extends StatelessWidget {
  final TimeCode timeCode;
  final bool hasHoliday;

  const TimeCodeBorder({
    Key? key,
    required this.timeCode,
    required this.hasHoliday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showSectionTime = CourseConfig.of(context).showSectionTime!;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 0.5,
            color: ApTheme.of(context).courseBorder,
          ),
        ),
      ),
      height: _courseHeight,
      width: hasHoliday ? 35.0 : 50.0,
      child: AutoSizeText.rich(
        TextSpan(
          style: TextStyle(
            color: ApTheme.of(context).greyText,
            fontSize: 14.0,
          ),
          children: [
            if (showSectionTime) TextSpan(text: '${timeCode.startTime}\n'),
            TextSpan(
              text: '${timeCode.title}\n',
              style: TextStyle(
                fontWeight:
                    showSectionTime ? FontWeight.bold : FontWeight.normal,
                color: ApTheme.of(context).blueText,
                fontSize: showSectionTime ? 16.0 : 14.0,
              ),
            ),
            if (showSectionTime) TextSpan(text: timeCode.endTime),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  final List<Course> courses;
  final List<TimeCode>? timeCodes;

  const CourseList({
    Key? key,
    required this.courses,
    this.timeCodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApLocalizations app = ApLocalizations.of(context);
    return ListView.builder(
      itemBuilder: (_, index) {
        final course = courses[index];
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            title: Text(
              courses[index].title!,
              style: const TextStyle(
                height: 1.3,
                fontSize: 20.0,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: SelectableText.rich(
                      TextSpan(
                        style: TextStyle(
                          color: ApTheme.of(context).grey,
                          fontSize: 16.0,
                        ),
                        children: [
                          if (course.className != null) ...[
                            TextSpan(
                              text: '${app.studentClass}：',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: '${course.className}\n'),
                          ],
                          TextSpan(
                            text: '${app.courseDialogProfessor}：',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${course.getInstructors()}\n'),
                          if (course.location != null) ...[
                            TextSpan(
                              text: '${app.courseDialogLocation}：',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: '${course.location.toString()}\n'),
                          ],
                          TextSpan(
                            text: '${app.courseDialogTime}：',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: course.getTimesShortName(timeCodes)),
                        ],
                      ),
                    ),
                  ),
                  if (course.required != null ||
                      course.units != null ||
                      course.hours != null)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (course.required != null)
                            Text(
                              course.required!,
                              style: TextStyle(
                                color: ApTheme.of(context).blueAccent,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          const SizedBox(height: 16.0),
                          if (course.units != null)
                            SelectableText.rich(
                              TextSpan(
                                style: TextStyle(
                                  color: ApTheme.of(context).grey,
                                  fontSize: 16.0,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${app.units}：',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: course.units),
                                ],
                              ),
                            ),
                          if (course.hours != null)
                            SelectableText.rich(
                              TextSpan(
                                style: TextStyle(
                                  color: ApTheme.of(context).grey,
                                  fontSize: 16.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${app.courseHours}：',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: course.hours),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: courses.length,
    );
  }
}

class CourseBorder extends StatelessWidget {
  final Course? course;
  final SectionTime? sectionTime;
  final TimeCode? timeCode;
  final double height;
  final double width;
  final Border? border;
  final Color? color;
  final void Function(int weekday, TimeCode timeCode, Course course)? onPressed;

  const CourseBorder({
    Key? key,
    this.course,
    this.sectionTime,
    this.timeCode,
    this.onPressed,
    this.height = _courseHeight,
    this.width = double.maxFinite,
    this.border,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showInstructors = CourseConfig.of(context).showInstructors;
    final showClassroomLocation =
        CourseConfig.of(context).showClassroomLocation;
    return Container(
      padding: EdgeInsets.only(
        bottom: course != null ? 2.0 : 0.0,
        right: course != null ? 2.0 : 0.0,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border ??
            Border.all(
              width: 0.5,
              color: ApTheme.of(context).courseBorder,
            ),
      ),
      child: Material(
        type: course != null ? MaterialType.canvas : MaterialType.transparency,
        color: course != null ? color : null,
        borderRadius: BorderRadius.all(
          Radius.circular(course != null ? 6.0 : 0.0),
        ),
        child: (course == null)
            ? Container()
            : InkWell(
                onTap: () {
                  onPressed?.call(sectionTime!.weekday!, timeCode!, course!);
                  AnalyticsUtils.instance?.logEvent('course_border_click');
                },
                radius: 6.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 4.0,
                  ),
                  child: Center(
                    child: AutoSizeText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: course!.title ?? ' ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight:
                                  (showInstructors! || showClassroomLocation!)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                          if (showInstructors)
                            TextSpan(text: '\n${course!.getInstructors()}'),
                          if (showClassroomLocation!)
                            TextSpan(text: '\n${course!.location ?? ' '}'),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: ApTheme.of(context).courseText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class CourseScaffoldSettingDialog extends StatefulWidget {
  final bool? showSectionTime;
  final bool? showInstructors;
  final bool? showClassroomLocation;
  final bool? showSearchButton;
  final Function(bool?)? showSectionTimeOnChanged;
  final Function(bool?)? showInstructorsOnChanged;
  final Function(bool?)? showClassroomLocationOnChanged;
  final Function(bool?)? showSearchButtonOnChanged;

  const CourseScaffoldSettingDialog({
    Key? key,
    required this.showSectionTime,
    required this.showInstructors,
    required this.showClassroomLocation,
    required this.showSearchButton,
    this.showSectionTimeOnChanged,
    this.showInstructorsOnChanged,
    this.showClassroomLocationOnChanged,
    this.showSearchButtonOnChanged,
  }) : super(key: key);

  @override
  _CourseScaffoldSettingDialogState createState() =>
      _CourseScaffoldSettingDialogState();
}

class _CourseScaffoldSettingDialogState
    extends State<CourseScaffoldSettingDialog> {
  bool? showSectionTime;
  bool? showInstructors;
  bool? showClassroomLocation;
  bool? showSearchButton;

  @override
  void initState() {
    showSectionTime = widget.showSectionTime;
    showInstructors = widget.showInstructors;
    showClassroomLocation = widget.showClassroomLocation;
    showSearchButton = widget.showSearchButton;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ap = ApLocalizations.current;
    return DefaultDialog(
      title: ap.courseScaffoldSetting,
      actionText: ApLocalizations.current.confirm,
      actionFunction: () => Navigator.of(context, rootNavigator: true).pop(),
      contentPadding: EdgeInsets.zero,
      contentWidget: Column(
        children: [
          CheckboxListTile(
            title: Text(ap.showSectionTime),
            secondary: Icon(ApIcon.accessTime),
            value: showSectionTime,
            onChanged: (value) {
              setState(() => showSectionTime = value);
              widget.showSectionTimeOnChanged?.call(value);
            },
            checkColor: ApTheme.of(context).background,
            activeColor: ApTheme.of(context).yellow,
          ),
          CheckboxListTile(
            title: Text(ap.showInstructors),
            secondary: Icon(ApIcon.person),
            value: showInstructors,
            onChanged: (value) {
              setState(() => showInstructors = value);
              widget.showInstructorsOnChanged?.call(value);
            },
            checkColor: ApTheme.of(context).background,
            activeColor: ApTheme.of(context).yellow,
          ),
          CheckboxListTile(
            title: Text(ap.showClassroomLocation),
            secondary: Icon(ApIcon.locationOn),
            value: showClassroomLocation,
            onChanged: (value) {
              setState(() => showClassroomLocation = value);
              widget.showClassroomLocationOnChanged?.call(value);
            },
            checkColor: ApTheme.of(context).background,
            activeColor: ApTheme.of(context).yellow,
          ),
          CheckboxListTile(
            title: Text(ap.showSearchButton),
            secondary: Icon(ApIcon.search),
            value: showSearchButton,
            onChanged: (value) {
              setState(() => showSearchButton = value);
              widget.showSearchButtonOnChanged?.call(value);
            },
            checkColor: ApTheme.of(context).background,
            activeColor: ApTheme.of(context).yellow,
          ),
        ],
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime weekTime(int weekday) {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    ).add(
      Duration(
        days: weekday - now.weekday,
      ),
    );
  }
}
