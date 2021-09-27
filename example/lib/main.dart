import 'dart:io';

import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';

import 'app.dart';
import 'config/constants.dart';

// ignore_for_file: lines_longer_than_80_chars
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init(key: Constants.key, iv: Constants.iv);
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    GoogleSignInDart.register(
        clientId:
            '141403473068-9gii2blqbggijifq0ijoqkqv8oj2i2ff.apps.googleusercontent.com');
  }
  ApIcon.code =
      Preferences.getString(Constants.PREF_ICON_STYLE_CODE, ApIcon.outlined);
  runApp(const MyApp());
}
