import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/scaffold/glass_login_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A ready-to-use glass login page with built-in preference
/// handling for remember password and auto-login.
///
/// This is the glass-enhanced equivalent of [ApLoginPage].
class GlassApLoginPage extends StatefulWidget {
  const GlassApLoginPage({
    super.key,
    required this.logoSource,
    required this.onLogin,
    this.logoMode = LogoMode.text,
    this.enableOfflineLogin = false,
    this.onOfflineLogin,
    this.extraForms,
    this.usernamePreferenceKey = 'pref_username',
    this.passwordPreferenceKey = 'pref_password',
    this.rememberPasswordPreferenceKey =
        'pref_remember_password',
    this.autoLoginPreferenceKey = 'pref_auto_login',
  });

  final LogoMode logoMode;
  final String logoSource;
  final Future<bool> Function(
    String username,
    String password,
  ) onLogin;
  final bool enableOfflineLogin;
  final Future<bool> Function(
    String username,
    String password,
  )? onOfflineLogin;
  final List<Widget>? extraForms;
  final String usernamePreferenceKey;
  final String passwordPreferenceKey;
  final String rememberPasswordPreferenceKey;
  final String autoLoginPreferenceKey;

  @override
  State<GlassApLoginPage> createState() =>
      _GlassApLoginPageState();
}

class _GlassApLoginPageState
    extends State<GlassApLoginPage> {
  ApLocalizations get ap => context.ap;

  final TextEditingController _username =
      TextEditingController();
  final TextEditingController _password =
      TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _isRememberPassword = true;
  bool _isAutoLogin = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _loadPreferences() {
    _isRememberPassword = PreferenceUtil.instance
        .getBool(
          widget.rememberPasswordPreferenceKey,
          true,
        );
    _isAutoLogin = PreferenceUtil.instance.getBool(
      widget.autoLoginPreferenceKey,
      false,
    );
    setState(() {
      _username.text = PreferenceUtil.instance
          .getString(
            widget.usernamePreferenceKey,
            '',
          );
      _password.text = _isRememberPassword
          ? PreferenceUtil.instance.getStringSecurity(
              widget.passwordPreferenceKey,
              '',
            )
          : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassLoginScaffold(
      logoMode: widget.logoMode,
      logoSource: widget.logoSource,
      forms: <Widget>[
        ApTextField(
          controller: _username,
          keyboardType: TextInputType.emailAddress,
          focusNode: _usernameFocus,
          nextFocusNode: _passwordFocus,
          labelText: ap.studentId,
          autofillHints: const <String>[
            AutofillHints.username,
          ],
        ),
        ApTextField(
          obscureText: true,
          textInputAction: TextInputAction.send,
          controller: _password,
          focusNode: _passwordFocus,
          onSubmitted: (_) {
            _passwordFocus.unfocus();
            _login();
          },
          labelText: ap.password,
          autofillHints: const <String>[
            AutofillHints.password,
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: <Widget>[
            TextCheckBox(
              text: ap.autoLogin,
              value: _isAutoLogin,
              onChanged: (bool? value) {
                setState(() {
                  _isAutoLogin = value ?? false;
                  _isRememberPassword = _isAutoLogin;
                  _saveLoginPreferences();
                });
              },
            ),
            TextCheckBox(
              text: ap.rememberPassword,
              value: _isRememberPassword,
              onChanged: (bool? value) {
                setState(() {
                  _isRememberPassword =
                      value ?? false;
                  if (!_isRememberPassword) {
                    _isAutoLogin = false;
                  }
                  _saveLoginPreferences();
                });
              },
            ),
          ],
        ),
        if (widget.extraForms != null)
          ...widget.extraForms!,
        const SizedBox(height: 8.0),
        ApButton(
          text: ap.login,
          onPressed: _login,
        ),
        if (widget.enableOfflineLogin)
          ApFlatButton(
            text: ap.offlineLogin,
            onPressed: _offlineLogin,
          ),
      ],
    );
  }

  void _saveLoginPreferences() {
    PreferenceUtil.instance.setBool(
      widget.autoLoginPreferenceKey,
      _isAutoLogin,
    );
    PreferenceUtil.instance.setBool(
      widget.rememberPasswordPreferenceKey,
      _isRememberPassword,
    );
  }

  Future<void> _login() async {
    if (_username.text.isEmpty ||
        _password.text.isEmpty) {
      UiUtil.instance.showToast(
        context,
        ap.doNotEmpty,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: ProgressDialog(ap.logining),
      ),
      barrierDismissible: false,
    );

    try {
      final bool success = await widget.onLogin(
        _username.text,
        _password.text,
      );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();

      if (success) {
        _saveCredentials();
        TextInput.finishAutofillContext();
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      UiUtil.instance
          .showToast(context, e.toString());
    }
  }

  void _saveCredentials() {
    PreferenceUtil.instance.setString(
      widget.usernamePreferenceKey,
      _username.text,
    );
    if (_isRememberPassword) {
      PreferenceUtil.instance.setStringSecurity(
        widget.passwordPreferenceKey,
        _password.text,
      );
    }
  }

  Future<void> _offlineLogin() async {
    if (widget.onOfflineLogin != null) {
      final bool success =
          await widget.onOfflineLogin!(
        _username.text,
        _password.text,
      );
      if (success && mounted) {
        Navigator.of(context).pop(true);
      }
      return;
    }

    final String savedUsername =
        PreferenceUtil.instance.getString(
      widget.usernamePreferenceKey,
      '',
    );
    final String savedPassword =
        PreferenceUtil.instance.getStringSecurity(
      widget.passwordPreferenceKey,
      '',
    );

    if (savedUsername.isEmpty ||
        savedPassword.isEmpty) {
      UiUtil.instance.showToast(
        context,
        ap.noOfflineLoginData,
      );
    } else if (savedUsername != _username.text ||
        savedPassword != _password.text) {
      UiUtil.instance.showToast(
        context,
        ap.offlineLoginPasswordError,
      );
    } else {
      UiUtil.instance.showToast(
        context,
        ap.loadOfflineData,
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }
}
