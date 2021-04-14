import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/version_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

export 'package:ap_common/models/version_info.dart';
export 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigUtils {
  static Future<VersionInfo?> getVersionInfo() async {
    RemoteConfig remoteConfig;
    try {
      remoteConfig = RemoteConfig.instance;
      await remoteConfig.fetch();
      await remoteConfig.activate();
      return VersionInfo(
        code: remoteConfig.getInt(ApConstants.APP_VERSION),
        isForceUpdate: remoteConfig.getBool(ApConstants.IS_FORCE_UPDATE),
        content: remoteConfig.getString(ApConstants.NEW_VERSION_CONTENT),
      );
    } catch (exception) {} finally {}
    return null;
  }
}
