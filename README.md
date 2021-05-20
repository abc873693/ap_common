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
| `firebase_performance`️ |    ✔️    |  ✔️  |  ️   |    |

## Getting Started

在 `pubspec.yaml` 中加入 package

v0.5.0 版本以後

```yaml
    ap_common_firebase: ^0.5.0
```


v0.5.0 版本以前

```yaml
  ap_common_firebase:
    git:
      url: https://github.com/abc873693/ap_common_firebase
      ref: v0.5.0
```

執行加入套件

```bash
  $ flutter package get
```