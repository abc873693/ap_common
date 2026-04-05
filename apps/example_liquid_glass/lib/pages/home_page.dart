import 'package:ap_common_example_liquid_glass/pages/course_page.dart';
import 'package:ap_common_example_liquid_glass/pages/login_page.dart';
import 'package:ap_common_example_liquid_glass/pages/score_page.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:flutter/material.dart';

/// Home page for the Liquid Glass example.
class GlassHomePage extends StatelessWidget {
  const GlassHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = context.ap;

    return AdaptiveLiquidGlassLayer(
      child: Scaffold(
        appBar: GlassAppBar(
        title: const Text('Liquid Glass Example'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              final LiquidGlassApAppState state =
                  LiquidGlassApApp.of(context);
              state.setThemeMode(
                state.themeMode == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildCard(
            context,
            icon: Icons.login,
            title: ap.login,
            subtitle: 'GlassApLoginPage',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const GlassLoginPage(),
              ),
            ),
          ),
          _buildCard(
            context,
            icon: Icons.calendar_today,
            title: ap.course,
            subtitle: 'GlassApCoursePage',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const GlassCoursePage(),
              ),
            ),
          ),
          _buildCard(
            context,
            icon: Icons.assignment,
            title: ap.score,
            subtitle: 'GlassApScorePage',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const GlassScorePage(),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
