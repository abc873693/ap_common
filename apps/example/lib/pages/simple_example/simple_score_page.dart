import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Simplified score page using [ApScorePage].
///
/// Compare with [apps/example/lib/pages/study/score_page.dart] (~116 lines)
/// — this achieves the same result with just a single widget.
class SimpleScorePage extends StatelessWidget {
  const SimpleScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = ApLocalizations.of(context);

    return ApScorePage(
      onLoadSemesters: () async {
        final String rawString =
            await rootBundle.loadString(FileAssets.semesters);
        return SemesterData.fromRawJson(rawString);
      },
      onLoadScore: (Semester semester) async {
        final String rawString =
            await rootBundle.loadString(FileAssets.scores);
        return ScoreData.fromRawJson(rawString);
      },
      detailBuilder: (ScoreData? scoreData) => <String>[
        '${ap.conductScore}：${scoreData?.detail.conduct ?? ''}',
        '${ap.average}：${scoreData?.detail.average ?? ''}',
        '${ap.classRank}：${scoreData?.detail.classRank ?? ''}',
        '${ap.departmentRank}：${scoreData?.detail.departmentRank ?? ''}',
      ],
    );
  }
}
