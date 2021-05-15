import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/version_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

export 'package:ap_common/models/version_info.dart';
export 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigUtils {
  @deprecated
  static Future<VersionInfo?> getVersionInfo() async {
    RemoteConfig remoteConfig;
    try {
      remoteConfig = RemoteConfig.instance;
      await remoteConfig.fetch();
      await remoteConfig.activate();
      return VersionInfo(
        code: remoteConfig.getInt(ApConstants.appVersion),
        isForceUpdate: remoteConfig.getBool(ApConstants.isForceUpdate),
        content: remoteConfig.getString(ApConstants.newVersionContent),
      );
    } catch (exception) {} finally {}
    return null;
  }
}

extension RemoteConfigExtension on RemoteConfig {
  VersionInfo get versionInfo => VersionInfo(
        code: getInt(ApConstants.appVersion),
        isForceUpdate: getBool(ApConstants.isForceUpdate),
        content: getString(ApConstants.newVersionContent),
      );
}
