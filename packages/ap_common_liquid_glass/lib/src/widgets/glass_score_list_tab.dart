import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Glass version of [ScoreListTab].
///
/// Replaces each score item's [Container] with [GlassCard].
class GlassScoreListTab extends StatelessWidget {
  const GlassScoreListTab({
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
    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: ListView.builder(
        controller: controller,
        physics:
            const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 80,
        ),
        itemCount: scoreData.scores.length,
        itemBuilder:
            (BuildContext context, int index) {
          return _buildScoreItem(
            Theme.of(context).colorScheme,
            scoreData.scores[index],
            index,
          );
        },
      ),
    );
  }

  Widget _buildScoreItem(
    ColorScheme colorScheme,
    Score score,
    int index,
  ) {
    final String scoreStr =
        score.semesterScore ?? '';
    final double? scoreValue =
        double.tryParse(scoreStr);
    final bool isPassed =
        scoreValue != null && scoreValue >= 60;
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GlassCard(
          useOwnLayer: true,
          child: Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 50,
                decoration: BoxDecoration(
                  color: scoreColor,
                  borderRadius:
                      BorderRadius.circular(2),
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
                        color:
                            colorScheme.onSurface,
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
                          '${score.units}'
                          ' \u5b78\u5206',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
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
                  if (finalScoreBuilder != null)
                    finalScoreBuilder!(index),
                  const SizedBox(height: 4),
                  if (middleScoreBuilder == null &&
                      score.middleScore != null &&
                      score.middleScore!.isNotEmpty)
                    Text(
                      '\u671f\u4e2d: '
                      '${score.middleScore}',
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme
                            .onSurfaceVariant,
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

  Color _getScoreColor(double score) {
    if (score >= 90) return const Color(0xFF34C759);
    if (score >= 80) return const Color(0xFF00C7BE);
    if (score >= 70) return const Color(0xFF007AFF);
    if (score >= 60) return const Color(0xFFFF9500);
    return const Color(0xFFFF3B30);
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
        text
            .replaceAll('\u3010', '')
            .replaceAll('\u3011', ''),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
