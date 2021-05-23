# 校務通系列介面與函式共用

[![](https://img.shields.io/badge/Flutter-v2.0.0-blue)](https://github.com/flutter/flutter)
[![](https://img.shields.io/pub/v/ap_common.svg?style=flat-square)](https://pub.dev/packages/ap_common/)

長期校務通相關系列的app，介面與相關功能都極為相似，將相關的介面與函式庫，製作此套件以方便維護。

[展示網頁](https://abc873693.github.io/ap_common/#/)

## 相關專案
- [高科校務通](https://github.com/NKUST-ITC/NKUST-AP-Flutter)
- [中山校務通](https://github.com/abc873693/NSYSU-AP)
- [文藻校務通](https://github.com/abc873693/WTUC-AP)
- [台科校務通](https://github.com/abc873693/NTUST-AP)

## 套件使用要求
 - Flutter `v1.20` 以上

## 共用項目

 - 資源
    - [x] [主題切換](#主題色設定)
    - [x] 圖示
        - [x] Outline 
        - [x] Filled 
    - [x] 圖片資源(97KB)
 - 工具類
    - [x] [多國語言](#多國語言支援列表)
    - [x] [共用函式](#共用函式)
    - [x] [Notification 工具](#Notification-工具)
    - [x] [Dialog 工具](#Dialog-工具)
    - [x] [SharePreferences 工具](#SharePreferences-工具)
 - 元件
    - [x] [抽屜](#抽屜-apdrawer)
    - [x] [網路圖片](#抽屜-ApNetworkImage)
    - [x] [一般對話框](#一般對話框-DefaultDialog)
    - [x] [選項對話框中選項](#選項對話框中選項-DialogOption)
    - [x] [頁面提示](#頁面提示-HintContent)
    - [x] [選項選擇器](#選項選擇器-ItemPiccker)
    - [x] [選項對話框](#選項對話框-SimpleOptionDialog)
    - [x] [進度對話框](#進度對話框-ProgressDialog)
    - [x] [設定頁元件](#設定頁元件-SettingPageWidget)
    - [x] [是或否對話框](#是或否對話框-YesNoDialog) 
 - 頁面(pages)
    - [x] [關於我們](#關於我們-AboutUsPage)
    - [x] [開放原始碼](#開放原始碼-OpenSourcePage)
    - [x] [最新消息詳細資訊](#最新消息詳細資訊-AnnouncementContentPage)
 - 頁面骨架(scaffold)
    - [x] [課表](#課表骨架-CoursesCaffold)
    - [x] [成績](#成績骨架-ScoresSaffold)
    - [x] [首頁](#首頁骨架-HomeScaffold)
    - [ ] 空堂教室查詢
    - [x] [登入頁](#首頁骨架-LoginScaffold)
    - [x] [圖片瀏覽器](#圖片瀏覽器骨架-ImageViewerScaffold)
    - [x] [PDF](#PDF骨架-PdfScaffold)
    - [x] [使用者資訊](#使用者資訊骨架-UserInfoScaffold)
    - [x] [校園最新消息](#校園最新消息骨架-NotificationScaffold)
    - [x] [學校電話](#學校電話骨架-PhoneScaffold)
 
## Getting Started

在 `pubspec.yaml` 中加入 package

```yaml
    # 官方多國語套件
    flutter_localizations:
        sdk: flutter
    ap_common: ^0.12.1
```

執行加入套件

```bash
  $ flutter package get
```
