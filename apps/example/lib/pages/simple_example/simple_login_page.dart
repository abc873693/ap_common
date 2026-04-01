import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:flutter/material.dart';

/// Simplified login page using [ApLoginPage].
///
/// Compare with [apps/example/lib/pages/login_page.dart] (~206 lines)
/// — this achieves the same result with just a single widget.
class SimpleLoginPage extends StatelessWidget {
  const SimpleLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ApLoginPage(
      logoMode: LogoMode.image,
      logoSource: ImageAssets.K,
      onLogin: (String username, String password) async {
        // Simulate API login
        await Future<void>.delayed(const Duration(seconds: 1));
        // Return true for success, false for failure, throw for error
        return true;
      },
      enableOfflineLogin: true,
    );
  }
}
