import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/pages/setting_page.dart';
import 'package:ap_common_example/pages/study/course_page.dart';
import 'package:ap_common_example/pages/study/score_page.dart';
import 'package:flutter/material.dart';

/// Demonstrates [HomePageScaffold] with bottom tab navigation
/// using [IndexedStack] and per-tab [Navigator]s.
class TabHomePage extends StatelessWidget {
  const TabHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePageScaffold(
      tabs: <HomeTab>[
        HomeTab(
          icon: Icon(ApIcon.home),
          label: context.ap.home,
          builder: (_) => const _HomeTabContent(),
        ),
        HomeTab(
          icon: Icon(ApIcon.classIcon),
          label: context.ap.course,
          builder: (_) => CoursePage(),
        ),
        HomeTab(
          icon: Icon(ApIcon.assignment),
          label: context.ap.score,
          builder: (_) => ScorePage(),
        ),
        HomeTab(
          icon: Icon(ApIcon.settings),
          label: context.ap.settings,
          builder: (_) => SettingPage(),
        ),
      ],
    );
  }
}

class _HomeTabContent extends StatelessWidget {
  const _HomeTabContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.ap.home),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text('Item ${index + 1}'),
            subtitle: const Text(
              'Tap to navigate within tab',
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) =>
                      _DetailPage(index: index + 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  const _DetailPage({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail #$index')),
      body: Center(
        child: Text(
          'Detail page for item #$index\n\n'
          'This page is inside the tab '
          'Navigator.\n'
          'Press back to return to the list.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
