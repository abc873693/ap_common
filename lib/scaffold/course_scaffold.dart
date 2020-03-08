import 'package:ap_common/models/course_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/default_dialog.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/item_picker.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:flutter/material.dart';

export 'package:ap_common/models/course_data.dart';

enum CourseState { loading, finish, error, empty, offlineEmpty }
enum _ContentStyle { card, table }

class CourseScaffold extends StatefulWidget {
  final CourseState state;
  final CourseData courseData;
  final List<String> years;
  final int yearIndex;
  final List<String> semesters;
  final int semesterIndex;
  final bool isOffline;
  final Function(int index) onSelect;
  final Function() onRefresh;

  const CourseScaffold({
    Key key,
    this.state = CourseState.loading,
    this.courseData,
    this.isOffline = false,
    this.years,
    this.yearIndex,
    this.semesters,
    this.semesterIndex,
    this.onSelect,
    this.onRefresh,
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
      ),
      body: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 8.0),
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
          if (widget.isOffline)
            Text(
              app.offlineCourse,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: _pickSemester,
      ),
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
                setState(() {
                  _contentStyle = _ContentStyle.table;
                });
              },
            ),
            IconButton(
              iconSize: _contentStyle == _ContentStyle.card ? 24 : 20,
              color: _contentStyle == _ContentStyle.card
                  ? ApTheme.of(context).yellow
                  : ApTheme.of(context).grey,
              icon: Icon(Icons.format_list_bulleted),
              onPressed: () {
                setState(() {
                  _contentStyle = _ContentStyle.card;
                });
              },
            ),
            Container(height: 0),
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
        if (_contentStyle == _ContentStyle.card) {
          return ListView.builder(
            itemBuilder: (_, index) {
              var course = widget.courseData.courses[index];
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
                    widget.courseData.courses[index].title,
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
                                TextSpan(
                                    text: '${app.studentClass}：',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: '${course.className}\n'),
                                TextSpan(
                                    text: '${app.courseDialogProfessor}：',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: '${course.getInstructors()}\n'),
                                TextSpan(
                                    text: '${app.courseDialogLocation}：',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        '${course.location.building}${course.location.room}\n'),
                                TextSpan(
                                  text: '${app.courseDialogTime}：',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: '${course.times}'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${course.required}',
                                style: TextStyle(
                                  color: ApTheme.of(context).blueAccent,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16.0),
                              SelectableText.rich(
                                TextSpan(
                                  style: TextStyle(
                                    color: ApTheme.of(context).grey,
                                    fontSize: 16.0,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: '${app.units}：',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: '${course.units}'),
                                  ],
                                ),
                              ),
                              SelectableText.rich(
                                TextSpan(
                                  style: TextStyle(
                                    color: ApTheme.of(context).grey,
                                    fontSize: 16.0,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: '${app.courseHours}：',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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
            itemCount: widget.courseData?.courses?.length ?? 0,
          );
        } else {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: Table(
                defaultColumnWidth: FractionColumnWidth(1.0 / base),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.symmetric(
                  inside: BorderSide(
                    color: Colors.grey,
                    width: 0,
                  ),
                ),
                children: renderCourseList(),
              ),
            ),
          );
        }
    }
  }

  List<TableRow> renderCourseList() {
    List<String> weeks = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];
    var list = <TableRow>[
      TableRow(children: [_titleBorder('')])
    ];
    for (var week in app.weekdaysCourse.sublist(0, 5))
      list[0].children.add(_titleBorder(week));
    if (widget.courseData.hasHoliday) {
      list[0].children.add(_titleBorder(app.weekdaysCourse[5]));
      list[0].children.add(_titleBorder(app.weekdaysCourse[6]));
      weeks.add('Saturday');
      weeks.add('Sunday');
    }
    int maxTimeCode = widget.courseData.courseTables.getMaxTimeCode(weeks);
    int i = 0;
    for (String text in widget.courseData.courseTables.timeCode) {
      i++;
      if (maxTimeCode <= 11 && i > maxTimeCode) continue;
      text = text.replaceAll(' ', '');
      if (base == 8) {
        text = text.replaceAll('第', '');
        text = text.replaceAll('節', '');
      }
      list.add(TableRow(children: []));
      list[i].children.add(_titleBorder(text));
      for (var j = 0; j < base - 1; j++) list[i].children.add(_titleBorder(''));
    }
    var timeCodes = widget.courseData.courseTables.timeCode;
    for (int i = 0; i < weeks.length; i++) {
      if (widget.courseData.courseTables.getCourseList(weeks[i]) != null)
        for (var data
            in widget.courseData.courseTables.getCourseList(weeks[i])) {
          for (int j = 0; j < timeCodes.length; j++) {
            if (timeCodes[j] == data.date.section) {
              if (i % base != 0) list[j + 1].children[i] = _courseBorder(data);
            }
          }
        }
    }
    return list;
  }

  Widget _titleBorder(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.center,
      child: Text(
        text ?? '',
        style: TextStyle(color: ApTheme.of(context).blueText, fontSize: 14.0),
      ),
    );
  }

  Widget _courseBorder(Course course) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => DefaultDialog(
            title: app.courseDialogTitle,
            actionText: app.iKnow,
            actionFunction: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
            contentWidget: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: ApTheme.of(context).grey,
                      height: 1.3,
                      fontSize: 16.0),
                  children: [
                    TextSpan(
                        text: '${app.courseDialogName}：',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${course.title}\n'),
                    TextSpan(
                        text: '${app.courseDialogProfessor}：',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${course.getInstructors()}\n'),
                    TextSpan(
                        text: '${app.courseDialogLocation}：',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            '${course.location.building}${course.location.room}\n'),
                    TextSpan(
                        text: '${app.courseDialogTime}：',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            '${course.date.startTime}-${course.date.endTime}'),
                  ]),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        alignment: Alignment.center,
        child: Text(
          (course.title[0] + course.title[1]) ?? '',
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _pickSemester() {
    showDialog(
      context: context,
      builder: (_) => SimpleOptionDialog(
        title: app.picksSemester,
        items: widget.semesters,
        index: widget.semesterIndex,
        onSelected: widget.onSelect,
      ),
    );
  }
}
