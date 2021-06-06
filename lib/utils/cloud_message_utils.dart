import 'package:ap_common/utils/ap_hive_utils.dart';
import 'package:hive/hive.dart';

export 'package:ap_common/models/cloud_message.dart';
export 'package:hive/hive.dart';

class CloudMessageUtils {
  static const String boxName = 'RemoteMessageList';

  static CloudMessageUtils? _instance;

  Box<CloudMessage> get box => Hive.box<CloudMessage>(boxName);

  // ignore: prefer_constructors_over_static_methods
  static CloudMessageUtils get instance {
    return _instance ?? CloudMessageUtils();
  }

  Future<void> initBox() async {
    await Hive.openBox<CloudMessage>(boxName);
  }
}
