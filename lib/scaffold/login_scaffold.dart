import 'dart:io';

import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

export 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

enum LogoMode { text, image }

class LoginScaffold extends StatefulWidget {
  static const String routerName = "/login";
  final LogoMode logoMode;
  final String logoSource;
  final List<Widget> forms;
  final bool enableKeyboardDoneButton;

  const LoginScaffold({
    Key key,
    @required this.logoSource,
    @required this.forms,
    this.logoMode = LogoMode.text,
    this.enableKeyboardDoneButton = false,
  }) : super(key: key);

  @override
  LoginScaffoldState createState() => LoginScaffoldState();
}

class LoginScaffoldState extends State<LoginScaffold> {

  bool get isTablet => MediaQuery.of(context).size.shortestSide >= 600;

  @override
  void initState() {
    if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS)) &&
        widget.enableKeyboardDoneButton) {
      KeyboardVisibility.onChange.listen(
        (bool visible) {
          if (visible)
            ApUtils.showOverlay(context, ApLocalizations.of(context).done);
          else
            ApUtils.removeOverlay();
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
//    KeyboardVisibility.onChange.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: ApTheme.of(context).blue,
      resizeToAvoidBottomPadding: orientation == Orientation.portrait,
      body: AutofillGroup(
        child: Container(
          alignment: Alignment(0, 0),
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: orientation == Orientation.portrait
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: _renderContent(orientation),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _renderContent(orientation),
                ),
        ),
      ),
    );
  }

  Widget get logo {
    switch (widget.logoMode) {
      case LogoMode.image:
        return Image.asset(
          widget.logoSource,
          width: 120.0,
          height: 120.0,
        );
      case LogoMode.text:
      default:
        return TextLogo(
          text: widget.logoSource,
        );
    }
  }

  _renderContent(Orientation orientation) {
    List<Widget> list = orientation == Orientation.portrait
        ? <Widget>[
            Center(
              child: logo,
            ),
            SizedBox(height: orientation == Orientation.portrait ? 30.0 : 0.0),
          ]
        : <Widget>[
            Expanded(
              child: logo,
            ),
            SizedBox(height: orientation == Orientation.portrait ? 30.0 : 0.0),
          ];
    if (orientation == Orientation.portrait) {
      list.addAll(widget.forms);
    } else {
      list.add(
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.forms,
          ),
        ),
      );
    }
    return list;
  }
}

class TextCheckBox extends StatelessWidget {
  final bool value;
  final String text;
  final ValueChanged<bool> onChanged;

  const TextCheckBox({
    Key key,
    @required this.value,
    @required this.text,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.white,
            ),
            child: Checkbox(
              activeColor: Colors.white,
              checkColor: ApTheme.of(context).blue,
              value: value,
              onChanged: onChanged,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      onTap: (onChanged == null) ? null : () => onChanged(!value),
    );
  }
}

class ApButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const ApButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        padding: EdgeInsets.all(14.0),
        onPressed: onPressed,
        color: Colors.white,
        child: Text(
          text,
          style: TextStyle(color: ApTheme.of(context).blue, fontSize: 18.0),
        ),
      ),
    );
  }
}

class ApFlatButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const ApFlatButton({
    Key key,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}

class TextLogo extends StatelessWidget {
  final String text;

  const TextLogo({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 120,
        color: Colors.white,
      ),
    );
  }
}

class ApTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextInputAction textInputAction;
  final String labelText;
  final Function(String text) onSubmitted;
  final Function(String text) onChanged;
  final bool obscureText;
  final int maxLength;
  final TextInputType keyboardType;
  final Iterable<String> autofillHints;

  const ApTextField({
    Key key,
    @required this.controller,
    @required this.focusNode,
    this.nextFocusNode,
    this.onSubmitted,
    this.labelText = '',
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.autofillHints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      obscureText: obscureText,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      focusNode: focusNode,
      maxLength: maxLength,
      onChanged: onChanged,
      onSubmitted: (text) {
        if (focusNode != null) focusNode.unfocus();
        if (nextFocusNode != null)
          FocusScope.of(context).requestFocus(nextFocusNode);
        if (onSubmitted != null) onSubmitted(text);
      },
      decoration: InputDecoration(
        labelText: labelText,
        counterText: '',
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        decorationColor: Colors.white,
      ),
      autofillHints: autofillHints,
    );
  }
}
