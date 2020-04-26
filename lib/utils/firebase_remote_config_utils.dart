import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/version_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

export 'package:ap_common/models/version_info.dart';

class FirebaseRemoteConfigUtils {
  static Future<VersionInfo> getVersionInfo() async {
    RemoteConfig remoteConfig;
    try {
      remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch(expiration: const Duration(seconds: 10));
      await remoteConfig.activateFetched();
      String versionContent =
          remoteConfig.getString(ApConstants.NEW_VERSION_CONTENT);
      return VersionInfo(
        code: remoteConfig.getInt(ApConstants.APP_VERSION),
        content: versionContent,
      );
    } on FetchThrottledException catch (exception) {} catch (exception) {} finally {}
    return null;
  }
}
