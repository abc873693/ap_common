import 'package:ap_common_example_liquid_glass/pages/home_page.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:flutter/material.dart';

class LiquidGlassExampleApp extends StatelessWidget {
  const LiquidGlassExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidGlassApApp(
      home: const GlassHomePage(),
      onGenerateTitle: (_) => 'Liquid Glass Example',
    );
  }
}
