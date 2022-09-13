import 'package:ap_common/utils/cloud_message_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

export 'package:ap_common/models/cloud_message.dart';

class ApHiveUtils {
  ApHiveUtils() {
    Hive.registerAdapter(CloudMessageAdapter());
  }

  static const String boxName = 'RemoteMessageList';

  static ApHiveUtils? _instance;

  // ignore: prefer_constructors_over_static_methods
  static ApHiveUtils get instance {
    return _instance ?? ApHiveUtils();
  }

  Future<void> init() async {
    await Hive.initFlutter();
    await CloudMessageUtils.instance.initBox();
  }
}
