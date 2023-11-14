import 'package:ap_common/resources/ap_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

export 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

enum LogoMode { text, image }

class LoginScaffold extends StatefulWidget {
  const LoginScaffold({
    Key? key,
    required this.logoSource,
    required this.forms,
    this.logoMode = LogoMode.text,
  }) : super(key: key);

  final LogoMode logoMode;
  final String logoSource;
  final List<Widget> forms;

  static const String routerName = '/login';

  @override
  LoginScaffoldState createState() => LoginScaffoldState();
}

class LoginScaffoldState extends State<LoginScaffold> {
  bool get isTablet => MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: ApTheme.of(context).blue,
      resizeToAvoidBottomInset: orientation == Orientation.portrait,
      body: AutofillGroup(
        child: KeyboardDismissOnTap(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: orientation == Orientation.portrait
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: _renderContent(orientation),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _renderContent(orientation),
                  ),
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

  List<Widget> _renderContent(Orientation orientation) {
    final List<Widget> list = orientation == Orientation.portrait
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
  const TextCheckBox({
    Key? key,
    required this.value,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final String text;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onChanged == null) ? null : () => onChanged?.call(value),
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
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ApButton extends StatelessWidget {
  const ApButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(14.0),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: ApTheme.of(context).blue, fontSize: 18.0),
        ),
      ),
    );
  }
}

class ApFlatButton extends StatelessWidget {
  const ApFlatButton({
    Key? key,
    this.onPressed,
    this.text,
  }) : super(key: key);

  final Function()? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

class TextLogo extends StatelessWidget {
  const TextLogo({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 120,
        color: Colors.white,
      ),
    );
  }
}

class ApTextField extends StatelessWidget {
  const ApTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
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

  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String labelText;
  final Function(String text)? onSubmitted;
  final Function(String text)? onChanged;
  final bool obscureText;
  final int? maxLength;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      obscureText: obscureText,
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: (String text) {
        focusNode?.unfocus();
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
        onSubmitted?.call(text);
      },
      decoration: InputDecoration(
        labelText: labelText,
        counterText: '',
      ),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        decorationColor: Colors.white,
      ),
      autofillHints: autofillHints,
    );
  }
}
