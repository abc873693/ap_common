## [0.23.0-dev.1] - 2023/08/18
### 基於 Flutter v3.10 開發

* 套件相依修正

## [0.23.0-dev.0] - 2023/06/10
### 基於 Flutter v3.10 開發

* Flutter 3.10 相容性更新
* Dio 5 遷移
* 支援 Android 13 相關 API

## [0.22.0] - 2023/04/16

* 同 0.22.0-dev.7 功能

## [0.22.0-dev.7] - 2022/11/01

* 最新消息審查系統加入黑名單功能

## [0.22.0-dev.6] - 2022/09/07

* 加入 `PlatformCalendarUtil` 工具

## [0.22.0-dev.5] - 2022/09/28

* 改善 user info model nullable 設計

## [0.22.0-dev.4] - 2022/09/27

* 回復 json_serialization 版本限制

## [0.22.0-dev.3] - 2022/09/23

* 改善 model nullable 設計

## [0.22.0-dev.2] - 2022/09/18

* 改善 model nullable 設計
* 改善 json_serialization 版本限制

## [0.22.0-dev.1] - 2022/09/08

* 修正最新消息 JSON Key 錯誤
* 修正最新消息 `tags` 物件型態 cast 錯誤

## [0.22.0-dev.0] - 2022/09/02

* 加入課表隱藏選項

## [0.21.2] - 2022/08/11

* 修正 hint error

## [0.21.1] - 2022/07/13

* 修正部分 model 在主專案支援 Null-safety 產生錯誤

## [0.21.0] - 2022/06/23

* 改善部分主題顏色遺失

## [0.21.0-dev.3] - 2022/06/16

* 修正遺失的主題設定

## [0.21.0-dev.2] - 2022/06/16

* 修正 多國語言載入錯誤

## [0.21.0-dev.1] - 2022/06/16

### 基於 Flutter v3.0.2 開發

### [Bad Version]

* 修正 `share` 在 iPad 錯誤
* 改善多國語言無法多次呼叫 `initializeMessages` 的問題

## [0.21.0-dev.0] - 2022/05/24

### [Break Change]

### 基於 Flutter v3.0.0 開發

* Flutter 3 支援更新
* 修正 Image Picker 格式

## [0.20.1] - 2022/02/07

### 基於 Flutter v2.10.2 開發

* 支援 ApTextField Widget Keys

## [0.20.0] - 2022/02/07

### 基於 Flutter v2.10.0 開發

* 移除不支援 android embedding v2 的套件

## [0.19.4] - 2021/12/28

* 修正對話間距 UI

## [0.19.3] - 2021/12/27

### 基於 Flutter v2.8.1 開發

* 修正 `LoginScaffold` UI

## [0.19.2] - 2021/12/20

### 基於 Flutter v2.8.1 開發

* 更新套件至最新版本

## [0.19.1] - 2021/09/27

### 基於 Flutter v2.5.1 開發

* 修正編輯最新消息時的型態錯誤

## [0.19.0] - 2021/09/13

### 基於 Flutter v2.5.0 開發

* 更新大多數套件至最新版本

## [0.18.3] - 2021/09/11

* 修正改密碼相關的文字至多國語言

## [0.18.2] - 2021/09/11

* 修正改密碼相關的文字至多國語言

## [0.18.1] - 2021/09/11

* 新增修改密碼相關的文字至多國語言

## [0.18.0] - 2021/07/20

* 修正追蹤對話框跑版
* 改善桌面版與網頁版圖片儲存
* 改善圖片儲存提示字
* 使用 share_plus 取代 share 以支援全平台

## [0.17.0] - 2021/06/06

### [Break Change]

* 加入 `CloudMessageListPage` 並使用 Hive 實作本地儲存雲端通知

## [0.17.0-dev.4] - 2021/05/24

### [Break Change]

* `NotificationScaffold` 重新命名為 `NotificationListView`
* `PhoneScaffold` 重新命名為 `PhoneListView`
* `PdfScaffold` 重新命名為 `NotificationListView`
* 支援最新消息同權重隨機排序
* 支援登入畫面與最新消息編輯可點擊其他區域關閉鍵盤

## [0.17.0-dev.3] - 2021/05/20

### [Break Change]

* 移除 `OpenSourcePage`
* `AboutUsPage` 加入開啟授權
* 修正最新消息審查系統顯示最新消息錯誤

## [0.17.0-dev.2] - 2021/05/17

### [Break Change]

* 加入 App Tracking 對話框
* 改善多國語言英文文法

## [0.17.0-dev.1] - 2021/05/15

### [Break Change]

* 使用 `linter` 套件改善專案
* 使用 `spider` 生成圖片檔案路徑
* 移除無使用多國語言文字

## [0.16.0] - 2021/05/03

* Null-Safety 版本發佈

## [0.16.0-nullsafety.5] - 2021/05/01

### [Break Change]

* 更改讀取更新紀錄路徑

## [0.16.0-nullsafety.4] - 2021/04/29

### [Break Change]

* 移除舊有 API

## [0.16.0-nullsafety.3] - 2021/04/14

* 修復部分元件空錯誤

## [0.16.0-nullsafety.2] - 2021/04/14

* 修復可選文字錯誤
* 改善 DioError 解析

## [0.16.0-nullsafety.1] - 2021/04/11

* 支援通知可監聽點擊事件

## [0.16.0-nullsafety.0] - 2021/04/09

### [Break Change]

### 基於 Flutter v2.0.3 開發

* Null-Safety 遷移
* 使用 `photo_manager` 取代 `image_gallery_saver` 作為圖片儲存實作
* 移除 `google_sign_in_dartio` 仰賴

## [0.15.1] - 2021/03/06

* 修正選擇相片錯誤

## [0.15.0] - 2021/03/06

### [Break Change]

### 基於 Flutter v2.0.1 開發

* 加入選擇照片在 `ApUtils`
* 改善部分類別單例
* 改善最新消息內容介面
* 改善最新消息審查系統介面

## [0.14.3] - 2021/03/01

* 支援最新消息審查系統 apple 登入設定 bundle id

## [0.14.2] - 2021/02/28

### 基於 Flutter v1.26.0-17.8.pre 開發

* 最新消息審查系統支援標籤
* 改善最新消息審查系統登入流程
* 最新消息審查系統可設定 API Locale
* 最新消息審查系統支援桌面版本上傳至 Imgur
* 改善相關提示字

## [0.14.1] - 2021/02/25

* 嘗試使用 `package_info_plus` 支援全平台

## [0.14.0] - 2021/02/24

* 修復課表結尾日期錯誤
* 修復課表匯出星期位移
* 修改校車相關字眼與中山版本相容

## [0.13.8] - 2021/02/22

* 最新消息審查系統申請加入組織名稱與語言tags

## [0.13.7] - 2021/02/22

* 最新消息審查系統加入是否啟用一般登入

## [0.13.6] - 2021/02/20

* 支援使用 `tags` 取得最新消息

## [0.13.5] - 2021/02/20

* 改善 `ItemPicker` 間距

## [0.13.4] - 2021/02/20

* 加入 `ChageIconStyleItem` 作為設定頁使用
* 設定功能加入分析

## [0.13.3] - 2021/02/20

* 加入 `ChageLanguageItem` 作為設定頁使用
* 加入 `ChangeThemeModeItem` 作為設定頁使用

## [0.13.2] - 2021/02/17

* 修改 `TimeCodeConfig` 使用 `CourseData` 中的 `TimeCode`

## [0.13.1] - 2021/02/16

* 修改 `ApLocalizations` delegate 命名
* 修復 `PdfScaffod` `AnalyticUtils` 空檢查

## [0.13.0] - 2021/02/16

### 基於 Flutter v1.26.0-17.5.pre 開發

* 大部分元件加入抽象分析方法
* `PdfScaffod` 支援列印與分享 pdf 檔案

## [0.13.0-dev.2] - 2021/02/15

### [Break Change]

### 基於 Flutter v1.26.0-17.5.pre 開發

* 移除 `material_design_icons_flutter` 套件相依
* 使用 `printing` 作為 `PdfScaffod` 的套件，移除 `native_pdf_view`

## [0.13.0-dev.1] - 2021/02/14

### [Break Change]

* 遷移 `toast` package 至本專案(因原作者未上傳 pub.dev)

## [0.12.0] - 2021/02/13

### [Break Change]

* 遷移 Flutter v1.25 按鈕
* 移除 `PhoneScaffold` 及 `NotificationScaffold` 中 setCurrentScreen & logEvent
  參數，改由內部呼叫 `AnalyticsUtils`

## [0.12.0-dev.2] - 2021/02/11

### [Break Change]

* 移除 `AnnouncementHomePage` catchException 參數

## [0.12.0-dev.1] - 2021/02/11

### [Break Change]

### 基於 Flutter v1.26.0-17.2.pre 開發

* 改善 `AnalyticsUtils` Interface
* 加入 `CrashlyticsUtils` Interface
* 頁面移除 AnalyticsUtils 相關參數

## [0.11.1] - 2021/02/08

### 基於 Flutter v1.26.0-17.2.pre 開發

* 更新 `GeneralResponse` 參數

## [0.11.0] - 2021/01/30

### [Break Change]

### 基於 Flutter v1.26.0-17.1.pre 開發

* 強制將ApTheme過場主題套用 [cupertino_back_gesture](https://pub.dev/packages/cupertino_back_gesture)
  若不支援請將使用 `MaterialPageRoute`

## [0.11.0-dev.2] - 2021/01/30

### [Break Change]

### 基於 Flutter v1.26.0-12.0.pre 開發

* 修正TimeCode範圍錯誤
* 雙平台儲存照片檢查執行結果
* 修正上課通知weekday錯誤

## [0.11.0-dev.1] - 2021/01/28

### [Break Change]

### 基於 Flutter v1.26.0-12.0.pre 開發

* 課表(CourseData)格式更新
* 支援課表(CourseTable)顯示時間、上課位置、老師

## [0.10.2] - 2021/01/23

### 基於 Flutter v1.25.0-8.3.pre 開發

* 改善最新版本對話框context取得
* 最新消息審查系統加入崩潰參數回傳

## [0.10.1] - 2021/01/08

### 基於 Flutter v1.25.0-8.2.pre 開發

* 修正課表陣列無法新增

## [0.10.0] - 2021/01/08

### 基於 Flutter v1.25.0-8.2.pre 開發

### [Bad Version]

* 新增匯出課表
* 新增最新消息審查系統
* 改善多國語言架構
* 移除Flutter棄用函式庫

## [0.10.0-beta.1] - 2021/01/07

### 基於 Flutter v1.25.0-8.2.pre 開發

### [Bad Version]

* 改善最新消息審查系統錯誤處理
* 移除Flutter棄用函式庫

## [0.10.0-dev.4] - 2021/01/06

### 基於 Flutter v1.26開發

* 最新消息審查系統圖片可上傳至Imgur(Web & 雙平台限定)

## [0.10.0-dev.3] - 2021/01/05

### 基於 Flutter v1.26開發

* 改善多國語言架構
* 改善第三方流程登入提示

## [0.10.0-dev.2] - 2021/01/03

### 基於 Flutter v1.26開發

* 改善最新消息審查系統介面

## [0.10.0-dev.1] - 2021/01/03

### 基於 Flutter v1.26開發

* 新增匯出課表
* 新增最新消息審查系統

## [0.9.1] - 2020/10/24

* 更改學期成績相關文字

## [0.9.0] - 2020/10/23

### [Break Change]

* 支援學期成績元件可點擊
* 更改學期成績骨架預設`finalScore`改成`semesterScore`

## [0.8.2] - 2020/10/17

* 支援部分元件可選取
* 更改學期成績Model格式

## [0.8.1] - 2020/10/11

* 修正 icon 錯誤

## [0.8.0] - 2020/10/10

### [Break Change] 此版本之後基於Flutter v1.22開發

* [API Break Change] 修正 PdfView 初始化錯誤
* 改善 `ApButton` 無法讓 `TextInput.finishAutofillContext()` 啟用錯誤
* 移除 `outline_material_icons` 套件，因為Flutter v1.22 已支援

## [0.8.0-beta.1] - 2020/09/30

* 改善取消通知元件

## [0.7.0-beta.6] - 2020/09/28

* 修正 `shared_preference` 支援 `windows` 判斷式

## [0.7.0-beta.5] - 2020/09/26

* `shared_preference` 支援 `windows`

## [0.7.0-beta.4] - 2020/09/17

* 修正課表加入行事曆日期錯誤
* `url_launcher` 支援 `windows`

## [0.7.0-beta.3] - 2020/09/15

* 改善課表文字可自適應大小

## [0.7.0-beta.2] - 2020/09/10

* 修正自動輪播空指針錯誤
* 修正課表與學期成績骨架平板 breakpoint 錯誤

## [0.7.0-beta] - 2020/09/05

* NotificationUtils API 支援 macOS Desktop
* 修正 NotificationUtils API 支援 `flutter_local_notification` plugin `v1.5.0` 以後的 API

## [0.6.1] - 2020/09/05

* Preferences 支援 Linux Desktop

## [0.6.0] - 2020/09/04

* 升級套件仰賴

## [0.5.4] - 2020/08/28

* 課表支援只顯示夜間課程(time code 最小為10)
* 修正部分多國語言索引錯誤

## [0.5.3] - 2020/08/27

* PdfScaffold 加入狀態管理
* ApIcon 加入 `home` icon

## [0.5.2] - 2020/08/26

* 恢復 flutter_local_notification 至穩定版本
* 重構 NotificationPage 及 PhonePage 至 Scaffold
* 加入大多數 API 文件

## [0.5.1] - 2020/08/25

* 修正 app review API 參考錯誤

## [0.5.0] - 2020/08/25

* 首頁骨架可支援響應式
* 將 app review API 替換成 in_app_review 好支援 macOS版本
* 新增學校資訊頁面
* 新增電話資訊頁面

## [0.4.1] - 2020/08/11

* 將 keyboard_visibility 替換成 flutter_keyboard_visibility
* Android 支援新版app review API by app_review v2.0.1

## [0.4.0] - 2020/08/06

* 升級套件仰賴

## [0.4.0-beta] - 2020/06/03

* 網頁版加入自動填入
* 修正手機版登入骨架鍵盤開啟問題

## [0.3.0] - 2020/05/24

* 修正課表通知位置無顯示

## [0.2.9] - 2020/05/17

* 部分類別新增快取方法
* 改善課表顏色顯示

## [0.2.8] - 2020/05/14

* 修復課表顏色錯誤

## [0.2.7] - 2020/05/14

* 加入學號QR Code和Bar Code顯示
* 改善首頁自動輪播時間與行為
* 改善AnalyticsUtils interface
* ApTheme加入Green
* ApLocalization加入DatetimeLocale

## [0.2.6] - 2020/05/12

* 修正課表骨架的位置名稱錯誤
* Android通知工具使用BigText

## [0.2.5] - 2020/05/10

* 改善課表骨架

## [0.2.4] - 2020/05/09

* 新增PDF骨架
* 更改版本檢查規則
* 加入上課通知查詢元件

## [0.2.3] - 2020/05/09

* 新增課表骨架可加入至行事曆

## [0.2.2] - 2020/05/07

* 移除課表骨架點擊提示
* 暫時修正登入骨架在flutter web 移動裝置無法開啟鍵盤
* 修正大頭照Hero動畫無法啟用

## [0.2.1] - 2020/05/01

* 更改部分套件仰賴範圍
* 登入頁骨架加入可關閉虛擬鍵盤選項
* 加入更多對話框工具
* 課表骨架配合高科大版本更新
* 改善本底通知工具
* 整理多國語言本地化

## [0.2.0] - 2020/05/01

### [Break Change] 此版本之後基於Flutter v1.17開發

* 配合高科大版本重構最新消息API
* 登入骨架加入LOGO可選擇圖片或文字
* 加入最新消息規則對話框工具
* 更改ApTheme的brightness成public parameter
* 修正抽屜是否顯示照片的參數
* 部分頁面加入setCurrentContent參數
* 使用者資訊骨架中圖片藉由UserInfo取得

## [0.1.8] - 2020/04/28

* 改善課表提示字
* 更新多國語言文字

## [0.1.7] - 2020/04/27

* 改善課表快取機制
* 改善最新消息API
* 更新多國語言文字

## [0.1.6] - 2020/04/26

* 將學期成績骨架元件分離
* 修正課表骨架錯誤

## [0.1.5] - 2020/04/25

* 改善學期成績骨架

## [0.1.4] - 2020/04/24

* 更新文字說明
* 加入FB粉專開啟工具

## [0.0.1] - TODO: Add release date.

* TODO: old release.
