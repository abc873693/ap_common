import 'package:ap_common_example/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({this.data, required Widget child}) : super(child: child);

  final MyAppState? data;

  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return true;
  }
}
