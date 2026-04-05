import 'package:ap_common_example_liquid_glass/res/assets.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:flutter/material.dart';

/// Login page using [GlassApLoginPage].
class GlassLoginPage extends StatelessWidget {
  const GlassLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassApLoginPage(
      logoMode: LogoMode.image,
      logoSource: ImageAssets.K,
      onLogin: (String username, String password) async {
        await Future<void>.delayed(const Duration(seconds: 1));
        return true;
      },
      enableOfflineLogin: true,
    );
  }
}
