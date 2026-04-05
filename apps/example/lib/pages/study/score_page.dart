import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScorePage extends StatefulWidget {
  static const String routerName = '/score';

  @override
  ScorePageState createState() => ScorePageState();
}

class ScorePageState extends State<ScorePage> {
  ScoreState state = ScoreState.loading;

  SemesterData? semesterData;

  ScoreData? scoreData;

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
    return ScoreScaffold(
      state: state,
      scoreData: scoreData,
      customHint: isOffline ? context.ap.offlineScore : '',
      customStateHint: customStateHint,
      semesterData: semesterData,
      onSelect: (int index) {
        semesterData = semesterData!.copyWith(currentIndex: index);
        _getSemesterScore();
      },
      onRefresh: () async {
        await _getSemesterScore();
        return null;
      },
      onSearchButtonClick: () {
//        key.currentState.pickSemester();
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
    _getSemesterScore();
  }

  Future<void> _getSemesterScore() async {
    try {
      // Use GPA data for odd-indexed semesters to demo both types
      final bool useGpa = (semesterData?.currentIndex ?? 0).isOdd;
      final String assetPath =
          useGpa ? FileAssets.scoresGpa : FileAssets.scores;
      final String rawString = await rootBundle.loadString(assetPath);
      scoreData = ScoreData.fromRawJson(rawString);
      if (mounted) {
        setState(() {
          if (scoreData == null) {
            state = ScoreState.empty;
          } else {
            state = ScoreState.finish;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          state = ScoreState.error;
        });
      }
      rethrow;
    }
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
