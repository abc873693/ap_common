import 'package:ap_common/scaffold/login_scaffold.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/preferences.dart';
import 'package:ap_common/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/constants.dart';
import '../res/assets.dart';

class LoginPage extends StatefulWidget {
  static const String routerName = '/login';

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  ApLocalizations ap;

  final _username = TextEditingController();
  final _password = TextEditingController();

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool isRememberPassword = true;
  bool isAutoLogin = false;

  int gravity = Toast.bottom;

  @override
  void initState() {
    _getPreference();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ap = ApLocalizations.of(context);
    return LoginScaffold(
      logoMode: LogoMode.image,
      logoSource: ImageAssets.K,
      forms: <Widget>[
        ApTextField(
          controller: _username,
          keyboardType: TextInputType.emailAddress,
          focusNode: usernameFocusNode,
          nextFocusNode: passwordFocusNode,
          labelText: ap.studentId,
          autofillHints: const [AutofillHints.username],
        ),
        ApTextField(
          obscureText: true,
          textInputAction: TextInputAction.send,
          controller: _password,
          focusNode: passwordFocusNode,
          onSubmitted: (text) {
            passwordFocusNode.unfocus();
            _login();
          },
          labelText: ap.password,
          autofillHints: const [AutofillHints.password],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextCheckBox(
              text: ap.autoLogin,
              value: isAutoLogin,
              onChanged: _onAutoLoginChanged,
            ),
            TextCheckBox(
              text: ap.rememberPassword,
              value: isRememberPassword,
              onChanged: _onRememberPasswordChanged,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ApButton(
          text: ap.login,
          onPressed: () {
            _login();
          },
        ),
        ApFlatButton(
          text: ap.offlineLogin,
          onPressed: _offlineLogin,
        ),
//        ApFlatButton(
//          text: ap.searchUsername,
//          onPressed: () async {
//            var username = await Navigator.push(
//              context,
//              CupertinoPageRoute(
//                builder: (_) => SearchStudentIdPage(),
//              ),
//            );
//            if (username != null && username is String) {
//              setState(() {
//                _username.text = username;
//              });
//              ApUtils.showToast(context, ap.firstLoginHint);
//            }
//          },
//        )
      ],
    );
  }

  Future<void> _onRememberPasswordChanged(bool value) async {
    setState(() {
      isRememberPassword = value;
      if (!isRememberPassword) isAutoLogin = false;
      Preferences.setBool(Constants.PREF_AUTO_LOGIN, isAutoLogin);
      Preferences.setBool(Constants.PREF_REMEMBER_PASSWORD, isRememberPassword);
    });
  }

  Future<void> _onAutoLoginChanged(bool value) async {
    setState(() {
      isAutoLogin = value;
      isRememberPassword = isAutoLogin;
      Preferences.setBool(Constants.PREF_AUTO_LOGIN, isAutoLogin);
      Preferences.setBool(Constants.PREF_REMEMBER_PASSWORD, isRememberPassword);
    });
  }

  Future<void> _getPreference() async {
    isRememberPassword =
        Preferences.getBool(Constants.PREF_REMEMBER_PASSWORD, true);
    isAutoLogin = Preferences.getBool(Constants.PREF_AUTO_LOGIN, false);
    setState(() {
      _username.text = Preferences.getString(Constants.PREF_USERNAME, '');
      _password.text = isRememberPassword
          ? Preferences.getStringSecurity(Constants.PREF_PASSWORD, '')
          : '';
    });
  }

  Future<void> _login() async {
    if (_username.text.isEmpty || _password.text.isEmpty) {
      ApUtils.showToast(context, ap.doNotEmpty, gravity: gravity);
    } else {
      asyncLogin();
    }
  }

  void asyncLogin() {
    showDialog(
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: ProgressDialog(ap.logining),
      ),
      barrierDismissible: false,
    );
    Preferences.setString(Constants.PREF_USERNAME, _username.text);
    Navigator.of(context, rootNavigator: true).pop();
    Preferences.setString(Constants.PREF_USERNAME, _username.text);
    if (isRememberPassword) {
      Preferences.setStringSecurity(Constants.PREF_PASSWORD, _password.text);
    }
    Preferences.setBool(Constants.PREF_IS_OFFLINE_LOGIN, false);
    TextInput.finishAutofillContext();
    Navigator.of(context).pop(true);
  }

  Future<void> _offlineLogin() async {
    final String username = Preferences.getString(Constants.PREF_USERNAME, '');
    final String password =
        Preferences.getStringSecurity(Constants.PREF_PASSWORD, '');
    if (username.isEmpty || password.isEmpty) {
      ApUtils.showToast(context, ap.noOfflineLoginData);
    } else {
      if (username != _username.text || password != _password.text) {
        ApUtils.showToast(context, ap.offlineLoginPasswordError);
      } else {
        Preferences.setBool(Constants.PREF_IS_OFFLINE_LOGIN, true);
        ApUtils.showToast(context, ap.loadOfflineData);
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<void> clearSetting() async {
    Preferences.setBool(Constants.PREF_AUTO_LOGIN, false);
    setState(() {
      isAutoLogin = false;
    });
  }
}
