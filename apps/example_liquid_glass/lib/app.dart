import 'package:ap_common_example_liquid_glass/pages/home_page.dart';
import 'package:ap_common_example_liquid_glass/pages/login_page.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:flutter/material.dart';

class LiquidGlassExampleApp extends StatelessWidget {
  const LiquidGlassExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidGlassApApp(
      onGenerateTitle: (_) => 'Liquid Glass Example',
      home: const _RootPage(),
    );
  }
}

class _RootPage extends StatefulWidget {
  const _RootPage();

  @override
  State<_RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<_RootPage> {
  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    if (_isLogin) {
      return GlassMainPage(
        onLogout: () => setState(() => _isLogin = false),
      );
    }
    return GlassLoginPage(
      onLoginSuccess: () =>
          setState(() => _isLogin = true),
    );
  }
}
