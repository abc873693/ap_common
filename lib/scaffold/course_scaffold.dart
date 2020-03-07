import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/default_dialog.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/item_picker.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

class CourseData {
  List<CourseDetail> courses;
  CourseTables courseTables;

  CourseData({this.courses, this.courseTables});

  factory CourseData.fromRawJson(String str) =>
      CourseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        courses: json["courses"] == null
            ? null
            : List<CourseDetail>.from(
                json["courses"].map((x) => CourseDetail.fromJson(x))),
        courseTables: json["coursetable"] == null
            ? null
            : CourseTables.fromJson(json["coursetable"]),
      );

  Map<String, dynamic> toJson() => {
        "courses": courses == null
            ? null
            : List<dynamic>.from(courses.map((x) => x.toJson())),
        "coursetable": courseTables == null ? null : courseTables.toJson(),
      };

  bool get hasHoliday {
    return ((courseTables.saturday?.isNotEmpty) ?? false) ||
        ((courseTables.sunday?.isNotEmpty) ?? false);
  }
}

class CourseDetail {
  String code;
  String title;
  String className;
  String group;
  String units;
  String hours;
  String required;
  String at;
  String times;
  Location location;
  List<String> instructors;

  CourseDetail({
    this.code,
    this.title,
    this.className,
    this.group,
    this.units,
    this.hours,
    this.required,
    this.at,
    this.times,
    this.location,
    this.instructors,
  });

  factory CourseDetail.fromRawJson(String str) =>
      CourseDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseDetail.fromJson(Map<String, dynamic> json) => CourseDetail(
        code: json["code"] == null ? null : json["code"],
        title: json["title"] == null ? null : json["title"],
        className: json["className"] == null ? null : json["className"],
        group: json["group"] == null ? null : json["group"],
        units: json["units"] == null ? null : json["units"],
        hours: json["hours"] == null ? null : json["hours"],
        required: json["required"] == null ? null : json["required"],
        at: json["at"] == null ? null : json["at"],
        times: json["times"] == null ? null : json["times"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        instructors: json["instructors"] == null
            ? null
            : List<String>.from(json["instructors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "title": title == null ? null : title,
        "className": className == null ? null : className,
        "group": group == null ? null : group,
        "units": units == null ? null : units,
        "hours": hours == null ? null : hours,
        "required": required == null ? null : required,
        "at": at == null ? null : at,
        "times": times == null ? null : times,
        "location": location == null ? null : location.toJson(),
        "instructors": instructors == null
            ? null
            : List<dynamic>.from(instructors.map((x) => x)),
      };

  String getInstructors() {
    String text = "";
    if (instructors.length > 0) {
      text += instructors[0];
      for (var i = 1; i < instructors.length; i++) text += ",${instructors[i]}";
    }
    return text;
  }
}

class CourseTables {
  List<Course> monday;
  List<Course> tuesday;
  List<Course> wednesday;
  List<Course> thursday;
  List<Course> friday;
  List<Course> saturday;
  List<Course> sunday;
  List<String> timeCode;

  CourseTables({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.timeCode,
  });

  CourseTables.fromJson(Map<String, dynamic> json) {
    if (json['Monday'] != null) {
      monday = List<Course>();
      json['Monday'].forEach((v) {
        monday.add(Course.fromJson(v));
      });
    }
    if (json['Tuesday'] != null) {
      tuesday = List<Course>();
      json['Tuesday'].forEach((v) {
        tuesday.add(Course.fromJson(v));
      });
    }
    if (json['Wednesday'] != null) {
      wednesday = List<Course>();
      json['Wednesday'].forEach((v) {
        wednesday.add(Course.fromJson(v));
      });
    }
    if (json['Thursday'] != null) {
      thursday = List<Course>();
      json['Thursday'].forEach((v) {
        thursday.add(Course.fromJson(v));
      });
    }
    if (json['Friday'] != null) {
      friday = List<Course>();
      json['Friday'].forEach((v) {
        friday.add(Course.fromJson(v));
      });
    }
    if (json['Saturday'] != null) {
      saturday = List<Course>();
      json['Saturday'].forEach((v) {
        saturday.add(Course.fromJson(v));
      });
    }
    if (json['Sunday'] != null) {
      sunday = List<Course>();
      json['Sunday'].forEach((v) {
        sunday.add(Course.fromJson(v));
      });
    }
    timeCode = new List<String>.from(json["timeCodes"].map((x) => x));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.monday != null) {
      data['Monday'] = this.monday.map((v) => v.toJson()).toList();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday.map((v) => v.toJson()).toList();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday.map((v) => v.toJson()).toList();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday.map((v) => v.toJson()).toList();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday.map((v) => v.toJson()).toList();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday.map((v) => v.toJson()).toList();
    }
    if (this.sunday != null) {
      data['Sunday'] = this.sunday.map((v) => v.toJson()).toList();
    }
    data['timeCodes'] = this.timeCode;
    return data;
  }

  List<Course> getCourseList(String weeks) {
    switch (weeks) {
      case "Sunday":
        return sunday;
      case "Monday":
        return monday;
      case "Tuesday":
        return tuesday;
      case "Wednesday":
        return wednesday;
      case "Thursday":
        return thursday;
      case "Friday":
        return friday;
      case "Saturday":
        return saturday;
      case "Sunday":
        return sunday;
      default:
        return [];
    }
  }

  int getMaxTimeCode(List<String> weeks) {
    int maxTimeCodes = 10;
    for (int i = 0; i < weeks.length; i++) {
      if (getCourseList(weeks[i]) != null)
        for (Course data in getCourseList(weeks[i])) {
          for (int j = 0; j < timeCode.length; j++) {
            if (timeCode[j] == data.date.section) {
              if ((j + 1) > maxTimeCodes) maxTimeCodes = (j + 1);
            }
          }
        }
    }
    return maxTimeCodes;
  }
}

class Course {
  String title;
  Date date;
  Location location;
  List<String> instructors;

  Course({this.title, this.date, this.location, this.instructors});

  Course.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    instructors = json['instructors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['instructors'] = this.instructors;
    return data;
  }

  String getInstructors() {
    String text = "";
    if (instructors.length > 0) {
      text += instructors[0];
      for (var i = 1; i < instructors.length; i++) text += ",${instructors[i]}";
    }
    return text;
  }
}

class Date {
  String startTime;
  String endTime;
  String weekday;
  String section;

  Date({this.startTime, this.endTime, this.weekday, this.section});

  Date.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'] ?? '';
    endTime = json['endTime'] ?? '';
    weekday = json['weekday'] ?? '';
    section = json['section'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['weekday'] = this.weekday;
    data['section'] = this.section;
    return data;
  }
}

class Location {
  String building;
  String room;

  Location({this.building, this.room});

  Location.fromJson(Map<String, dynamic> json) {
    building = json['building'] ?? '';
    room = json['room'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['building'] = this.building;
    data['room'] = this.room;
    return data;
  }
}

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
