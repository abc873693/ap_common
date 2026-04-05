import 'dart:math';

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum ScoreState { loading, finish, error, empty, offlineEmpty, custom }

class ScoreScaffold extends StatefulWidget {
  const ScoreScaffold({
    super.key,
    required this.state,
    required this.scoreData,
    required this.onRefresh,
    this.title,
    this.itemPicker,
    this.semesterData,
    this.onSelect,
    this.onSearchButtonClick,
    this.middleTitle,
    this.finalTitle,
    this.onScoreSelect,
    this.middleScoreBuilder,
    this.finalScoreBuilder,
    this.customHint,
    this.isShowSearchButton = false,
    this.bottom,
    this.customStateHint,
  });

  /// Creates a [ScoreScaffold] from a [DataState<ScoreData>].
  ///
  /// ```dart
  /// ScoreScaffold.fromDataState(
  ///   dataState: DataLoaded(scoreData),
  ///   onRefresh: () async => loadScore(),
  /// )
  /// ```
  ScoreScaffold.fromDataState({
    super.key,
    required DataState<ScoreData?> dataState,
    required this.onRefresh,
    this.title,
    this.itemPicker,
    this.semesterData,
    this.onSelect,
    this.onSearchButtonClick,
    this.middleTitle,
    this.finalTitle,
    this.onScoreSelect,
    this.middleScoreBuilder,
    this.finalScoreBuilder,
    this.isShowSearchButton = false,
    this.bottom,
  })  : state = dataState.when(
          loading: () => ScoreState.loading,
          loaded: (_, __) => ScoreState.finish,
          error: (_) => ScoreState.error,
          empty: (_) => ScoreState.empty,
        ),
        scoreData = dataState.dataOrNull,
        customHint =
            dataState is DataLoaded<ScoreData?> ? dataState.hint : null,
        customStateHint = dataState is DataError<ScoreData?>
            ? dataState.hint
            : dataState is DataEmpty<ScoreData?>
                ? dataState.hint
                : null;
  static const String routerName = '/score';

  final ScoreState state;
  final String? customStateHint;
  final String? title;
  final ScoreData? scoreData;
  final SemesterData? semesterData;
  final Function(int index)? onSelect;
  final Function()? onSearchButtonClick;
  final Function()? onRefresh;
  final Widget? itemPicker;
  final String? middleTitle;
  final String? finalTitle;
  final Function(int index)? onScoreSelect;
  final Widget Function(int index)? middleScoreBuilder;
  final Widget Function(int index)? finalScoreBuilder;

  final bool isShowSearchButton;

  final String? customHint;

  final Widget? bottom;

  @override
  ScoreScaffoldState createState() => ScoreScaffoldState();
}

class ScoreScaffoldState extends State<ScoreScaffold> {
  bool get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  bool _isAnalysisView = false;
  late ScrollController _scrollController;
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_showFab) {
          setState(() => _showFab = false);
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_showFab) {
          setState(() => _showFab = true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                widget.title ?? context.ap.score,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.itemPicker != null) ...<Widget>[
              const SizedBox(width: 12),
              widget.itemPicker!,
            ],
            if (widget.semesterData != null &&
                widget.itemPicker == null) ...<Widget>[
              const SizedBox(width: 12),
              SemesterPicker(
                semesterData: widget.semesterData!,
                currentIndex: widget.semesterData!.currentIndex,
                onSelect: (Semester semester, int index) {
                  widget.onSelect?.call(index);
                },
                featureTag: 'score',
              ),
            ],
          ],
        ),
        bottom: widget.bottom as PreferredSizeWidget?,
        actions: const <Widget>[],
      ),
      floatingActionButton: AnimatedScale(
        scale: _showFab ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            if (widget.state == ScoreState.finish &&
                widget.scoreData != null &&
                widget.scoreData!.scores.isNotEmpty &&
                !isLandscape)
              FloatingActionButton(
                key: const ValueKey<String>('switch_view_button'),
                heroTag: 'switch_view_button',
                onPressed: () {
                  setState(() => _isAnalysisView = !_isAnalysisView);
                },
                child: Icon(
                  _isAnalysisView
                      ? Icons.list_alt_rounded
                      : Icons.analytics_outlined,
                ),
              ),
            if (widget.isShowSearchButton) ...<Widget>[
              if (widget.state == ScoreState.finish &&
                  widget.scoreData != null &&
                  widget.scoreData!.scores.isNotEmpty &&
                  !isLandscape)
                const SizedBox(height: 8),
              FloatingActionButton(
                key: const ValueKey<String>('search_button'),
                heroTag: 'search_button',
                onPressed: () {
                  _pickSemester();
                  AnalyticsUtil.instance.logEvent('score_search_button_click');
                },
                child: const Icon(Icons.search),
              ),
            ],
          ],
        ),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                if (widget.customHint != null && widget.customHint!.isNotEmpty)
                  _buildHintBanner(),
                Expanded(child: _buildContent(context, colorScheme)),
              ],
            ),
          ),
          if (widget.state == ScoreState.finish && isLandscape) ...<Widget>[
            const SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: Material(
                elevation: 12.0,
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: ScoreListTab(
                    scoreData: widget.scoreData!,
                    onRefresh: widget.onRefresh,
                    middleTitle: widget.middleTitle,
                    finalTitle: widget.finalTitle,
                    onScoreSelect: widget.onScoreSelect,
                    middleScoreBuilder: widget.middleScoreBuilder,
                    finalScoreBuilder: widget.finalScoreBuilder,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHintBanner() {
    return HintBanner(text: widget.customHint!);
  }

  String get hintContent {
    switch (widget.state) {
      case ScoreState.error:
        return context.ap.clickToRetry;
      case ScoreState.empty:
        return context.ap.scoreEmpty;
      case ScoreState.offlineEmpty:
        return context.ap.noOfflineData;
      case ScoreState.custom:
        return widget.customStateHint ?? context.ap.unknownError;
      default:
        return '';
    }
  }

  Widget _buildContent(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    switch (widget.state) {
      case ScoreState.loading:
        return _buildLoadingState(colorScheme);
      case ScoreState.error:
        return _buildErrorState(
          colorScheme,
          context.ap.clickToRetry,
          Icons.error_outline_rounded,
        );
      case ScoreState.empty:
        return _buildErrorState(
          colorScheme,
          context.ap.scoreEmpty,
          Icons.assignment_outlined,
        );
      case ScoreState.offlineEmpty:
        return _buildErrorState(
          colorScheme,
          context.ap.noOfflineData,
          Icons.cloud_off_rounded,
        );
      case ScoreState.custom:
        return _buildErrorState(
          colorScheme,
          widget.customStateHint ?? context.ap.somethingError,
          Icons.warning_amber_rounded,
        );
      case ScoreState.finish:
        return ScoreContent(
          scoreData: widget.scoreData,
          onRefresh: widget.onRefresh,
          middleTitle: widget.middleTitle,
          finalTitle: widget.finalTitle,
          onScoreSelect: widget.onScoreSelect,
          middleScoreBuilder: widget.middleScoreBuilder,
          finalScoreBuilder: widget.finalScoreBuilder,
          isAnalysisView: isLandscape || _isAnalysisView,
          scrollController: _scrollController,
        );
    }
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.ap.loading,
            style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    ColorScheme colorScheme,
    String message,
    IconData icon,
  ) {
    return InkWell(
      onTap: () {
        if (widget.state == ScoreState.empty) {
          _pickSemester();
        } else {
          widget.onRefresh?.call();
        }
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withAlpha(77),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 40, color: colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (widget.state != ScoreState.empty) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                context.ap.clickToRetry,
                style: TextStyle(fontSize: 14, color: colorScheme.primary),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _pickSemester() {
    if (widget.semesterData != null) {
      SemesterPicker.show(
        context: context,
        semesterData: widget.semesterData!,
        currentIndex: widget.semesterData!.currentIndex,
        onSelect: (Semester semester, int index) {
          widget.onSelect?.call(index);
        },
      );
    }
    widget.onSearchButtonClick?.call();
  }
}

class ScoreContent extends StatefulWidget {
  const ScoreContent({
    super.key,
    required this.scoreData,
    this.onRefresh,
    this.middleTitle,
    this.finalTitle,
    this.onScoreSelect,
    this.middleScoreBuilder,
    this.finalScoreBuilder,
    required this.isAnalysisView,
    this.scrollController,
  });

  final ScoreData? scoreData;
  final Function()? onRefresh;
  final String? middleTitle;
  final String? finalTitle;
  final Function(int index)? onScoreSelect;
  final Widget Function(int index)? middleScoreBuilder;
  final Widget Function(int index)? finalScoreBuilder;
  final bool isAnalysisView;
  final ScrollController? scrollController;

  @override
  _ScoreContentState createState() => _ScoreContentState();
}

class _ScoreContentState extends State<ScoreContent> {
  @override
  Widget build(BuildContext context) {
    if (widget.scoreData == null) return const SizedBox.shrink();

    if (widget.isAnalysisView) {
      return ScoreAnalysisTab(
        scoreData: widget.scoreData!,
        onRefresh: widget.onRefresh,
        controller: widget.scrollController,
      );
    } else {
      return ScoreListTab(
        scoreData: widget.scoreData!,
        onRefresh: widget.onRefresh,
        middleTitle: widget.middleTitle,
        finalTitle: widget.finalTitle,
        onScoreSelect: widget.onScoreSelect,
        middleScoreBuilder: widget.middleScoreBuilder,
        finalScoreBuilder: widget.finalScoreBuilder,
        controller: widget.scrollController,
      );
    }
  }
}

class ScoreAnalysis {
  ScoreAnalysis(this.scoreData) {
    _scores = <double>[];
    for (final Score score in scoreData.scores) {
      final double? value = double.tryParse(score.semesterScore ?? '');
      if (value != null) {
        _scores.add(value);
      }
    }
    _totalSubjects = _scores.length;
  }

  final ScoreData scoreData;
  late List<double> _scores;
  late int _totalSubjects;

  int get totalSubjects => _totalSubjects;

  double get maxScore => _scores.isEmpty ? 0 : _scores.reduce(max);

  double get minScore => _scores.isEmpty ? 0 : _scores.reduce(min);

  double get average {
    if (_scores.isEmpty) return 0;
    return _scores.reduce((double a, double b) => a + b) / _scores.length;
  }

  double get standardDeviation {
    if (_scores.isEmpty) return 0;
    final double avg = average;
    final double sumSquares = _scores.fold<double>(
      0,
      (double sum, double score) => sum + (score - avg) * (score - avg),
    );
    return sqrt(sumSquares / _scores.length);
  }

  int get estimatedPR {
    final double avg = scoreData.detail.average ?? average;
    if (avg >= 95) return 99;
    if (avg >= 90) return 95;
    if (avg >= 85) return 88;
    if (avg >= 80) return 78;
    if (avg >= 75) return 65;
    if (avg >= 70) return 50;
    if (avg >= 65) return 35;
    if (avg >= 60) return 22;
    if (avg >= 55) return 12;
    return 5;
  }

  String get prLevel {
    final int pr = estimatedPR;
    if (pr >= 90) return '頂尖';
    if (pr >= 75) return '優秀';
    if (pr >= 50) return '中等';
    if (pr >= 25) return '待加強';
    return '需努力';
  }

  Map<String, int> get distribution {
    final Map<String, int> dist = <String, int>{
      '90-100': 0,
      '80-89': 0,
      '70-79': 0,
      '60-69': 0,
      '0-59': 0,
    };

    for (final double score in _scores) {
      if (score >= 90) {
        dist['90-100'] = dist['90-100']! + 1;
      } else if (score >= 80) {
        dist['80-89'] = dist['80-89']! + 1;
      } else if (score >= 70) {
        dist['70-79'] = dist['70-79']! + 1;
      } else if (score >= 60) {
        dist['60-69'] = dist['60-69']! + 1;
      } else {
        dist['0-59'] = dist['0-59']! + 1;
      }
    }

    return dist;
  }

  double get totalCredits {
    double credits = 0;
    for (final Score score in scoreData.scores) {
      final double? unit = double.tryParse(score.units);
      if (unit != null) credits += unit;
    }
    return credits;
  }

  double get passedCredits {
    double credits = 0;
    for (final Score score in scoreData.scores) {
      final double? scoreValue = double.tryParse(score.semesterScore ?? '');
      final double? unit = double.tryParse(score.units);
      if (scoreValue != null && scoreValue >= 60 && unit != null) {
        credits += unit;
      }
    }
    return credits;
  }

  double get failedCredits {
    double credits = 0;
    for (final Score score in scoreData.scores) {
      final double? scoreValue = double.tryParse(score.semesterScore ?? '');
      final double? unit = double.tryParse(score.units);
      if (scoreValue != null && scoreValue < 60 && unit != null) {
        credits += unit;
      }
    }
    return credits;
  }
}
