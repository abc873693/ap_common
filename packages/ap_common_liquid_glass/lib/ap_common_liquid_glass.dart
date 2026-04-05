/// Liquid Glass design language for AP series apps.
///
/// This package provides glass-effect scaffold variants and widgets
/// powered by [liquid_glass_widgets]. It is an opt-in extension of
/// [ap_common_flutter_ui] — existing apps work unchanged.
///
/// ## Quick Start
///
/// 1. Add `ap_common_liquid_glass` to your dependencies.
/// 2. Initialize shaders in `main()`:
///    ```dart
///    await LiquidGlassWidgets.initialize();
///    ```
/// 3. Use [LiquidGlassApApp] instead of [ApApp]:
///    ```dart
///    LiquidGlassApApp(home: MyHomePage())
///    ```
/// 4. Use glass scaffold variants:
///    ```dart
///    GlassHomePageScaffold(...)
///    GlassLoginScaffold(...)
///    ```
library ap_common_liquid_glass;

export 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
export 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

export 'src/glass_theme_bridge.dart';
export 'src/liquid_glass_app.dart';
export 'src/pages/glass_ap_course_page.dart';
export 'src/pages/glass_ap_login_page.dart';
export 'src/pages/glass_ap_score_page.dart';
export 'src/scaffold/glass_course_scaffold.dart';
export 'src/scaffold/glass_home_page_scaffold.dart';
export 'src/scaffold/glass_image_viewer_scaffold.dart';
export 'src/scaffold/glass_login_scaffold.dart';
export 'src/scaffold/glass_score_scaffold.dart';
export 'src/scaffold/glass_user_info_scaffold.dart';
export 'src/widgets/glass_ap_drawer.dart';
export 'src/widgets/glass_course_content.dart';
export 'src/widgets/glass_course_list.dart';
export 'src/widgets/glass_course_table_view.dart';
export 'src/widgets/glass_dialog.dart';
export 'src/widgets/glass_score_analysis_cards.dart';
export 'src/widgets/glass_score_analysis_tab.dart';
export 'src/widgets/glass_score_list_tab.dart';
