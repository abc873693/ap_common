import 'dart:io';

import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/preferences.dart';
// import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'config/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpClient.enableTimelineLogging = !kIsWeb && kDebugMode;
  await Preferences.init(key: Constants.key, iv: Constants.iv);
  // if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
  //   GoogleSignInDart.register(
  //       clientId:
  //           '141403473068-9gii2blqbggijifq0ijoqkqv8oj2i2ff.apps.googleusercontent.com');
  // }
  ApIcon.code =
      Preferences.getString(Constants.PREF_ICON_STYLE_CODE, ApIcon.OUTLINED);
  runApp(MyApp());
}
