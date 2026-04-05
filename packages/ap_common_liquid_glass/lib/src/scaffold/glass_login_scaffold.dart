import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass-enhanced version of [LoginScaffold].
///
/// Replaces the gradient background with a translucent glass
/// surface and the form card with [GlassCard].
class GlassLoginScaffold extends StatefulWidget {
  const GlassLoginScaffold({
    super.key,
    required this.logoSource,
    required this.forms,
    this.logoMode = LogoMode.text,
  });

  final LogoMode logoMode;
  final String logoSource;
  final List<Widget> forms;

  static const String routerName = '/login';

  @override
  GlassLoginScaffoldState createState() =>
      GlassLoginScaffoldState();
}

class GlassLoginScaffoldState
    extends State<GlassLoginScaffold> {
  bool get isTablet =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    final Orientation orientation =
        MediaQuery.of(context).orientation;
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return AdaptiveLiquidGlassLayer(
      child: Scaffold(
        resizeToAvoidBottomInset:
          orientation == Orientation.portrait,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? <Color>[
                    colorScheme.surface,
                    colorScheme.surfaceContainerLowest,
                  ]
                : <Color>[
                    colorScheme.primary,
                    colorScheme.primaryContainer,
                  ],
          ),
        ),
        child: AutofillGroup(
          child: KeyboardDismissOnTap(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: orientation ==
                          Orientation.portrait
                      ? Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: _renderContent(
                            orientation,
                            colorScheme,
                            isDark,
                          ),
                        )
                      : Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: _renderContent(
                            orientation,
                            colorScheme,
                            isDark,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _logo(ColorScheme colorScheme, bool isDark) {
    switch (widget.logoMode) {
      case LogoMode.image:
        return GlassCard(
          child: SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                widget.logoSource,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      case LogoMode.text:
        return TextLogo(
          text: widget.logoSource,
          isDark: isDark,
          colorScheme: colorScheme,
        );
    }
  }

  List<Widget> _renderContent(
    Orientation orientation,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    final Widget logoWidget =
        _logo(colorScheme, isDark);
    final Widget formCard = GlassCard(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: widget.forms,
          ),
        ),
      ),
    );

    if (orientation == Orientation.portrait) {
      return <Widget>[
        Center(child: logoWidget),
        const SizedBox(height: 48),
        formCard,
      ];
    } else {
      return <Widget>[
        Expanded(child: Center(child: logoWidget)),
        const SizedBox(width: 32),
        Expanded(child: Center(child: formCard)),
      ];
    }
  }
}
