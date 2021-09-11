# 校務通系列 Firebase 共用

基於應用校務通系列使用到 Firebase 的功能製作的函式庫

## 套件使用要求
 - Flutter `v1.20` 以上


## Firebase 支援列表

|    名稱    | Android | iOS | MacOS | Web |
|:---------:|:-------:|:---:|:-----:|:---:|
| `firebase_core`️ |    ✔️    |  ✔️  |   ✔️   |  ✔️  |
| `firebase_analytics`️ |    ✔️    |  ✔️  |   ✔️   |  ✔️  |
| `firebase_crashlytics`️ |    ✔️    |  ✔️  |   ️   |    ️  |
| `firebase_messaging`️ |    ✔️    |  ✔️  |   ✔️   |  ✔️  |
| `firebase_remote_config`️ |    ✔️    |  ✔️  |   ✔️   |    |
| `firebase_performance`️ |    ✔️    |  ✔️  |  ️   |  ✔️ |

## Getting Started

在 `pubspec.yaml` 中加入 package

```yaml
    ap_common_firebase: ^0.11.0
```

執行加入套件

```bash
  $ flutter package get
```

參考 [FlutterFire](https://firebase.flutter.dev/docs/overview) 的官方文件，加入對應 Firebase 功能的設定