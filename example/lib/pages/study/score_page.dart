import 'package:ap_common/models/score_data.dart';
import 'package:ap_common/models/semester_data.dart';
import 'package:ap_common/scaffold/score_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../res/assets.dart';

class ScorePage extends StatefulWidget {
  static const String routerName = '/score';

  @override
  ScorePageState createState() => ScorePageState();
}

class ScorePageState extends State<ScorePage> {
  ApLocalizations ap;

  ScoreState state = ScoreState.loading;

  SemesterData semesterData;

  ScoreData scoreData;

  bool isOffline = false;

  String customStateHint = '';

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
    return ScoreScaffold(
      state: state,
      scoreData: scoreData,
      customHint: isOffline ? ap.offlineScore : '',
      customStateHint: customStateHint,
      semesterData: semesterData,
      onSelect: (index) {
        this.semesterData.currentIndex = index;
        _getSemesterScore();
      },
      onRefresh: () async {
        await _getSemesterScore();
        return null;
      },
      onSearchButtonClick: () {
//        key.currentState.pickSemester();
      },
      details: [
        '${ap.conductScore}：${scoreData?.detail?.conduct ?? ''}',
        '${ap.average}：${scoreData?.detail?.average ?? ''}',
        '${ap.classRank}：${scoreData?.detail?.classRank ?? ''}',
        '${ap.departmentRank}：${scoreData?.detail?.departmentRank ?? ''}',
      ],
    );
  }

  void _getSemester() async {
    String rawString = await rootBundle.loadString(FileAssets.semesters);
    semesterData = SemesterData.fromRawJson(rawString);
    var i = 0;
    semesterData.data.forEach((option) {
      if (option.text == semesterData.defaultSemester.text) semesterData.currentIndex = i;
      i++;
    });
    _getSemesterScore();
  }

  _getSemesterScore() async {
    String rawString = await rootBundle.loadString(FileAssets.scores);
    scoreData = ScoreData.fromRawJson(rawString);
    if (mounted)
      setState(() {
        if (scoreData == null) {
          state = ScoreState.empty;
        } else {
          state = ScoreState.finish;
        }
      });
  }

//  Future<bool> _loadOfflineScoreData() async {
//    scoreData = ScoreData.load(selectSemester.cacheSaveTag);
//    if (mounted) {
//      setState(() {
//        isOffline = true;
//        if (scoreData == null)
//          state = ScoreState.offlineEmpty;
//        else {
//          state = ScoreState.finish;
//        }
//      });
//    }
//    return scoreData == null;
//  }
}
