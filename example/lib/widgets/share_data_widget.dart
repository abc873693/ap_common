import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../app.dart';

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({this.data, Widget child}) : super(child: child);

  final MyAppState data;

  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return true;
  }
}
