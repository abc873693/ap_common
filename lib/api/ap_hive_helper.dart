import 'package:ap_common/models/cloud_message.dart';
import 'package:ap_common/utils/cloud_message_utils.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

export 'package:ap_common/models/cloud_message.dart';

class ApHiveHelper {
  static const String boxName = 'RemoteMessageList';

  static ApHiveHelper? _instance;

  // ignore: prefer_constructors_over_static_methods
  static ApHiveHelper get instance {
    return _instance ?? ApHiveHelper();
  }

  ApHiveHelper() {
    Hive.registerAdapter(CloudMessageAdapter());
  }

  Future<void> init() async {
    await Hive.initFlutter();
    await CloudMessageUtils.instance.init();
  }
}
