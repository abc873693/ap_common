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

  final SemesterPickerController _pickerController =
      SemesterPickerController();

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
    return ScoreScaffold(
      state: state,
      scoreData: scoreData,
      customHint: isOffline ? context.ap.offlineScore : '',
      customStateHint: customStateHint,
      semesterData: semesterData,
      semesterPickerController: _pickerController,
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
      final Semester semester =
          semesterData!.data[semesterData!.currentIndex];
      // Simulate empty state for summer/winter session semesters
      final bool isEmpty = const <String>{'3', '4', '6', '7'}
          .contains(semester.value);
      if (isEmpty) {
        if (mounted) {
          setState(() {
            scoreData = null;
            state = ScoreState.empty;
            _pickerController.markSemesterEmpty(semester);
          });
        }
        return;
      }
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
            _pickerController.markSemesterEmpty(semester);
          } else {
            state = ScoreState.finish;
            _pickerController.markSemesterHasData(semester);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        final Semester semester =
            semesterData!.data[semesterData!.currentIndex];
        _pickerController.markSemesterHasData(semester);
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
