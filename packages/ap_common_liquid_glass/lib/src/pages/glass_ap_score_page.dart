import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/scaffold/glass_score_scaffold.dart';
import 'package:flutter/material.dart';

/// A ready-to-use glass score page that handles semester
/// loading and state management internally.
///
/// This is the glass-enhanced equivalent of [ApScorePage].
class GlassApScorePage extends StatefulWidget {
  const GlassApScorePage({
    super.key,
    required this.onLoadSemesters,
    required this.onLoadScore,
    this.title,
    this.middleTitle,
    this.finalTitle,
    this.middleScoreBuilder,
    this.finalScoreBuilder,
    this.detailBuilder,
    this.isShowSearchButton = false,
  });

  final Future<SemesterData> Function()
      onLoadSemesters;
  final Future<ScoreData?> Function(
    Semester semester,
  ) onLoadScore;
  final String? title;
  final String? middleTitle;
  final String? finalTitle;
  final Widget Function(int index)?
      middleScoreBuilder;
  final Widget Function(int index)?
      finalScoreBuilder;
  final List<String> Function(ScoreData?)?
      detailBuilder;
  final bool isShowSearchButton;

  @override
  State<GlassApScorePage> createState() =>
      _GlassApScorePageState();
}

class _GlassApScorePageState
    extends State<GlassApScorePage> {
  DataState<ScoreData?> _state =
      const DataLoading<ScoreData?>();
  SemesterData? _semesterData;

  @override
  void initState() {
    super.initState();
    _loadSemesters();
  }

  Future<void> _loadSemesters() async {
    try {
      _semesterData = await widget.onLoadSemesters();
      _loadScore();
    } catch (_) {
      if (mounted) {
        setState(
          () => _state =
              const DataError<ScoreData?>(),
        );
      }
    }
  }

  Future<void> _loadScore() async {
    if (_semesterData == null) return;
    setState(
      () => _state =
          const DataLoading<ScoreData?>(),
    );
    try {
      final Semester semester = _semesterData!
          .data[_semesterData!.currentIndex];
      final ScoreData? scoreData =
          await widget.onLoadScore(semester);
      if (mounted) {
        setState(() {
          if (scoreData == null ||
              scoreData.scores.isEmpty) {
            _state = const DataEmpty<ScoreData?>();
          } else {
            _state =
                DataLoaded<ScoreData?>(scoreData);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(
          () => _state = DataError<ScoreData?>(
            hint: e.toString(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScoreScaffold(
      state: _state.when(
        loading: () => ScoreState.loading,
        loaded: (_, __) => ScoreState.finish,
        error: (_) => ScoreState.error,
        empty: (_) => ScoreState.empty,
      ),
      scoreData: _state.dataOrNull,
      onRefresh: _loadScore,
      title: widget.title,
      semesterData: _semesterData,
      middleTitle: widget.middleTitle,
      finalTitle: widget.finalTitle,
      middleScoreBuilder: widget.middleScoreBuilder,
      finalScoreBuilder: widget.finalScoreBuilder,
      isShowSearchButton:
          widget.isShowSearchButton,
      onSelect: (int index) {
        _semesterData = _semesterData!
            .copyWith(currentIndex: index);
        _loadScore();
      },
    );
  }
}
