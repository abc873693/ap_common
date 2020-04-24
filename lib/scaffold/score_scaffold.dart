import 'package:ap_common/models/score_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:ap_common/widgets/item_picker.dart';
import 'package:ap_common/widgets/option_dialog.dart';
import 'package:flutter/material.dart';

enum ScoreState { loading, finish, error, empty, offlineEmpty }

class ScoreScaffold extends StatefulWidget {
  static const String routerName = '/score';

  final ScoreState state;
  final ScoreData scoreData;
  final List<String> semesters;
  final int semesterIndex;
  final Function(int index) onSelect;
  final Function() onRefresh;
  final Widget itemPicker;
  final String middleTitle;
  final String finalTitle;
  final Widget Function(int index) middleScoreBuilder;
  final Widget Function(int index) finalScoreBuilder;
  final List<String> details;

  final bool isShowSearchButton;

  final String customHint;

  const ScoreScaffold({
    Key key,
    @required this.state,
    @required this.scoreData,
    @required this.onRefresh,
    this.itemPicker,
    this.semesters,
    this.semesterIndex,
    this.onSelect,
    this.middleTitle,
    this.finalTitle,
    this.middleScoreBuilder,
    this.finalScoreBuilder,
    this.customHint,
    this.isShowSearchButton = true,
    this.details,
  }) : super(key: key);

  @override
  ScoreScaffoldState createState() => ScoreScaffoldState();
}

class ScoreScaffoldState extends State<ScoreScaffold> {
  ApLocalizations app;

  TextStyle get _textBlueStyle =>
      TextStyle(color: ApTheme.of(context).blueText, fontSize: 16.0);

  TextStyle get _textStyle => TextStyle(fontSize: 15.0);

  BoxDecoration get _boxDecoration => BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
        border: Border.all(color: Colors.grey, width: 1.5),
      );

  TableBorder get _tableBorder => TableBorder.symmetric(
        inside: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      );

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
        title: Text(app.score),
        backgroundColor: ApTheme.of(context).blue,
      ),
      floatingActionButton: widget.isShowSearchButton
          ? FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: _pickSemester,
            )
          : null,
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 8.0),
            if (widget.semesters != null && widget.itemPicker == null)
              ItemPicker(
                dialogTitle: app.picksSemester,
                onSelected: widget.onSelect,
                items: widget.semesters,
                currentIndex: widget.semesterIndex,
              ),
            if (widget.itemPicker != null) widget.itemPicker,
            if (widget.customHint != null)
              Text(
                widget.customHint,
                style: TextStyle(color: ApTheme.of(context).grey),
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
    );
  }

  Widget _body() {
    switch (widget.state) {
      case ScoreState.loading:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case ScoreState.error:
      case ScoreState.empty:
        return FlatButton(
          onPressed: () {
            if (widget.itemPicker == null && widget.state == ScoreState.empty)
              _pickSemester();
            else
              widget.onRefresh();
          },
          child: HintContent(
            icon: ApIcon.assignment,
            content: widget.state == ScoreState.error
                ? app.clickToRetry
                : app.scoreEmpty,
          ),
        );
      case ScoreState.offlineEmpty:
        return HintContent(
          icon: ApIcon.classIcon,
          content: app.noOfflineData,
        );
      default:
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  decoration: _boxDecoration,
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(2.5),
                      1: FlexColumnWidth(1.0),
                      2: FlexColumnWidth(1.0),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: _tableBorder,
                    children: [
                      TableRow(
                        children: <Widget>[
                          ScoreTextBorder(
                            text: app.subject,
                            style: _textBlueStyle,
                          ),
                          ScoreTextBorder(
                            text: widget.middleTitle ?? app.midtermScore,
                            style: _textBlueStyle,
                          ),
                          ScoreTextBorder(
                            text: widget.finalTitle ?? app.finalScore,
                            style: _textBlueStyle,
                          ),
                        ],
                      ),
                      for (var i = 0; i < widget.scoreData.scores.length; i++)
                        TableRow(
                          children: <Widget>[
                            ScoreTextBorder(
                              text: widget.scoreData.scores[i].title,
                              style: _textStyle,
                            ),
                            if (widget.middleScoreBuilder == null)
                              ScoreTextBorder(
                                text: widget.scoreData.scores[i].middleScore,
                                style: _textStyle,
                              ),
                            if (widget.middleScoreBuilder != null)
                              widget.middleScoreBuilder(i),
                            if (widget.finalScoreBuilder == null)
                              ScoreTextBorder(
                                text: widget.scoreData.scores[i].finalScore,
                                style: _textStyle,
                              ),
                            if (widget.finalScoreBuilder != null)
                              widget.finalScoreBuilder(i)
                          ],
                        )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                if (widget.details != null && widget.details.length != 0)
                  Container(
                    decoration: _boxDecoration,
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(1.0),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: _tableBorder,
                      children: [
                        for (var text in widget.details)
                          TableRow(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(2.0),
                                alignment: Alignment.center,
                                child: SelectableText(
                                  text ?? '',
                                  textAlign: TextAlign.center,
                                  style: _textBlueStyle,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
    }
  }

  void _pickSemester() {
    if (widget.semesters != null)
      showDialog(
        context: context,
        builder: (_) => SimpleOptionDialog(
          title: app.picksSemester,
          items: widget.semesters,
          index: widget.semesterIndex,
          onSelected: widget.onSelect,
        ),
      );
    else
      throw 'semesters can\'t null';
  }
}

class ScoreTextBorder extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ScoreTextBorder({
    Key key,
    @required this.text,
    @required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      alignment: Alignment.center,
      child: SelectableText(
        text ?? '',
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}
