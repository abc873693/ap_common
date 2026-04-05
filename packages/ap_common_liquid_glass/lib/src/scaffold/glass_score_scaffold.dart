import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';

/// A glass-enhanced version of [ScoreScaffold].
///
/// Currently delegates to the original [ScoreScaffold] while the
/// app tree is wrapped in [LiquidGlassWidgets.wrap] via
/// [LiquidGlassApApp]. The glass theme bridge ensures glass widgets
/// used within the scaffold pick up the correct tint colors.
///
/// Score scaffold has deeply integrated state management (analysis
/// views, scroll-aware FABs, responsive layouts) that makes partial
/// widget replacement impractical. Instead, this wrapper ensures the
/// scaffold operates correctly within a Liquid Glass context.
class GlassScoreScaffold extends StatelessWidget {
  const GlassScoreScaffold({
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

  /// Creates from a [DataState<ScoreData?>].
  GlassScoreScaffold.fromDataState({
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
            dataState is DataLoaded<ScoreData?>
                ? dataState.hint
                : null,
        customStateHint =
            dataState is DataError<ScoreData?>
                ? dataState.hint
                : dataState is DataEmpty<ScoreData?>
                    ? dataState.hint
                    : null;

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
  Widget build(BuildContext context) {
    return ScoreScaffold(
      state: state,
      scoreData: scoreData,
      onRefresh: onRefresh,
      title: title,
      itemPicker: itemPicker,
      semesterData: semesterData,
      onSelect: onSelect,
      onSearchButtonClick: onSearchButtonClick,
      middleTitle: middleTitle,
      finalTitle: finalTitle,
      onScoreSelect: onScoreSelect,
      middleScoreBuilder: middleScoreBuilder,
      finalScoreBuilder: finalScoreBuilder,
      customHint: customHint,
      isShowSearchButton: isShowSearchButton,
      bottom: bottom,
      customStateHint: customStateHint,
    );
  }
}
