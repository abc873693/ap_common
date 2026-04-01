import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// A ready-to-use score page that handles semester loading and state management
/// internally using [DataState].
///
/// ```dart
/// ApScorePage(
///   onLoadSemesters: () => api.getSemesters(),
///   onLoadScore: (semester) => api.getScoreData(semester),
///   detailBuilder: (scoreData) => [
///     '操行成績：${scoreData?.detail.conduct ?? ""}',
///     '平均：${scoreData?.detail.average ?? ""}',
///   ],
/// )
/// ```
class ApScorePage extends StatefulWidget {
  const ApScorePage({
    super.key,
    required this.onLoadSemesters,
    required this.onLoadScore,
    this.title,
    this.detailBuilder,
    this.middleTitle,
    this.finalTitle,
    this.onScoreSelect,
    this.middleScoreBuilder,
    this.finalScoreBuilder,
    this.bottom,
  });

  /// Load the semester list. Called once on init.
  final Future<SemesterData> Function() onLoadSemesters;

  /// Load score data for the given [Semester].
  final Future<ScoreData?> Function(Semester semester) onLoadScore;

  /// Build detail strings from loaded score data.
  final List<String> Function(ScoreData? scoreData)? detailBuilder;

  final String? title;
  final String? middleTitle;
  final String? finalTitle;
  final Function(int index)? onScoreSelect;
  final Widget Function(int index)? middleScoreBuilder;
  final Widget Function(int index)? finalScoreBuilder;
  final Widget? bottom;

  @override
  State<ApScorePage> createState() => _ApScorePageState();
}

class _ApScorePageState extends State<ApScorePage> {
  DataState<ScoreData> _state = const DataLoading<ScoreData>();
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
        setState(() => _state = const DataError<ScoreData>());
      }
    }
  }

  Future<void> _loadScore() async {
    if (_semesterData == null) return;
    setState(() => _state = const DataLoading<ScoreData>());
    try {
      final Semester semester =
          _semesterData!.data[_semesterData!.currentIndex];
      final ScoreData? scoreData = await widget.onLoadScore(semester);
      if (mounted) {
        setState(() {
          if (scoreData == null) {
            _state = const DataEmpty<ScoreData>();
          } else {
            _state = DataLoaded<ScoreData>(scoreData);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _state = DataError<ScoreData>(hint: e.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScoreData? scoreData = _state.dataOrNull;

    return ScoreScaffold(
      state: _state.when(
        loading: () => ScoreState.loading,
        loaded: (_, __) => ScoreState.finish,
        error: (_) => ScoreState.error,
        empty: (_) => ScoreState.empty,
      ),
      scoreData: scoreData,
      title: widget.title,
      customHint: _state is DataLoaded<ScoreData>
          ? (_state as DataLoaded<ScoreData>).hint
          : null,
      customStateHint: _state is DataError<ScoreData>
          ? (_state as DataError<ScoreData>).hint
          : null,
      semesterData: _semesterData,
      middleTitle: widget.middleTitle,
      finalTitle: widget.finalTitle,
      onScoreSelect: widget.onScoreSelect,
      middleScoreBuilder: widget.middleScoreBuilder,
      finalScoreBuilder: widget.finalScoreBuilder,
      bottom: widget.bottom,
      details: widget.detailBuilder?.call(scoreData),
      onSelect: (int index) {
        _semesterData = _semesterData!.copyWith(currentIndex: index);
        _loadScore();
      },
      onRefresh: () async {
        await _loadScore();
        return null;
      },
    );
  }
}
