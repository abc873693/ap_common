# CLAUDE.md

## 專案概述

**ap_common** 是一個 Flutter/Dart monorepo，提供 AP（校務通）系列教育類 App（NKUST、NSYSU、WTUC 等）的共用套件。使用 **Melos** 與 **pub workspaces** 管理。

## Tech Stack

- **Dart SDK**: ^3.9.0、**Flutter**: >=3.24.0
- **套件管理**: Melos v7.5.0 搭配 pub workspaces
- **Flutter 版本管理**: FVM（SDK 路徑：`.fvm/flutter_sdk`）
- **HTTP**: Dio
- **序列化**: freezed + json_serializable
- **多語系**: slang（已從 intl 遷移）
- **Lint**: `package:lint/strict.yaml`

## Monorepo 結構

```
packages/
  ap_common_core/              # 純 Dart：資料模型、工具、ApiResult
  ap_common_flutter_core/      # Flutter：多語系、主題、回呼、工具
  ap_common_flutter_platform/  # 平台實作：加密、時區
  ap_common_flutter_ui/        # UI 元件、Scaffold、頁面（Material 3）
  ap_common_announcement_ui/   # 公告服務：API + UI 頁面
  ap_common/                   # 整合套件，re-export 上述套件
  ap_common_firebase/          # Firebase：Firestore、FCM、Analytics
  ap_common_plugin/            # 原生課表小工具
apps/
  example/                     # 範例 App
```

**套件依賴鏈：**
```
ap_common_core
  └─ ap_common_flutter_core
       ├─ ap_common_flutter_platform
       ├─ ap_common_flutter_ui
       │    └─ ap_common_announcement_ui
       └─ (ap_common = 整合套件)
```

## 常用指令

```bash
# 所有指令透過 melos 執行；Flutter SDK 路徑由 FVM 管理
melos run analyze          # dart analyze 所有套件
melos run analyze-ci       # 嚴格分析（--fatal-infos），CI 使用
melos run format           # dart format 所有套件
melos run format-check     # 格式檢查（CI）
melos run test             # flutter test（有 test/ 目錄的套件）
melos run fix              # dart fix --apply
melos run pub-check        # 模擬發布檢查
melos run release          # 正式版發布
melos run release:dev      # 預發布版本
```

## 程式碼風格與慣例

- **Lint 規則**: `package:lint/strict.yaml`，自訂規則在根目錄 `analysis_options.yaml`
- **必須明確指定型別**（`always_specify_types: true`）
- **使用單引號**
- **每行 80 字元限制**
- **建構子排在類別最前面**（`sort_constructors_first`）
- **Commit 訊息**: 使用英文 Conventional Commits（如 `feat(scope):`、`fix(scope):`、`refactor(scope):`）
- **產生的檔案**: `*.g.dart` 排除在分析之外；修改 freezed/json_serializable 模型後需執行 `build_runner`

## API 模式（目前標準）

專案使用 `ApiResult<T>` sealed class 實現型別安全的 API 回應：

```dart
sealed class ApiResult<T> {}
class ApiSuccess<T> extends ApiResult<T> { final T data; }
class ApiError<T> extends ApiResult<T> { final GeneralResponse response; }
class ApiFailure<T> extends ApiResult<T> { final DioException exception; }
```

UI 程式碼使用 `switch` 對 `ApiResult` 進行模式匹配：
```dart
final ApiResult<Data> result = await helper.fetchData();
switch (result) {
  case ApiSuccess(:final data): // 處理成功
  case ApiError(:final response): // 處理預期的 API 錯誤
  case ApiFailure(:final exception): // 處理網路失敗
}
```

錯誤顯示使用 `ApiResult` 的 `showErrorToast` 擴充方法。

## 舊有模式（逐步淘汰中）

`GeneralCallback<T>`（位於 `ap_common_flutter_core/src/callback/`）是舊的 callback 錯誤處理方式。新程式碼**不應**使用。

## CI/CD

- GitHub Actions 工作流程位於 `.github/workflows/`
- CI 執行項目：`analyze-ci`、`format-check`、`test`、`pub-check`
- PR 自動化：`pr_agent.yml`

## 重要備註

- `ap_common_core` 是**純 Dart** 套件（無 Flutter 依賴）
- 圖片上傳工具（Imgur、Imgbb、GitHub）位於 `ap_common_announcement_ui/src/api/`
- Swagger/OpenAPI 規格書：`packages/ap_common/swaggers/announcement_api.json`
