import 'dart:io';

import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'config/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpClient.enableTimelineLogging = kDebugMode;
  await Preferences.init(key: Constants.key, iv: Constants.iv);
  ApIcon.code =
      Preferences.getString(Constants.PREF_ICON_STYLE_CODE, ApIcon.OUTLINED);
  runApp(MyApp());
}
