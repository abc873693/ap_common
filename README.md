# 校務通系列介面與函式共用(施工中)

因為長期校務通相關系列的app，介面與相關功能都極為相似，所以特別將相關的介面與函式庫，製作此套件以方便維護使用


## 目前共用項目 Todo List

 - 資源
    - [x] 主題色
        - [x] 基本顏色
        - [x] 淺色主題
        - [x] 深色主題
    - [x] 圖示
        - [x] Outline 
        - [x] Filled 
    - [x] 圖片資源(97KB)
 - 工具類
    - [x] 多國語言
    - [x] 共用函式
     - [x] 提示訊息(Toast - Flutter Level)
    - [x] SharePreferences 包裝
 - 元件
    - [x] 抽屜 `ap_drawer.dart`
    - [x] 一般對話框 `default_dialog.dart`
    - [x] 選項對話框中選項 `dialog_option.dart`
    - [x] 頁面提示 `hint_content.dart`
    - [x] 選項對話框 `option_dialog.dart`
    - [x] 進度對話框 `progress_dialog.dart`
    - [x] 設定頁元件 `setting_widget.dart`
    - [x] 是或否對話框 `yes_no_dialog.dart` 
 - 頁面(pages)
    - [x] 關於我們 `about_us_page`
    - [x] 開放原始碼 `open_source_page`
 - 頁面骨架(scaffold)
    - [x] 課表
    - [x] 成績
    - [x] 首頁
    - [x] 最新消息詳細資訊
    - [ ] 校園資訊
      - [ ] 教務處最新消息
      - [ ] 學校電話
      - [ ] 行事曆
    - [ ] 空堂教室查詢
    - [ ] 登入頁(TBD)
 
## Getting Started

在 `pubspec.yaml` 中加入 package

```yaml
    # 官方多國語套件
    flutter_localizations:
        sdk: flutter
    ap_common:
        git:
          url: https://github.com/abc873693/ap_common
          ref: v0.0.3
          # 不寫ref 預設使用最新的commit 或是改成分支名稱或是commit的hash皆可
```

執行加入套件

```bash
  $ flutter package get
```

在MaterialApp 上一層加入主題色模式(ThemeMode)設定 否則無法正常顯示  
此功能只支援flutter v1.9 以上的SDK

```dart
    ThemeMode themeMode = ThemeMode.system;

    @override
      Widget build(BuildContext context) {
        return ApTheme(
            themeMode,
            child: MaterialApp(
              // (選擇)是否加入 
              theme: ApTheme.light,
              darkTheme: ApTheme.dark,
              themeMode: themeMode,
            ),
        );
    }

```
### 多國語言支援列表
 - 繁體中文(zh)
 - 英文(en)

在MaterialApp 加入多國語言支援(有使用到ApLocalization才需要)

```dart
    ThemeMode themeMode = ThemeMode.system;

    @override
      Widget build(BuildContext context) {
        return MaterialApp(
              // 在此設定使用的語言，否則會按照系統提供語言，若為不支援語言 預設為英文
              localeResolutionCallback:
                    (Locale locale, Iterable<Locale> supportedLocales) {
                  return locale;
                },
               localizationsDelegates: [
                const ApLocalizationsDelegate(),
              ],
              supportedLocales: [
                const Locale('en', 'US'), // English
                const Locale('zh', 'TW'), // Chinese
              ],
            );
    }

```

## widgets

此項目必須加入主題色設定，否則會無法正常使用

//TODO 文件

## pages

此項目必須加入多國語言設定，否則會無法正常使用

//TODO 文件
