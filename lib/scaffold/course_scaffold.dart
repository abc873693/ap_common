import 'dart:io';
import 'dart:math';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/models/course_notify_data.dart';
import 'package:ap_common/models/semester_data.dart';
import 'package:ap_common/resources/ap_colors.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/notification_utils.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/item_picker.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

export 'package:ap_common/models/course_data.dart';

typedef CourseNotifyCallback(
    CourseNotify courseNotify, CourseNotifyState state);

enum CourseState { loading, finish, error, empty, offlineEmpty, custom }
enum CourseNotifyState { schedule, cancel }
enum _ContentStyle { list, table }

const _courseHeight = 55.0;

class CourseScaffold extends StatefulWidget {
  /// 必要欄位，總共有 `loading` `finish` `error` `empty` `offlineEmpty` `custom` 的狀態，只有`finish`才會顯示課表介面，其餘都是顯示錯誤狀況
  final CourseState state;
  final String customStateHint;
  final CourseData courseData;
  final String title;
  final Widget itemPicker;
  final SemesterData semesterData;
  final Function(int index) onSelect;
  final bool isShowSearchButton;
  final Function onSearchButtonClick;
  final Function() onRefresh;
  final List<Widget> actions;
  final String customHint;
  final bool enableNotifyControl;
  final CourseNotifyData notifyData;
  final bool autoNotifySave;
  final CourseNotifyCallback onNotifyClick;
  final String courseNotifySaveKey;
  final bool enableAddToCalendar;
  final String androidResourceIcon;

  const CourseScaffold({
    Key key,
    @required this.state,
    @required this.courseData,
    this.title,
    this.customHint,
    this.semesterData,
    this.onSelect,
    this.onRefresh,
    this.isShowSearchButton = true,
    this.actions,
    this.enableNotifyControl = true,
    this.notifyData,
    this.autoNotifySave = true,
    this.onNotifyClick,
    this.courseNotifySaveKey = ApConstants.SEMESTER_LATEST,
    this.customStateHint,
    this.itemPicker,
    this.onSearchButtonClick,
    this.enableAddToCalendar = true,
    this.androidResourceIcon,
  }) : super(key: key);

  @override
  CourseScaffoldState createState() => CourseScaffoldState();
}

class CourseScaffoldState extends State<CourseScaffold> {
  ApLocalizations app;

  _ContentStyle _contentStyle = _ContentStyle.table;

  bool get isTablet =>
      MediaQuery.of(context).size.shortestSide >= 680 ||
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    app = ApLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? app.course),
        actions: widget.actions,
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
                    mainAxisSize: MainAxisSize.max,
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
                            dialogTitle: app.picksSemester,
                            onSelected: widget.onSelect,
                            items: widget.semesterData.semesters,
                            currentIndex: widget.semesterData.currentIndex,
                          ),
                        ),
                      if (widget.itemPicker != null) widget.itemPicker,
                    ],
                  ),
                if (widget.customHint != null && widget.customHint.isNotEmpty)
                  Text(
                    widget.customHint,
                    style: TextStyle(color: ApTheme.of(context).grey),
                    textAlign: TextAlign.center,
                  ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await widget.onRefresh();
                      return null;
                    },
                    child: _body(),
                  ),
                ),
              ],
            ),
          ),
          if (widget.state == CourseState.finish && isTablet) ...[
            SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: Material(
                elevation: 12.0,
                child: Container(
                  color: ApTheme.of(context).courseListTabletBackground,
                  child: CourseList(
                    courses: widget.courseData.courses,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: widget.isShowSearchButton
          ? FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: _pickSemester,
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
                    icon: Icon(Icons.grid_on),
                    onPressed: () {
                      setState(() => _contentStyle = _ContentStyle.table);
                    },
                  ),
                  IconButton(
                    iconSize: _contentStyle == _ContentStyle.list ? 24 : 20,
                    color: _contentStyle == _ContentStyle.list
                        ? ApTheme.of(context).yellow
                        : ApTheme.of(context).grey,
                    icon: Icon(Icons.format_list_bulleted),
                    onPressed: () {
                      setState(() => _contentStyle = _ContentStyle.list);
                    },
                  ),
                  if (widget.isShowSearchButton) Container(height: 0),
                ],
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
        return Container(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
        );
      case CourseState.empty:
      case CourseState.error:
      case CourseState.offlineEmpty:
      case CourseState.custom:
        return FlatButton(
          onPressed: () {
            if (widget.state == CourseState.empty)
              _pickSemester();
            else if (widget.onRefresh != null) widget.onRefresh();
          },
          child: HintContent(
            icon: ApIcon.classIcon,
            content: hintContent,
          ),
        );
      default:
        if (isTablet || _contentStyle == _ContentStyle.table) {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: renderCourseTable(),
              ),
            ),
          );
        } else {
          return CourseList(
            courses: widget.courseData.courses,
          );
        }
    }
  }

  BorderSide get _innerBorderSide => BorderSide(
        width: 0.5,
        color: ApTheme.of(context).courseBorder,
      );

  List<Widget> renderCourseTable() {
    List<String> weeks = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      if (widget.courseData.hasHoliday) ...[
        'Saturday',
        'Sunday',
      ]
    ];
    final timeCodes = widget.courseData.courseTables.timeCode;
    final maxTimeCode = widget.courseData.courseTables.getMaxTimeCode(weeks);
    final minTimeCode = widget.courseData.courseTables.getMinTimeCode(weeks);
    var columns = <Column>[Column(children: [])];
    columns[0].children.add(
          _weekBorder(''),
        );
    for (var i = minTimeCode; i < maxTimeCode; i++) {
      var text = timeCodes[i].replaceAll(' ', '');
      if (widget.courseData.hasHoliday) {
        text = text.replaceAll('第', '');
        text = text.replaceAll('節', '');
      }
      columns[0].children.add(
            _timeCodeBorder(text),
          );
    }
    for (int i = 0; i < weeks.length; i++) {
      final List<CourseBorder> courseBorders = [];
      for (var j = 0; j < maxTimeCode - minTimeCode; j++)
        courseBorders.add(CourseBorder());
      var courses = widget.courseData.courseTables.getCourseList(weeks[i]);
      if (courses != null) {
        for (var course in courses) {
          for (int j = 0; j < maxTimeCode - minTimeCode; j++) {
            final timeCodeIndex = j + minTimeCode;
            if (timeCodes[timeCodeIndex] == course.date.section) {
              final index = widget.courseData.findCourseDetail(course);
              final detailIndex = course.detailIndex ?? 0;
              final len = ApColors.colors.length;
              courseBorders[j] = CourseBorder(
                weekIndex: i,
                course: course,
                color: (index == -1)
                    ? ApColors.colors[Random().nextInt(len)][300]
                    : ApColors.colors[detailIndex % len]
                        [300 + 100 * (detailIndex ~/ len)],
                onPressed: _onPressed,
              );
            }
          }
        }
      }
      for (var j = 0; j < courseBorders.length; j++) {
        int repeat = 0;
        if (courseBorders[j].course != null)
          for (var k = j + 1; k < courseBorders.length; k++) {
            if (courseBorders[k].course != null &&
                courseBorders[j].course.title ==
                    courseBorders[k].course.title) {
              repeat++;
            } else
              break;
          }
        if (repeat != 0) {
          final course = courseBorders[j].course;
          course.date.endTime = courseBorders[j + repeat].course.date.endTime;
          courseBorders[j] = CourseBorder(
            weekIndex: courseBorders[j].weekIndex,
            course: courseBorders[j].course,
            height: _courseHeight * (repeat + 1),
            color: courseBorders[j].color,
            border: (j + repeat > courseBorders.length)
                ? Border(
                    left: _innerBorderSide,
                    right: (i == weeks.length - 1)
                        ? BorderSide.none
                        : _innerBorderSide,
                    top: _innerBorderSide,
                  )
                : null,
            onPressed: _onPressed,
          );
          for (var k = j + 1; k < j + repeat + 1; k++) {
            courseBorders[k] = CourseBorder(
              weekIndex: courseBorders[k].weekIndex,
              course: courseBorders[k].course,
              height: 0.0,
              width: 0.0,
            );
          }
          j += repeat;
          repeat = 0;
        } else if (j == courseBorders.length - 1) {
          courseBorders[j] = CourseBorder(
            weekIndex: courseBorders[j].weekIndex,
            course: courseBorders[j].course,
            color: courseBorders[j].color,
            border: Border(
              left: _innerBorderSide,
              right: _innerBorderSide,
              top: _innerBorderSide,
              bottom: _innerBorderSide,
            ),
            onPressed: _onPressed,
          );
        }
      }
      columns.add(
        Column(
          children: [
            _weekBorder(app.weekdaysCourse[i]),
            ...courseBorders,
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

  void _onPressed(int weekIndex, Course course) {
    final courseDetail = widget.courseData.courses[course.detailIndex ?? 0];
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (builder) {
        return CourseContent(
          enableNotifyControl: widget.enableNotifyControl,
          course: course,
          courseDetail: courseDetail,
          notifyData: widget.notifyData,
          weekIndex: weekIndex,
          courseNotifySaveKey: widget.courseNotifySaveKey,
        );
      },
    );
  }

  Widget _weekBorder(String text) => Container(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(bottom: _innerBorderSide),
        ),
        height: 30.0,
        child: Text(
          text ?? '',
          style: TextStyle(
            color: ApTheme.of(context).blueText,
            fontSize: 14.0,
          ),
        ),
      );

  Widget _timeCodeBorder(String text) => Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(right: _innerBorderSide),
        ),
        height: _courseHeight,
        width: widget.courseData.hasHoliday ? 35.0 : 50.0,
        child: Text(
          text ?? '',
          style: TextStyle(
            color: ApTheme.of(context).blueText,
            fontSize: 14.0,
          ),
        ),
      );

  void _pickSemester() {
    if (widget.semesterData != null)
      showDialog(
        context: context,
        builder: (_) => SimpleOptionDialog(
          title: app.picksSemester,
          items: widget.semesterData.semesters,
          index: widget.semesterData.currentIndex,
          onSelected: widget.onSelect,
        ),
      );
    if (widget.onSearchButtonClick != null) widget.onSearchButtonClick();
  }
}

class CourseContent extends StatefulWidget {
  final bool enableNotifyControl;
  final Course course;
  final CourseDetail courseDetail;
  final int weekIndex;
  final CourseNotifyData notifyData;
  final bool autoNotifySave;
  final CourseNotifyCallback onNotifyClick;
  final String courseNotifySaveKey;
  final bool enableAddToCalendar;
  final String androidResourceIcon;

  const CourseContent({
    Key key,
    @required this.enableNotifyControl,
    @required this.course,
    @required this.courseDetail,
    @required this.weekIndex,
    this.notifyData,
    this.autoNotifySave = true,
    this.onNotifyClick,
    this.courseNotifySaveKey = ApConstants.SEMESTER_LATEST,
    this.enableAddToCalendar = true,
    this.androidResourceIcon,
  }) : super(key: key);

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  @override
  Widget build(BuildContext context) {
    CourseNotifyState _state;
    if (widget.enableNotifyControl && widget.notifyData != null) {
      _state = (widget.notifyData.getByCode(
                widget.courseDetail.code,
                widget.course.date.startTime,
                widget.weekIndex,
              ) ==
              null
          ? CourseNotifyState.cancel
          : CourseNotifyState.schedule);
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
                  widget.course.title,
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
                  icon: Icon(MdiIcons.calendarImport),
                  onPressed: () async {
                    final format = DateFormat('HH:mm');
                    final startTime =
                        format.parse(widget.course.date.startTime);
                    final endTime = format.parse(widget.course.date.endTime);
                    final Event event = Event(
                      title: widget.course.title,
                      description: '',
                      location: widget.course.location?.toString() ?? '',
                      startDate: startTime.weekTime(widget.weekIndex),
                      endDate: endTime.weekTime(widget.weekIndex),
                    );
                    Add2Calendar.addEvent2Cal(event);
                  },
                ),
              if (widget.enableNotifyControl &&
                  widget.notifyData != null &&
                  NotificationUtils.isSupport)
                IconButton(
                  icon: Icon(_state == CourseNotifyState.schedule
                      ? Icons.alarm_on
                      : Icons.alarm_off),
                  onPressed: () async {
                    var courseNotify = widget.notifyData.getByCode(
                      widget.courseDetail.code,
                      widget.course.date.startTime,
                      widget.weekIndex,
                    );
                    if (widget.autoNotifySave) {
                      if (courseNotify == null) {
                        courseNotify = CourseNotify.fromCourse(
                          id: widget.notifyData.lastId + 1,
                          weeklyIndex: widget.weekIndex,
                          course: widget.course,
                          courseDetail: widget.courseDetail,
                        );
                        await NotificationUtils.scheduleCourseNotify(
                            context: context,
                            courseNotify: courseNotify,
                            day: NotificationUtils.getDay(widget.weekIndex),
                            androidResourceIcon: widget.androidResourceIcon);
                        widget.notifyData.lastId++;
                        widget.notifyData.data.add(courseNotify);
                        ApUtils.showToast(context,
                            ApLocalizations.of(context).courseNotifyHint);
                      } else {
                        await NotificationUtils.cancelCourseNotify(
                          id: courseNotify.id,
                        );
                        widget.notifyData.data.removeWhere((data) {
                          return data.id == courseNotify.id;
                        });
                        ApUtils.showToast(context,
                            ApLocalizations.of(context).cancelNotifySuccess);
                      }
                      widget.notifyData.save(widget.courseNotifySaveKey);
                      setState(() {});
                    }
                    if (widget.onNotifyClick != null)
                      widget.onNotifyClick(
                          courseNotify,
                          CourseNotifyState.values[(_state.index + 1) %
                              (CourseNotifyState.values.length)]);
                  },
                )
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.course.getInstructors()}',
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.course.date.startTime}-${widget.course.date.endTime}',
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

class CourseList extends StatelessWidget {
  final List<CourseDetail> courses;

  const CourseList({
    Key key,
    @required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        var course = courses[index];
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            title: Text(
              courses[index].title,
              style: TextStyle(
                height: 1.3,
                fontSize: 20.0,
              ),
            ),
            subtitle: Padding(
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
                                text:
                                    '${ApLocalizations.of(context).studentClass}：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${course.className}\n'),
                          ],
                          TextSpan(
                              text:
                                  '${ApLocalizations.of(context).courseDialogProfessor ?? ''}：',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${course.getInstructors()}\n'),
                          if (course.location != null) ...[
                            TextSpan(
                                text:
                                    '${ApLocalizations.of(context).courseDialogLocation ?? ''}：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${course.location.toString() ?? ''}\n'),
                          ],
                          TextSpan(
                            text:
                                '${ApLocalizations.of(context).courseDialogTime}：',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${course.times ?? ''}'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (course.required != null)
                          Text(
                            '${course.required}',
                            style: TextStyle(
                              color: ApTheme.of(context).blueAccent,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        SizedBox(height: 16.0),
                        if (course.units != null)
                          SelectableText.rich(
                            TextSpan(
                              style: TextStyle(
                                color: ApTheme.of(context).grey,
                                fontSize: 16.0,
                              ),
                              children: [
                                TextSpan(
                                    text:
                                        '${ApLocalizations.of(context).units}：',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: '${course.units}'),
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
                                  text:
                                      '${ApLocalizations.of(context).courseHours}：',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '${course.hours}'),
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
          ),
        );
      },
      itemCount: courses?.length ?? 0,
    );
  }
}

class CourseBorder extends StatelessWidget {
  final int weekIndex;
  final Course course;
  final double height;
  final double width;
  final Border border;
  final Color color;
  final Function(int weekIndex, Course course) onPressed;

  const CourseBorder({
    Key key,
    this.weekIndex,
    this.course,
    this.height = _courseHeight,
    this.width,
    this.border,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: course != null ? 2.0 : 0.0,
        right: course != null ? 2.0 : 0.0,
      ),
      height: height,
      width: width ?? double.maxFinite,
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
                  this.onPressed(weekIndex, course);
                },
                radius: 6.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  child: Center(
                    child: AutoSizeText(
                      course.title ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
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

extension DateTimeExtension on DateTime {
  DateTime weekTime(int weekIndex) {
    int dayOfWeek = (weekIndex + 1) % 7;
    var now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    ).add(
      Duration(
        days: dayOfWeek - weekday,
        hours: (Platform.isAndroid ? 8 : 0),
      ),
    );
  }
}
