# ap_common_plugin

[![pub.dev](https://img.shields.io/pub/v/ap_common_plugin.svg?style=flat-square)](https://pub.dev/packages/ap_common_plugin/)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

校務通系列 Native Plugin，提供課表桌面小工具（App Widget）功能。

## 支援平台

| 功能 | Android | iOS | macOS | Web |
|:---:|:-------:|:---:|:-----:|:---:|
| 課表小工具 | ✅ | ✅ | — | — |

## 安裝

```yaml
dependencies:
  ap_common_plugin: ^1.0.1-dev.3
```

## 使用方式

### 1. 初始化（iOS 必要）

在 app 啟動時呼叫 `configure`，設定 App Group ID 以供 WidgetKit extension 讀取資料。Android 會忽略此設定。

```dart
import 'package:ap_common_plugin/ap_common_plugin.dart';

// 在 main() 或 app 初始化時
if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
  await ApCommonPlugin.configure(appGroupId: 'group.com.yourapp.id');
}
```

### 2. 更新課表小工具

取得課表資料後，呼叫 `updateCourseWidget` 推送至原生小工具：

```dart
final CourseData courseData = await fetchCourseData();
await ApCommonPlugin.updateCourseWidget(courseData);
```

- **Android**：寫入 `SharedPreferences`，觸發 `AppWidgetManager` 更新
- **iOS**：寫入 App Group `UserDefaults`，觸發 `WidgetCenter.reloadAllTimelines()`

### 3. 清除課表小工具

登出或需要清除小工具資料時：

```dart
await ApCommonPlugin.clearCourseWidget();
```

### 4. 測試用假資料（Debug）

注入假課程資料以測試小工具顯示，會建立兩筆課程（30 分鐘後、90 分鐘後）：

```dart
if (kDebugMode) {
  await ApCommonPlugin.setFakeCourseWidget();
}
```

## 原生端整合

### Android

Plugin 已包含完整的 `AppWidgetProvider` 實作，App 端只需在 `AndroidManifest.xml` 註冊 receiver：

```xml
<receiver
    android:name="me.rainvisitor.ap_common_plugin.CourseAppWidgetProvider"
    android:exported="true">
    <intent-filter>
        <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
    </intent-filter>
    <meta-data
        android:name="android.appwidget.provider"
        android:resource="@xml/course_appwidget_info" />
</receiver>
```

### iOS

iOS 需要在 Xcode 專案中建立 WidgetKit extension，步驟如下：

#### 1. 建立 Widget Extension

在 Xcode 中 File → New → Target → Widget Extension，命名為 `CourseAppWidget`。

#### 2. 設定 App Group

在主 App 和 Widget Extension 的 Signing & Capabilities 中加入相同的 App Group（例如 `group.com.yourapp.id`）。

#### 3. 建立資料模型

在 Widget Extension 中建立 `CourseData.swift`：

```swift
import Foundation

struct CourseData: Codable {
    let courses: [Course]
    let timeCodes: [TimeCode]
}

struct Course: Codable {
    let code: String
    let title: String
    let className: String?
    let group: String?
    let units: String?
    let hours: String?
    let required: String?
    let at: String?
    let sectionTimes: [SectionTime]
    let location: Location?
    let instructors: [String]

    enum CodingKeys: String, CodingKey {
        case code, title, className, group, units, hours
        case required, at
        case sectionTimes, location, instructors
    }
}

struct Location: Codable {
    let building: String?
    let room: String?
}

struct SectionTime: Codable {
    let weekday: Int
    let index: Int
}

struct TimeCode: Codable {
    let title: String
    let startTime: String
    let endTime: String
}
```

#### 4. 實作 Timeline Provider

在 Widget Extension 中讀取 App Group UserDefaults 的課程資料：

```swift
let defaults = UserDefaults(suiteName: "group.com.yourapp.id")
let json = defaults?.string(forKey: "course_notify")
let courseData = try? JSONDecoder().decode(
    CourseData.self,
    from: Data(json!.utf8)
)
```

> 完整的 iOS Widget 範例程式碼請參考 `ios/CourseAppWidget/` 目錄。

## API 參考

| 方法 | 說明 |
|------|------|
| `ApCommonPlugin.configure({required String appGroupId})` | 設定 iOS App Group ID |
| `ApCommonPlugin.updateCourseWidget(CourseData courseData)` | 更新課表小工具資料 |
| `ApCommonPlugin.clearCourseWidget()` | 清除課表小工具資料 |
| `ApCommonPlugin.setFakeCourseWidget()` | 注入假資料供測試 |
| `ApCommonPlugin.platformVersion` | 取得平台版本字串 |

## 資料流程

```
Dart (CourseData)
  │
  ▼ jsonEncode → MethodChannel
  │
  ├─ Android: SharedPreferences("ap_common_plugin", "course_notify")
  │           → AppWidgetManager.notifyAppWidgetViewDataChanged()
  │
  └─ iOS:     UserDefaults(suiteName: appGroupId)["course_notify"]
              → WidgetCenter.shared.reloadAllTimelines()
```

## 相關連結

- [ap_common](https://pub.dev/packages/ap_common/) — 整合套件
- [ap_common_core](https://pub.dev/packages/ap_common_core/) — `CourseData` 模型定義
