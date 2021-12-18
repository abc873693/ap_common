import 'package:flutter/material.dart';

/// Copy from https://github.com/appdev/FlutterToast
/// Source Code https://github.com/appdev/FlutterToast/blob/4d446c80a1807094a3e10c8293e4b7f3c6429f9d/lib/toast.dart
class Toast {
  static const int lengthShort = 1;
  static const int lengthLong = 2;
  static const int bottom = 0;
  static const int center = 1;
  static const int top = 2;

  static void show(
    String? msg,
    BuildContext context, {
    int duration = 1,
    int gravity = 0,
    Color backgroundColor = const Color(0xAA000000),
    TextStyle textStyle = const TextStyle(fontSize: 15, color: Colors.white),
    double backgroundRadius = 20,
    bool rootNavigator = false,
    Border? border,
  }) {
    ToastView.dismiss();
    ToastView.createView(
      msg,
      context,
      duration,
      gravity,
      backgroundColor,
      textStyle,
      backgroundRadius,
      border,
      rootNavigator: rootNavigator,
    );
  }
}

class ToastView {
  static final ToastView _singleton = ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static Future<void> createView(
    String? msg,
    BuildContext context,
    int duration,
    int gravity,
    Color background,
    TextStyle textStyle,
    double backgroundRadius,
    Border? border, {
    bool rootNavigator = false,
  }) async {
    overlayState = Overlay.of(context, rootOverlay: rootNavigator);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
        widget: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(backgroundRadius),
                border: border,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Text(msg ?? '', softWrap: true, style: textStyle),
            ),
          ),
        ),
        gravity: gravity,
      ),
    );
    _isVisible = true;
    overlayState?.insert(_overlayEntry!);
    // ignore: always_specify_types
    await Future.delayed(Duration(seconds: duration));
    dismiss();
  }

  static Future<void> dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    Key? key,
    required this.widget,
    required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: gravity == 2 ? MediaQuery.of(context).viewInsets.top + 50 : null,
      bottom:
          gravity == 0 ? MediaQuery.of(context).viewInsets.bottom + 50 : null,
      child: Material(
        color: Colors.transparent,
        child: widget,
      ),
    );
  }
}
