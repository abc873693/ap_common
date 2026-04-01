import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/pages/simple_example/simple_home_page.dart';
import 'package:ap_common_example/utils/app_localizations.dart';
import 'package:flutter/material.dart';

/// Simplified app setup using [ApApp].
///
/// Compare with [apps/example/lib/app.dart] which requires ~130 lines
/// for the same functionality.
class SimpleApp extends StatelessWidget {
  const SimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: ApApp(
        home: const SimpleHomePage(),
        onGenerateTitle: (BuildContext context) => context.app.appName,
      ),
    );
  }
}
