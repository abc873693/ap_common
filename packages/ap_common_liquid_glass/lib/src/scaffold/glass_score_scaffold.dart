import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_floating_toolbar.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_score_analysis_tab.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_score_list_tab.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_semester_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass-enhanced version of [ScoreScaffold].
///
/// Replaces the Material [AppBar] with [GlassAppBar] and the
/// [FloatingActionButton]s with [GlassButton] while preserving
/// all original functionality (analysis view toggle, scroll-aware
/// FAB visibility, responsive landscape layout, etc.).
class GlassScoreScaffold extends StatefulWidget {
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
  }) : state = dataState.when(
         loading: () => ScoreState.loading,
         loaded: (_, __) => ScoreState.finish,
         error: (_) => ScoreState.error,
         empty: (_) => ScoreState.empty,
       ),
       scoreData = dataState.dataOrNull,
       customHint = dataState is DataLoaded<ScoreData?> ? dataState.hint : null,
       customStateHint = dataState is DataError<ScoreData?>
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
  GlassScoreScaffoldState createState() => GlassScoreScaffoldState();
}

class GlassScoreScaffoldState extends State<GlassScoreScaffold> {
  bool get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  bool _isAnalysisView = true;
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

    return AdaptiveLiquidGlassLayer(
      child: Scaffold(
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
                GlassButton(
                  key: const ValueKey<String>('switch_view_button'),
                  icon: Icon(
                    _isAnalysisView
                        ? Icons.list_alt_rounded
                        : Icons.analytics_outlined,
                  ),
                  onTap: () {
                    setState(() => _isAnalysisView = !_isAnalysisView);
                  },
                ),
              if (widget.isShowSearchButton) ...<Widget>[
                if (widget.state == ScoreState.finish &&
                    widget.scoreData != null &&
                    widget.scoreData!.scores.isNotEmpty &&
                    !isLandscape)
                  const SizedBox(height: 8),
                GlassButton(
                  key: const ValueKey<String>('search_button'),
                  icon: const Icon(Icons.search),
                  onTap: () {
                    _pickSemester();
                    AnalyticsUtil.instance.logEvent(
                      'score_search_button_click',
                    );
                  },
                ),
              ],
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 60,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        if (widget.customHint != null &&
                            widget.customHint!.isNotEmpty)
                          HintBanner(text: widget.customHint!),
                        Expanded(child: _buildContent(context, colorScheme)),
                      ],
                    ),
                  ),
                  if (widget.state == ScoreState.finish &&
                      isLandscape) ...<Widget>[
                    const SizedBox(width: 16.0),
                    Expanded(
                      flex: 2,
                      child: GlassCard(
                        useOwnLayer: true,
                        padding: EdgeInsets.zero,
                        child: GlassScoreListTab(
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
                  ],
                ],
              ),
            ),
            GlassFloatingToolbar(
              leading: <Widget>[
                if (widget.semesterData != null && widget.itemPicker == null)
                  GlassSemesterPicker(
                    semesterData: widget.semesterData!,
                    currentIndex: widget.semesterData!.currentIndex,
                    onSelect: (Semester semester, int index) {
                      widget.onSelect?.call(index);
                    },
                    featureTag: 'score',
                  )
                else if (widget.itemPicker != null)
                  widget.itemPicker!,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ColorScheme colorScheme) {
    switch (widget.state) {
      case ScoreState.loading:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const GlassProgressIndicator.circular(),
              const SizedBox(height: 16),
              Text(
                context.ap.loading,
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
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
        if (widget.scoreData == null) {
          return const SizedBox.shrink();
        }
        if (isLandscape || _isAnalysisView) {
          return GlassScoreAnalysisTab(
            scoreData: widget.scoreData!,
            onRefresh: widget.onRefresh,
            controller: _scrollController,
          );
        }
        return GlassScoreListTab(
          scoreData: widget.scoreData!,
          onRefresh: widget.onRefresh,
          middleTitle: widget.middleTitle,
          finalTitle: widget.finalTitle,
          onScoreSelect: widget.onScoreSelect,
          middleScoreBuilder: widget.middleScoreBuilder,
          finalScoreBuilder: widget.finalScoreBuilder,
          controller: _scrollController,
        );
    }
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
            GlassCard(
              useOwnLayer: true,
              width: 80,
              height: 80,
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
      GlassSemesterPicker.show(
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
