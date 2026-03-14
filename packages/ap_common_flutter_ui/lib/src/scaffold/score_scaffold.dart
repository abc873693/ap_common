import 'dart:math';

import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

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
    this.details,
    this.bottom,
    this.customStateHint,
  });
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
  final List<String>? details;

  final bool isShowSearchButton;

  final String? customHint;

  final Widget? bottom;

  @override
  ScoreScaffoldState createState() => ScoreScaffoldState();
}

class ScoreScaffoldState extends State<ScoreScaffold> {
  ApLocalizations get app => ApLocalizations.of(context);

  bool _isAnalysisView = false;

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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                widget.title ?? app.score,
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
        actions: <Widget>[
          if (widget.state == ScoreState.finish &&
              widget.scoreData != null &&
              widget.scoreData!.scores.isNotEmpty)
            IconButton(
              icon: Icon(
                _isAnalysisView
                    ? Icons.list_alt_rounded
                    : Icons.analytics_outlined,
              ),
              onPressed: () {
                setState(() => _isAnalysisView = !_isAnalysisView);
              },
            ),
        ],
      ),
      floatingActionButton: widget.isShowSearchButton
          ? FloatingActionButton(
              onPressed: () {
                _pickSemester();
                AnalyticsUtil.instance.logEvent('score_search_button_click');
              },
              child: const Icon(Icons.search),
            )
          : null,
      body: Column(
        children: <Widget>[
          if (widget.customHint != null && widget.customHint!.isNotEmpty)
            _buildHintBanner(),
          Expanded(child: _buildContent(context, colorScheme, app)),
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
        return app.clickToRetry;
      case ScoreState.empty:
        return app.scoreEmpty;
      case ScoreState.offlineEmpty:
        return app.noOfflineData;
      case ScoreState.custom:
        return widget.customStateHint ?? app.unknownError;
      default:
        return '';
    }
  }

  Widget _buildContent(
    BuildContext context,
    ColorScheme colorScheme,
    ApLocalizations ap,
  ) {
    switch (widget.state) {
      case ScoreState.loading:
        return _buildLoadingState(colorScheme);
      case ScoreState.error:
        return _buildErrorState(
          colorScheme,
          ap.clickToRetry,
          Icons.error_outline_rounded,
        );
      case ScoreState.empty:
        return _buildErrorState(
          colorScheme,
          ap.scoreEmpty,
          Icons.assignment_outlined,
        );
      case ScoreState.offlineEmpty:
        return _buildErrorState(
          colorScheme,
          ap.noOfflineData,
          Icons.cloud_off_rounded,
        );
      case ScoreState.custom:
        return _buildErrorState(
          colorScheme,
          widget.customStateHint ?? ap.somethingError,
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
          details: widget.details,
          isAnalysisView: _isAnalysisView,
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
            app.loading,
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
                app.clickToRetry,
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
      showDialog(
        context: context,
        builder: (_) => SimpleOptionDialog(
          title: app.pickSemester,
          items: widget.semesterData!.semesters,
          index: widget.semesterData!.currentIndex,
          onSelected: widget.onSelect,
        ),
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
    this.details,
    required this.isAnalysisView,
  });

  final ScoreData? scoreData;
  final Function()? onRefresh;
  final String? middleTitle;
  final String? finalTitle;
  final Function(int index)? onScoreSelect;
  final Widget Function(int index)? middleScoreBuilder;
  final Widget Function(int index)? finalScoreBuilder;
  final List<String>? details;
  final bool isAnalysisView;

  @override
  _ScoreContentState createState() => _ScoreContentState();
}

class _ScoreContentState extends State<ScoreContent> {
  @override
  Widget build(BuildContext context) {
    if (widget.scoreData == null) return const SizedBox.shrink();

    if (widget.isAnalysisView) {
      return _ScoreAnalysisTab(
        scoreData: widget.scoreData!,
        onRefresh: widget.onRefresh,
      );
    } else {
      return _ScoreListTab(
        scoreData: widget.scoreData!,
        onRefresh: widget.onRefresh,
        middleTitle: widget.middleTitle,
        finalTitle: widget.finalTitle,
        onScoreSelect: widget.onScoreSelect,
        middleScoreBuilder: widget.middleScoreBuilder,
        finalScoreBuilder: widget.finalScoreBuilder,
        details: widget.details,
      );
    }
  }
}

class _ScoreListTab extends StatelessWidget {
  const _ScoreListTab({
    required this.scoreData,
    this.onRefresh,
    this.middleTitle,
    this.finalTitle,
    this.onScoreSelect,
    this.middleScoreBuilder,
    this.finalScoreBuilder,
    this.details,
  });

  final ScoreData scoreData;
  final VoidCallback? onRefresh;
  final String? middleTitle;
  final String? finalTitle;
  final Function(int index)? onScoreSelect;
  final Widget Function(int index)? middleScoreBuilder;
  final Widget Function(int index)? finalScoreBuilder;
  final List<String>? details;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: scoreData.scores.length +
            ((details != null && details!.isNotEmpty) ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index < scoreData.scores.length) {
            return _buildScoreItem(colorScheme, scoreData.scores[index], index);
          } else {
            return _buildDetailsCard(colorScheme);
          }
        },
      ),
    );
  }

  Widget _buildDetailsCard(ColorScheme colorScheme) {
    if (details == null || details!.isEmpty) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant.withAlpha(77)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            for (final String text in details!)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: SelectableText(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(ColorScheme colorScheme, Score score, int index) {
    final String scoreStr = score.semesterScore ?? '';
    final double? scoreValue = double.tryParse(scoreStr);
    final bool isPassed = scoreValue != null && scoreValue >= 60;
    final Color scoreColor = scoreValue == null
        ? colorScheme.onSurfaceVariant
        : isPassed
            ? _getScoreColor(scoreValue)
            : colorScheme.error;

    return GestureDetector(
      onTap: onScoreSelect == null
          ? null
          : () {
              onScoreSelect!(index);
              AnalyticsUtil.instance.logEvent('score_title_click');
            },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outlineVariant.withAlpha(77)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 50,
                decoration: BoxDecoration(
                  color: scoreColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      score.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        _buildTag(
                          colorScheme,
                          score.required ?? '',
                          colorScheme.tertiary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${score.units} 學分',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  if (finalScoreBuilder == null)
                    Text(
                      score.semesterScore ?? '-',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                    ),
                  if (finalScoreBuilder != null) finalScoreBuilder!(index),
                  const SizedBox(height: 4),
                  if (middleScoreBuilder == null &&
                      score.middleScore != null &&
                      score.middleScore!.isNotEmpty)
                    Text(
                      '期中: ${score.middleScore}',
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  if (middleScoreBuilder != null) middleScoreBuilder!(index),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return const Color(0xFF4CAF50);
    if (score >= 80) return const Color(0xFF8BC34A);
    if (score >= 70) return const Color(0xFF2196F3);
    if (score >= 60) return const Color(0xFFFF9800);
    return const Color(0xFFF44336);
  }

  Widget _buildTag(ColorScheme colorScheme, String text, Color color) {
    if (text.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.replaceAll('【', '').replaceAll('】', ''),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _ScoreAnalysisTab extends StatelessWidget {
  const _ScoreAnalysisTab({required this.scoreData, this.onRefresh});

  final ScoreData scoreData;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ApLocalizations ap = ApLocalizations.of(context);
    final ScoreAnalysis analysis = ScoreAnalysis(scoreData);

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildMainSummaryCard(colorScheme, ap, analysis),
            const SizedBox(height: 16),
            ScorePRCard(analysis: analysis),
            const SizedBox(height: 16),
            ScoreStatisticsCard(analysis: analysis),
            const SizedBox(height: 16),
            ScoreDistributionCard(analysis: analysis),
            const SizedBox(height: 16),
            ScoreCreditSummaryCard(analysis: analysis),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSummaryCard(
    ColorScheme colorScheme,
    ApLocalizations ap,
    ScoreAnalysis analysis,
  ) {
    final Detail detail = scoreData.detail;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            colorScheme.primaryContainer,
            colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.primary.withAlpha(38),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildMainItem(
                    colorScheme,
                    Icons.star_rounded,
                    ap.average,
                    detail.average?.toStringAsFixed(2) ?? '-',
                  ),
                ),
                Container(
                  width: 1,
                  height: 60,
                  color: colorScheme.onPrimaryContainer.withAlpha(51),
                ),
                Expanded(
                  child: _buildMainItem(
                    colorScheme,
                    Icons.school_rounded,
                    ap.conductScore,
                    detail.conduct?.toStringAsFixed(0) ?? '-',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme.surface.withAlpha(179),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildRankItem(
                    colorScheme,
                    ap.classRank,
                    detail.classRank ?? '-',
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: colorScheme.outlineVariant.withAlpha(128),
                ),
                Expanded(
                  child: _buildRankItem(
                    colorScheme,
                    ap.departmentRank,
                    detail.departmentRank ?? '-',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainItem(
    ColorScheme colorScheme,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 28, color: colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: colorScheme.onPrimaryContainer.withAlpha(179),
          ),
        ),
      ],
    );
  }

  Widget _buildRankItem(ColorScheme colorScheme, String label, String value) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
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
