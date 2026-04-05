import 'package:ap_common/ap_common.dart'
    hide AppLocaleUtils, TranslationProvider;
import 'package:ap_common_example_liquid_glass/app.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  registerOneForAll();
  registerApCommonService();
  await (PreferenceUtil.instance as ApPreferenceUtil).init(
    key: encrypt.Key.fromUtf8('l9r1W3wcsnJTayxCXwoFt62w1i4sQ5J9'),
    iv: encrypt.IV.fromUtf8('auc9OV5r0nLwjCAH'),
  );
  runApp(
    LiquidGlassWidgets.wrap(const LiquidGlassExampleApp()),
  );
}
