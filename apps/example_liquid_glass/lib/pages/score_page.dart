import 'package:ap_common_example_liquid_glass/res/assets.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Score page using [GlassApScorePage].
class GlassScorePage extends StatelessWidget {
  const GlassScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = context.ap;

    return GlassApScorePage(
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
