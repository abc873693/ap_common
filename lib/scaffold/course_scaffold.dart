import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/resources/ap_colors.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/default_dialog.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/item_picker.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

export 'package:ap_common/models/course_data.dart';

enum CourseState { loading, finish, error, empty, offlineEmpty }
enum _ContentStyle { list, table }

const _courseHeight = 55.0;

class CourseScaffold extends StatefulWidget {
  final CourseState state;
  final CourseData courseData;
  final List<String> years;
  final int yearIndex;
  final List<String> semesters;
  final int semesterIndex;
  final Function(int index) onSelect;
  final Function() onRefresh;
  final List<Widget> actions;
  final bool isShowSearchButton;
  final String customHint;

  const CourseScaffold({
    Key key,
    this.state = CourseState.loading,
    this.courseData,
    this.customHint,
    this.years,
    this.yearIndex,
    this.semesters,
    this.semesterIndex,
    this.onSelect,
    this.onRefresh,
    this.isShowSearchButton = true,
    this.actions,
  }) : super(key: key);

  @override
  CourseScaffoldState createState() => CourseScaffoldState();
}

class CourseScaffoldState extends State<CourseScaffold> {
  ApLocalizations app;

  _ContentStyle _contentStyle = _ContentStyle.table;

  int get base => (widget.courseData.hasHoliday) ? 8 : 6;

  double get childAspectRatio => (widget.courseData.hasHoliday) ? 1.1 : 1.5;

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
        title: Text(app.course),
        backgroundColor: ApTheme.of(context).blue,
        actions: widget.actions,
      ),
      body: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 8.0),
          if (widget.years != null || widget.semesters != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//              ItemPicker(
//                onSelected: (int index) {},
//                items: widget.years,
//                currentIndex: widget.yearIndex,
//              ),
                ItemPicker(
                  dialogTitle: app.picksSemester,
                  onSelected: widget.onSelect,
                  items: widget.semesters,
                  currentIndex: widget.semesterIndex,
                ),
              ],
            ),
          if (widget.customHint != null)
            Text(
              widget.customHint,
              style: TextStyle(color: ApTheme.of(context).grey),
            ),
          if (_contentStyle == _ContentStyle.table)
            Text(
              app.courseClickHint,
              style: TextStyle(color: ApTheme.of(context).grey),
            ),
          SizedBox(height: 4.0),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: widget.isShowSearchButton
          ? FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: _pickSemester,
            )
          : null,
      bottomNavigationBar: BottomAppBar(
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

  Widget _body() {
    switch (widget.state) {
      case CourseState.loading:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case CourseState.empty:
      case CourseState.error:
        return FlatButton(
          onPressed: () {
            if (widget.state == CourseState.error)
              widget.onRefresh();
            else
              _pickSemester();
          },
          child: HintContent(
            icon: ApIcon.classIcon,
            content: widget.state == CourseState.error
                ? app.clickToRetry
                : app.courseEmpty,
          ),
        );
      case CourseState.offlineEmpty:
        return HintContent(
          icon: ApIcon.classIcon,
          content: app.noOfflineData,
        );
      default:
        if (_contentStyle == _ContentStyle.list) {
          return CourseList(
            courses: widget.courseData.courses,
          );
        } else {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
//                border: Border.all(
//                  color: Colors.grey,
//                  width: 1.5,
//                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: renderCourseTable(),
              ),
            ),
          );
        }
    }
  }

  BorderSide get _innerBorderSide => BorderSide(
        width: 0.5,
        color: ApTheme.of(context).courseBorder,
      );

  BorderSide get _borderSide => BorderSide(
        width: 0.5,
        color: Colors.grey,
      );

  List<Widget> renderCourseTable() {
    DateTime start = DateTime.now();
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
    var columns = <Column>[Column(children: [])];
    columns[0].children.add(
          _weekBorder(''),
        );
    for (var i = 0; i < maxTimeCode; i++) {
      var text = timeCodes[i].replaceAll(' ', '');
      if (!widget.courseData.hasHoliday) {
        text = text.replaceAll('第', '');
        text = text.replaceAll('節', '');
      }
      columns[0].children.add(
            _timeCodeBorder(text),
          );
    }
    for (int i = 0; i < weeks.length; i++) {
      final List<CourseBorder> courseBorders = [];
      for (var j = 0; j < maxTimeCode; j++) courseBorders.add(CourseBorder());
      var courses = widget.courseData.courseTables.getCourseList(weeks[i]);
      if (courses != null) {
        for (var course in courses) {
          for (int j = 0; j < maxTimeCode; j++) {
            if (timeCodes[j] == course.date.section) {
              final index = widget.courseData.findCourseDetail(course);
              courseBorders[j] = CourseBorder(
                course: course,
                color: (index == -1)
                    ? null
                    : widget.courseData.courses[index].color,
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
    DateTime end = DateTime.now();
    print(
        'ui parse time = ${end.millisecondsSinceEpoch - start.millisecondsSinceEpoch} ms');
    return [
      columns[0],
      for (var i = 1; i < columns.length; i++)
        Expanded(
          child: columns[i],
        )
    ];
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
        width: 35.0,
        child: Text(
          text ?? '',
          style: TextStyle(
            color: ApTheme.of(context).blueText,
            fontSize: 14.0,
          ),
        ),
      );

  void _pickSemester() => showDialog(
        context: context,
        builder: (_) => SimpleOptionDialog(
          title: app.picksSemester,
          items: widget.semesters,
          index: widget.semesterIndex,
          onSelected: widget.onSelect,
        ),
      );
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
                          TextSpan(
                              text:
                                  '${ApLocalizations.of(context).courseDialogLocation ?? ''}：',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  '${course.location?.building ?? ''}${course.location?.room ?? ''}\n'),
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
  final Course course;
  final double height;
  final double width;
  final Border border;
  final Color color;

  const CourseBorder({
    Key key,
    this.course,
    this.height = _courseHeight,
    this.width,
    this.border,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        decoration: BoxDecoration(
          color: course != null ? color : null,
          borderRadius: BorderRadius.all(
            Radius.circular(course != null ? 6.0 : 0.0),
          ),
        ),
        child: (course == null)
            ? null
            : InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => DefaultDialog(
                      title: ApLocalizations.of(context).courseDialogTitle,
                      actionText: ApLocalizations.of(context).iKnow,
                      actionFunction: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      contentWidget: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: ApTheme.of(context).grey,
                              height: 1.3,
                              fontSize: 16.0),
                          children: [
                            TextSpan(
                              text:
                                  '${ApLocalizations.of(context).courseDialogName}：',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: '${course.title}\n'),
                            TextSpan(
                                text:
                                    '${ApLocalizations.of(context).courseDialogProfessor}：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${course.getInstructors()}\n'),
                            TextSpan(
                                text:
                                    '${ApLocalizations.of(context).courseDialogLocation}：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    '${course.location.building ?? ''}${course.location.room ?? ''}\n'),
                            TextSpan(
                                text:
                                    '${ApLocalizations.of(context).courseDialogTime}：',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    '${course.date.startTime}-${course.date.endTime}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  alignment: Alignment.center,
                  child: Text(
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
    );
  }
}
