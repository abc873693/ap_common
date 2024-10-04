import 'dart:io';

import 'package:ap_common_core/ap_common_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigUtils {
  static FirebaseRemoteConfigUtils? _instance;

  static FirebaseRemoteConfigUtils get instance {
    return _instance ??= FirebaseRemoteConfigUtils();
  }

  FirebaseRemoteConfigUtils() {
    if (isSupported) remoteConfig = FirebaseRemoteConfig.instance;
  }

  FirebaseRemoteConfig? remoteConfig;

  static bool get isSupported =>
      (kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS);
}

extension RemoteConfigExtension on FirebaseRemoteConfig {
  VersionInfo get versionInfo => VersionInfo(
        code: getInt(ApConstants.appVersion),
        isForceUpdate: getBool(ApConstants.isForceUpdate),
        content: getString(ApConstants.newVersionContent),
      );
}
