import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

class ScoreListTab extends StatelessWidget {
  const ScoreListTab({
    super.key,
    required this.scoreData,
    this.onRefresh,
    this.middleTitle,
    this.finalTitle,
    this.onScoreSelect,
    this.middleScoreBuilder,
    this.finalScoreBuilder,
    this.controller,
  });

  final ScoreData scoreData;
  final VoidCallback? onRefresh;
  final String? middleTitle;
  final String? finalTitle;
  final Function(int index)? onScoreSelect;
  final Widget Function(int index)? middleScoreBuilder;
  final Widget Function(int index)? finalScoreBuilder;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: ListView.builder(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: scoreData.scores.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildScoreItem(
            context,
            colorScheme,
            scoreData.scores[index],
            index,
          );
        },
      ),
    );
  }

  Widget _buildScoreItem(
    BuildContext context,
    ColorScheme colorScheme,
    Score score,
    int index,
  ) {
    final String? effectiveStr =
        ScoreAnalysis.effectiveScoreStr(score);
    final double? scoreValue =
        ScoreAnalysis.parseScore(effectiveStr);
    final bool isPassed = scoreValue != null &&
        (scoreData.scoreType == ScoreType.gradePoint
            ? ScoreAnalysis.scoreToGradePoint(scoreValue) >=
                scoreData.passingGradePoint
            : scoreValue >= scoreData.passingScore);
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
              AnalyticsUtil.instance
                  .logEvent('score_title_click');
            },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.outlineVariant.withAlpha(77),
          ),
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
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
                          context.ap.unitCountFormat(
                            arg1: score.units,
                          ),
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                colorScheme.onSurfaceVariant,
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
                    ..._buildScoreDisplay(
                      colorScheme,
                      score,
                      scoreValue,
                      scoreColor,
                    ),
                  if (finalScoreBuilder != null)
                    finalScoreBuilder!(index),
                  const SizedBox(height: 4),
                  if (middleScoreBuilder == null &&
                      score.middleScore != null &&
                      score.middleScore!.isNotEmpty)
                    Text(
                      context.ap.midtermPrefix(
                        arg1: score.middleScore!,
                      ),
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  if (middleScoreBuilder != null)
                    middleScoreBuilder!(index),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the score display based on data type.
  /// - Numeric scores (e.g. "90") -> show number +
  ///   converted letter grade
  /// - Letter grades (e.g. "A+") -> show letter +
  ///   converted grade point
  List<Widget> _buildScoreDisplay(
    ColorScheme colorScheme,
    Score score,
    double? scoreValue,
    Color scoreColor,
  ) {
    final String raw =
        ScoreAnalysis.effectiveScoreStr(score) ?? '-';
    final bool isNumeric =
        scoreData.scoreType == ScoreType.numeric;

    if (scoreValue == null) {
      return <Widget>[
        Text(
          raw,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: scoreColor,
          ),
        ),
      ];
    }

    if (isNumeric) {
      return <Widget>[
        Text(
          raw,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: scoreColor,
          ),
        ),
        Text(
          ScoreAnalysis.scoreToGradeLetter(scoreValue),
          style: TextStyle(
            fontSize: 11,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ];
    } else {
      return <Widget>[
        Text(
          raw,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: scoreColor,
          ),
        ),
        Text(
          ScoreAnalysis.scoreToGradePoint(scoreValue)
              .toStringAsFixed(1),
          style: TextStyle(
            fontSize: 11,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ];
    }
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return const Color(0xFF4CAF50);
    if (score >= 80) return const Color(0xFF8BC34A);
    if (score >= 70) return const Color(0xFF2196F3);
    if (score >= 60) return const Color(0xFFFF9800);
    return const Color(0xFFF44336);
  }

  Widget _buildTag(
    ColorScheme colorScheme,
    String text,
    Color color,
  ) {
    if (text.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
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

class ScoreAnalysisTab extends StatelessWidget {
  const ScoreAnalysisTab({
    super.key,
    required this.scoreData,
    this.onRefresh,
    this.controller,
  });

  final ScoreData scoreData;
  final VoidCallback? onRefresh;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final ScoreAnalysis analysis = ScoreAnalysis(scoreData);

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: SingleChildScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildMainSummaryCard(
              colorScheme,
              context.ap,
              analysis,
            ),
            const SizedBox(height: 16),
            ScorePRCard(analysis: analysis),
            const SizedBox(height: 16),
            ScoreGPACard(analysis: analysis),
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
                    detail.average?.toStringAsFixed(2) ??
                        '-',
                  ),
                ),
                if (detail.conduct != null) ...<Widget>[
                  Container(
                    width: 1,
                    height: 60,
                    color: colorScheme.onPrimaryContainer
                        .withAlpha(51),
                  ),
                  Expanded(
                    child: _buildMainItem(
                      colorScheme,
                      Icons.school_rounded,
                      ap.conductScore,
                      detail.conduct!.toStringAsFixed(0),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (detail.classRank != null ||
              detail.departmentRank != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface.withAlpha(179),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Row(
                children: <Widget>[
                  if (detail.classRank != null)
                    Expanded(
                      child: _buildRankItem(
                        colorScheme,
                        ap.classRank,
                        detail.classRank!,
                      ),
                    ),
                  if (detail.classRank != null &&
                      detail.departmentRank != null)
                    Container(
                      width: 1,
                      height: 40,
                      color: colorScheme.outlineVariant
                          .withAlpha(128),
                    ),
                  if (detail.departmentRank != null)
                    Expanded(
                      child: _buildRankItem(
                        colorScheme,
                        ap.departmentRank,
                        detail.departmentRank!,
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
            color: colorScheme.onPrimaryContainer
                .withAlpha(179),
          ),
        ),
      ],
    );
  }

  Widget _buildRankItem(
    ColorScheme colorScheme,
    String label,
    String value,
  ) {
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
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
