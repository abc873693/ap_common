# Session Memory: ap_common UX 全面改善

## 分支
`claude/improve-project-ux-GUVRG` — 基於 `3dc962b` (chore(release): publish packages)

## 完成的 9 個 commits（50 files, +5002 / -275）

### 1. feat(ui): comprehensive UX improvements across the project `ec8a6b1`
- **國際化**：39 個新 i18n key，替換 30+ 處硬編碼中文（score_analysis_widgets, semester_picker, user_info_scaffold, course_scaffold）
- **登入驗證**：ApLoginPage toast → inline field error（ApTextField 新增 errorText 參數）
- **HintContent**：新增 onTap + actionText 參數（重試按鈕）
- **ProgressDialog**：文字色 primary→onSurface、新增 onCancel callback
- **Accessibility**：HintContent/NotificationItem/TextCheckBox/HomePageScaffold 加 Semantics
- **Haptic**：登入失敗 mediumImpact、學期選擇/成績切換 selectionClick
- **動畫**：CourseScaffold/ScoreScaffold/HomePageScaffold 加 AnimatedSwitcher(300ms)
- **Dialog 清理**：yes_no_dialog/default_dialog sample 中文→英文

### 2. fix(i18n): correct spelling errors `0ac9ddb`
- "Change sucees"→"success"、"No any buses"→"No buses available"

### 3. feat(score): GPA 4.3 calculation `e2f22c0`
- ScoreAnalysis 新增 scoreToGradePoint()、scoreToGradeLetter()、gpa getter、gradeDistribution
- 等第對照表：A+(4.3)→F(0)，依據中山大學標準
- ScoreGPACard widget：GPA 值 + 進度條 + 等第 badge + 每科對照表
- 插入 _ScoreAnalysisTab 的 main summary card 下方

### 4. feat(course): custom course support `c21c6c6`
- **CustomCourseData** (ap_common_core)：plain Dart class，CRUD + SharedPreferences 持久化，`custom_` code prefix
- **CourseData.mergeCustom()**：API 課程 + 自訂課程合併
- **CourseEditSheet** (bottom sheet)：名稱/教師/教室/學分/顏色選擇/時段 grid（衝突偵測）
- **CourseScaffold**：空格顯示 `+`、CourseContent 加編輯/刪除按鈕（enableCustomCourse flag）
- **ApCoursePage**：自動管理 CustomCourseData 生命週期
- 19 個新 i18n 字串

### 5. feat(plugin): Android course table widget `f77c50e`
- CourseTableWidget.kt：Jetpack Glance 週課表 grid（weekday×timeslot、12 色 palette、今日高亮）
- 4×3 cells、可縮放到 530×530dp

### 6. feat(plugin): iOS course table widget `de6ddab`
- CourseTableWidget.swift：SwiftUI grid（medium/large/extraLarge）
- WidgetBundle 改為同時註冊 CourseHintWidget + CourseTableWidget

### 7. feat(plugin): 3 new widgets (today schedule, countdown, student ID) `16429f3`
- **TodayScheduleWidget**：今日課程時間線，已過灰色（Android 4×2 / iOS medium+large）
- **CountdownWidget**：大字倒數分鐘數（Android 2×2 / iOS small + accessoryCircular 鎖定畫面）
- **StudentIdWidget**：姓名/學號/條碼（Android ZXing Code39 / iOS CoreImage Code128）
- Dart API 新增：updateUserInfoWidget() / clearUserInfoWidget()
- Android build.gradle 加 ZXing 依賴

### 8. feat(home): dashboard layout `1b6fa63`
- HomePageScaffold 新增 dashboardWidgets 參數（保留輪播 + 下方可捲動 dashboard）
- QuickInfoRow：橫向資訊 chips
- TodayScheduleCard：今日課表卡片（自動從 CourseData 取今天課程）
- 不傳 dashboardWidgets → 原本全螢幕輪播（100% 向後相容）

### 9. fix(home): responsive carousel height `901cfb9`
- 輪播高度從固定 260dp 改為 `(available * 0.5).clamp(150, 300)`
- Dashboard 模式 padding 32→12pt
- iPhone SE(667pt) 輪播~183pt，首屏可見 dashboard ✅

---

## Widget 清單（5 個，雙平台）

| Widget | Android | iOS | 資料來源 |
|--------|---------|-----|---------|
| 上課提醒 | 3×1 Glance | small/medium/lock | CourseData (既有) |
| 學期課表 | 4×3 Glance | medium/large/XL | CourseData (既有) |
| 今日課表 | 4×2 Glance | medium/large | CourseData (既有) |
| 上課倒數 | 2×2 Glance | small/circular | CourseData (既有) |
| 學生證 | 4×2 Glance | medium | UserInfo (新 API) |

## Dart Plugin API

```dart
ApCommonPlugin.configure(appGroupId: '...');     // iOS App Group
ApCommonPlugin.updateCourseWidget(courseData);     // 5 個課程 widget 共用
ApCommonPlugin.clearCourseWidget();
ApCommonPlugin.updateUserInfoWidget(userInfo);     // 學生證 widget
ApCommonPlugin.clearUserInfoWidget();
```

## 已知待處理（本次未做）

- **成績計算差異**：通過/不通過、等第制、抵免課程目前被忽略；研究所及格線應為 70 非 60；平均分數未加權學分
- **slang code gen**：環境無 Dart SDK，.g.dart 檔案是手動更新。正式合併前需要跑 `dart run slang`
- **build_runner**：CustomCourseData 用 plain Dart（非 freezed），因為無法跑 build_runner
- **Widget barcode**：Android 用 ZXing (Code39)、iOS 用 CoreImage (Code128)，格式不同
- **CI 驗證**：環境無 Flutter SDK，未能執行 `melos run analyze-ci` / `melos run test`
