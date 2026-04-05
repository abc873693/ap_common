import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_score_analysis_cards.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Glass version of [ScoreAnalysisTab].
///
/// Replaces the summary card's gradient [Container] with
/// [GlassCard] and uses glass analysis card variants.
class GlassScoreAnalysisTab extends StatelessWidget {
  const GlassScoreAnalysisTab({
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
    final ScoreAnalysis analysis =
        ScoreAnalysis(scoreData);

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: SingleChildScrollView(
        controller: controller,
        physics:
            const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildMainSummaryCard(
              colorScheme,
              context.ap,
              analysis,
            ),
            const SizedBox(height: 16),
            GlassScorePRCard(analysis: analysis),
            const SizedBox(height: 16),
            GlassScoreStatisticsCard(
              analysis: analysis,
            ),
            const SizedBox(height: 16),
            GlassScoreDistributionCard(
              analysis: analysis,
            ),
            const SizedBox(height: 16),
            GlassScoreCreditSummaryCard(
              analysis: analysis,
            ),
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

    return GlassCard(
      useOwnLayer: true,
      padding: EdgeInsets.zero,
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
                    detail.average
                            ?.toStringAsFixed(2) ??
                        '-',
                  ),
                ),
                Container(
                  width: 1,
                  height: 60,
                  color: colorScheme
                      .onPrimaryContainer
                      .withAlpha(51),
                ),
                Expanded(
                  child: _buildMainItem(
                    colorScheme,
                    Icons.school_rounded,
                    ap.conductScore,
                    detail.conduct
                            ?.toStringAsFixed(0) ??
                        '-',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color:
                  colorScheme.surface.withAlpha(179),
              borderRadius:
                  const BorderRadius.vertical(
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
                  color: colorScheme.outlineVariant
                      .withAlpha(128),
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
        Icon(
          icon,
          size: 28,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color:
                colorScheme.onPrimaryContainer,
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
