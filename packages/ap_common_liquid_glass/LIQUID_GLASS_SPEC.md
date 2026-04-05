# Liquid Glass Integration Spec

> This file captures the design decisions and implementation status from the
> initial planning session. Read this before continuing development.

## Architecture Decision

- **New package**: `packages/ap_common_liquid_glass/` (opt-in, not integrated into `ap_common_flutter_ui`)
- **Dependency**: `liquid_glass_widgets: ^0.7.0` (pre-1.0, API may change)
- **Scope**: All 6 scaffolds + drawer + dialogs + 3 convenience pages

## Dependency Chain

```
ap_common_flutter_ui (Material 3, no glass dependency)
  └─ ap_common_liquid_glass (opt-in glass layer)
       └─ liquid_glass_widgets ^0.7.0
```

## Current Implementation Status

### Done (initial scaffold, needs `pub get` + `analyze` to verify)

| File | Status | Notes |
|------|--------|-------|
| `pubspec.yaml` | Done | Registered in root workspace |
| `lib/ap_common_liquid_glass.dart` | Done | Barrel export |
| `lib/src/liquid_glass_app.dart` | Done | `LiquidGlassApApp` wrapping `MaterialApp` + `LiquidGlassWidgets.wrap()` + `GlassTheme` |
| `lib/src/glass_theme_bridge.dart` | Done | `GlassThemeBridge.fromContext()` — currently returns default `GlassThemeData`, needs seed color mapping |
| `lib/src/scaffold/glass_home_page_scaffold.dart` | Done | `GlassAppBar`, keeps Material `NavigationBar` (TODO: swap to `GlassBottomBar`) |
| `lib/src/scaffold/glass_login_scaffold.dart` | Done | Gradient background kept, form card → `GlassCard`, logo image → `GlassCard` |
| `lib/src/scaffold/glass_course_scaffold.dart` | Done | Delegates to original `CourseScaffold` (complex internal state) |
| `lib/src/scaffold/glass_score_scaffold.dart` | Done | Delegates to original `ScoreScaffold` |
| `lib/src/scaffold/glass_user_info_scaffold.dart` | Done | Needs review — SliverAppBar has no direct glass equivalent |
| `lib/src/scaffold/glass_image_viewer_scaffold.dart` | Done | `GlassAppBar` + `GlassTabBar` |
| `lib/src/widgets/glass_ap_drawer.dart` | Done | Needs review |
| `lib/src/widgets/glass_dialog.dart` | Done | `GlassYesNoDialog`, `GlassDefaultDialog` |
| `lib/src/pages/glass_ap_login_page.dart` | Done | Wraps `GlassLoginScaffold` |
| `lib/src/pages/glass_ap_course_page.dart` | Done | Wraps `GlassCourseScaffold` |
| `lib/src/pages/glass_ap_score_page.dart` | Done | Wraps `GlassScoreScaffold` |

### TODO (next steps)

1. **`flutter pub get` + `dart analyze`** — fix all compile errors against real `liquid_glass_widgets` API
2. **GlassThemeBridge** — map `ApTheme.seedColor` to glass tint color (currently returns defaults)
3. **GlassBottomBar** — `GlassHomePageScaffold` still uses Material `NavigationBar`; need to map `List<Widget> bottomNavigationBarItems` to `GlassBottomBar` tabs
4. **CourseScaffold / ScoreScaffold deep integration** — currently just delegates to original; ideally:
   - Extract body builder from original scaffolds
   - Replace AppBar, FAB, card surfaces with glass equivalents
5. **UserInfoScaffold** — `SliverAppBar` with gradient has no glass equivalent; design custom glass header
6. **Example App** — add glass demo page in `apps/example/`
7. **Widget tests** — at least smoke test each glass scaffold renders without errors
8. **`AboutUsPage` glass variant** — not yet created

## Key Design Decisions

### Composition over Duplication
- Glass scaffolds should **reuse** original scaffold logic, not copy-paste
- Replace only the "chrome" (AppBar, NavigationBar, FAB, Card surfaces)
- Keep all state management, DataState patterns, responsive layouts

### API Compatibility
- Glass scaffolds accept the **same parameters** as originals
- Downstream apps swap `HomePageScaffold(...)` → `GlassHomePageScaffold(...)` with no other changes
- `LiquidGlassApApp` has the same API as `ApApp` + `quality` and `glassSettings` params

### Initialization
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize(); // pre-cache shaders
  registerOneForAll();
  registerApCommonService();
  await (PreferenceUtil.instance as ApPreferenceUtil).init(key: key, iv: iv);
  runApp(const MyApp());
}

// Use LiquidGlassApApp instead of ApApp
LiquidGlassApApp(
  home: GlassHomePage(),
  quality: GlassQuality.standard, // or .premium for Impeller
)
```

## Widget Mapping Reference

| liquid_glass_widgets | Replaces in ap_common | Where Used |
|---------------------|----------------------|------------|
| `GlassAppBar` | `AppBar` | All scaffolds |
| `GlassBottomBar` | `NavigationBar` | HomePageScaffold |
| `GlassCard` | Card surfaces, form containers | LoginScaffold, settings |
| `GlassButton` | `FloatingActionButton`, `ApButton` | Course/Score FABs |
| `GlassTextField` | `ApTextField` | Login form |
| `GlassDialog` | `DefaultDialog`, `YesNoDialog` | Dialogs |
| `GlassSideBar` | `Drawer` in `ApDrawer` | Drawer |
| `GlassTabBar` | `TabBar` | ImageViewerScaffold |
| `GlassSearchBar` | Search in CourseScaffold | Course search |
| `GlassListTile` | Course/Score list items | List views |
| `GlassSheet` | Bottom sheets | Various |
| `GlassSnackBar` | SnackBar | Hints/notifications |
| `GlassTheme` + `GlassThemeData` | — | App-level via `GlassThemeBridge` |

## Original Scaffold Structures (for reference)

### HomePageScaffold
- `AppBar` (title + actions) → `GlassAppBar`
- `NavigationBar` (elevation 12, height 56) → `GlassBottomBar`
- Announcement carousel with auto-play `PageView`
- Responsive: tablet (680px) shows drawer inline
- State: `HomeState {loading, finish, error, empty, offline}`

### LoginScaffold
- Gradient `DecoratedBox` background (primary→primaryContainer / surface→surfaceContainerLowest)
- Form card with 24dp radius, shadow
- Logo: text or image mode
- Responsive: portrait=column, landscape=row

### CourseScaffold (~1700 lines)
- `AppBar` + `SemesterPicker` + settings gear
- List tab + Table tab (course color-coded)
- Screenshot capture with `RepaintBoundary`
- `CourseConfig` InheritedWidget for display settings
- 12 predefined course colors
- Complex state: `CourseState {loading, finish, error, empty, offlineEmpty, custom}`

### ScoreScaffold (~925 lines)
- `AppBar` + `SemesterPicker`
- Score list + Analysis view toggle
- Score color by range (90+ green, 80+ light green, 70+ blue, 60+ orange, <60 red)
- Analysis: ScorePRCard, ScoreStatisticsCard, ScoreDistributionCard, ScoreCreditSummaryCard

### UserInfoScaffold
- `SliverAppBar` (expandedHeight 200, gradient FlexibleSpaceBar)
- Avatar with Hero animation
- QR code / Code39 barcode toggle
- `CustomScrollView` with pinned app bar

### ImageViewerScaffold
- `AppBar` + optional actions
- `TabBar` (if multiple images)
- `TabBarView` with `PhotoView` galleries

## Performance Notes

- `GlassQuality.standard` — default, works on all platforms
- `GlassQuality.premium` — Impeller only, for static surfaces
- `LiquidGlassWidgets.initialize()` pre-warms shaders (call in `main()`)
- Library respects system Reduce Motion / Reduce Transparency (WCAG)

## Code Style Reminders

- `always_specify_types: true`
- `prefer_single_quotes: true`
- 80 char line limit
- Constructors first in class
- Conventional Commits: `feat(liquid_glass):`, `fix(liquid_glass):`, etc.
