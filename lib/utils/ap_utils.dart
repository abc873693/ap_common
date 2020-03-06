import 'package:ap_common/resources/ap_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

class ApUtils {
  static void showToast(BuildContext context, String message) {
    Toast.show(
      message,
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      textColor: ApTheme.of(context).toastText,
      backgroundColor: ApTheme.of(context).toastBackground,
    );
  }

  static pushCupertinoStyle(BuildContext context, Widget page) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (BuildContext context) {
        return page;
      }),
    );
  }
}
