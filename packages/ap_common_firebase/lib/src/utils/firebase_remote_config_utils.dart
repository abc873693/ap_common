import 'dart:io';

import 'package:ap_common_core/ap_common_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigUtils {
  FirebaseRemoteConfigUtils() {
    if (isSupported) remoteConfig = FirebaseRemoteConfig.instance;
  }
  static FirebaseRemoteConfigUtils? _instance;

  //ignore: prefer_constructors_over_static_methods
  static FirebaseRemoteConfigUtils get instance {
    return _instance ??= FirebaseRemoteConfigUtils();
  }

  FirebaseRemoteConfig? remoteConfig;

  static bool get isSupported =>
      kIsWeb || Platform.isAndroid || Platform.isIOS || Platform.isMacOS;
}

extension RemoteConfigExtension on FirebaseRemoteConfig {
  VersionInfo get versionInfo => VersionInfo(
        code: getInt(ApConstants.appVersion),
        isForceUpdate: getBool(ApConstants.isForceUpdate),
        content: getString(ApConstants.newVersionContent),
      );
}
