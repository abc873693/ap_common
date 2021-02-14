## [0.13.0-dev.1] - 2021/02/14
### [Break Change]

* 遷移 `toast` package 至本專案(因原作者未上傳 pub.dev)

## [0.12.0] - 2021/02/13
### [Break Change]

* 遷移 Flutter v1.25 按鈕
* 移除 `PhoneScaffold` 及 `NotificationScaffold` 中 setCurrentScreen & logEvent 參數，改由內部呼叫 `AnalyticsUtils`

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

* 強制將ApTheme過場主題套用 [cupertino_back_gesture](https://pub.dev/packages/cupertino_back_gesture) 若不支援請將使用 `MaterialPageRoute`

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
