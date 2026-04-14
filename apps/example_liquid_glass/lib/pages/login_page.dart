import 'package:ap_common_example_liquid_glass/res/assets.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:flutter/material.dart';

/// Login page using [GlassLoginScaffold] with glass widgets.
class GlassLoginPage extends StatefulWidget {
  const GlassLoginPage({
    super.key,
    required this.onLoginSuccess,
  });

  final VoidCallback onLoginSuccess;

  @override
  State<GlassLoginPage> createState() =>
      _GlassLoginPageState();
}

class _GlassLoginPageState extends State<GlassLoginPage> {
  final TextEditingController _username =
      TextEditingController();
  final TextEditingController _password =
      TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = context.ap;
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return GlassLoginScaffold(
      logoMode: LogoMode.image,
      logoSource: ImageAssets.K,
      forms: <Widget>[
        TextField(
          controller: _username,
          focusNode: _usernameFocus,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) =>
              _passwordFocus.requestFocus(),
          style: TextStyle(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: ap.studentId,
            hintStyle: TextStyle(
              color: colorScheme.onSurface
                  .withAlpha(128),
            ),
            filled: false,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.onSurface
                    .withAlpha(77),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.onSurface
                    .withAlpha(77),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.primary,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _password,
          focusNode: _passwordFocus,
          obscureText: true,
          textInputAction: TextInputAction.send,
          onSubmitted: (_) => _login(),
          style: TextStyle(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: ap.password,
            hintStyle: TextStyle(
              color: colorScheme.onSurface
                  .withAlpha(128),
            ),
            filled: false,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.onSurface
                    .withAlpha(77),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.onSurface
                    .withAlpha(77),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(10),
              borderSide: BorderSide(
                color: colorScheme.primary,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        GlassButton.custom(
          onTap: _login,
          width: double.infinity,
          height: 48,
          shape: const LiquidRoundedSuperellipse(
            borderRadius: 12,
          ),
          child: Text(
            ap.login,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _login() async {
    final ApLocalizations ap = context.ap;

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
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: GlassCard(
            useOwnLayer: true,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const GlassProgressIndicator
                    .circular(),
                const SizedBox(height: 16),
                Text(ap.logining),
              ],
            ),
          ),
        ),
      ),
    );

    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    widget.onLoginSuccess();
  }
}
