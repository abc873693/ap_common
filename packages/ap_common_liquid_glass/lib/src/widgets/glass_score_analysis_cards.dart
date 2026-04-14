import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Glass version of [ScorePRCard].
class GlassScorePRCard extends StatelessWidget {
  const GlassScorePRCard({
    super.key,
    required this.analysis,
  });

  final ScoreAnalysis analysis;

  Color _getPRColor(ColorScheme colorScheme, int pr) {
    if (pr >= 90) return const Color(0xFF34C759);
    if (pr >= 75) return const Color(0xFF00C7BE);
    if (pr >= 50) return const Color(0xFF007AFF);
    if (pr >= 25) return const Color(0xFFFF9500);
    return const Color(0xFFFF3B30);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final int pr = analysis.estimatedPR;
    final Color prColor = _getPRColor(colorScheme, pr);

    return GlassCard(
      useOwnLayer: true,
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: prColor.withAlpha(26),
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.trending_up_rounded,
                    size: 28,
                    color: prColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '\u4f30\u8a08 PR \u503c',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme
                              .onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PR $pr',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: prColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: prColor.withAlpha(26),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    analysis.prLevel,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: prColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.fromLTRB(16, 0, 16, 16),
            height: 8,
            decoration: BoxDecoration(
              color:
                  colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: pr / 100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      prColor.withAlpha(179),
                      prColor,
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              16,
            ),
            child: Text(
              '※ PR 值為根據平均成績估算，僅供參考',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant
                    .withAlpha(179),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Glass version of [ScoreStatisticsCard].
class GlassScoreStatisticsCard extends StatelessWidget {
  const GlassScoreStatisticsCard({
    super.key,
    required this.analysis,
  });

  final ScoreAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return GlassCard(
      useOwnLayer: true,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.bar_chart_rounded,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '\u6210\u7e3e\u7d71\u8a08',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const GlassDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _GlassScoreStatItem(
                        label: '\u6700\u9ad8\u5206',
                        value: analysis.maxScore
                            .toStringAsFixed(0),
                        icon:
                            Icons.arrow_upward_rounded,
                        color: const Color(0xFF34C759),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _GlassScoreStatItem(
                        label: '\u6700\u4f4e\u5206',
                        value: analysis.minScore
                            .toStringAsFixed(0),
                        icon: Icons
                            .arrow_downward_rounded,
                        color: colorScheme.error,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _GlassScoreStatItem(
                        label: '\u6a19\u6e96\u5dee',
                        value: analysis.standardDeviation
                            .toStringAsFixed(2),
                        icon:
                            Icons.analytics_outlined,
                        color: colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _GlassScoreStatItem(
                        label: '\u79d1\u76ee\u6578',
                        value: analysis.totalSubjects
                            .toString(),
                        icon:
                            Icons.menu_book_rounded,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassScoreStatItem extends StatelessWidget {
  const _GlassScoreStatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withAlpha(13),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Glass version of [ScoreDistributionCard].
class GlassScoreDistributionCard
    extends StatelessWidget {
  const GlassScoreDistributionCard({
    super.key,
    required this.analysis,
  });

  final ScoreAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return GlassCard(
      useOwnLayer: true,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.pie_chart_rounded,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '\u6210\u7e3e\u5206\u4f48',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const GlassDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _GlassDistributionBar(
                  label:
                      '90-100 (\u512a\u79c0)',
                  count: analysis
                          .distribution['90-100'] ??
                      0,
                  total: analysis.totalSubjects,
                  color: const Color(0xFF34C759),
                ),
                const SizedBox(height: 10),
                _GlassDistributionBar(
                  label:
                      '80-89 (\u826f\u597d)',
                  count: analysis
                          .distribution['80-89'] ??
                      0,
                  total: analysis.totalSubjects,
                  color: const Color(0xFF00C7BE),
                ),
                const SizedBox(height: 10),
                _GlassDistributionBar(
                  label:
                      '70-79 (\u666e\u901a)',
                  count: analysis
                          .distribution['70-79'] ??
                      0,
                  total: analysis.totalSubjects,
                  color: const Color(0xFF007AFF),
                ),
                const SizedBox(height: 10),
                _GlassDistributionBar(
                  label:
                      '60-69 (\u53ca\u683c)',
                  count: analysis
                          .distribution['60-69'] ??
                      0,
                  total: analysis.totalSubjects,
                  color: const Color(0xFFFF9500),
                ),
                const SizedBox(height: 10),
                _GlassDistributionBar(
                  label: '0-59 '
                      '(\u4e0d\u53ca\u683c)',
                  count: analysis
                          .distribution['0-59'] ??
                      0,
                  total: analysis.totalSubjects,
                  color: const Color(0xFFFF3B30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassDistributionBar extends StatelessWidget {
  const _GlassDistributionBar({
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  final String label;
  final int count;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final double percentage =
        total > 0 ? count / total : 0;

    return Row(
      children: <Widget>[
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color:
                  colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 40,
          child: Text(
            '$count \u79d1',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

/// Glass version of [ScoreCreditSummaryCard].
class GlassScoreCreditSummaryCard
    extends StatelessWidget {
  const GlassScoreCreditSummaryCard({
    super.key,
    required this.analysis,
  });

  final ScoreAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return GlassCard(
      useOwnLayer: true,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.account_balance_rounded,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '\u5b78\u5206\u7d71\u8a08',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const GlassDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _GlassCreditItem(
                    label: '\u4fee\u7fd2\u5b78\u5206',
                    value: analysis.totalCredits
                        .toStringAsFixed(1),
                    color: colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: _GlassCreditItem(
                    label: '\u53ca\u683c\u5b78\u5206',
                    value: analysis.passedCredits
                        .toStringAsFixed(1),
                    color: const Color(0xFF34C759),
                  ),
                ),
                Expanded(
                  child: _GlassCreditItem(
                    label:
                        '\u4e0d\u53ca\u683c\u5b78'
                        '\u5206',
                    value: analysis.failedCredits
                        .toStringAsFixed(1),
                    color: colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCreditItem extends StatelessWidget {
  const _GlassCreditItem({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return Column(
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
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
