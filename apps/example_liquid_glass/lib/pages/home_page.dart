import 'package:ap_common_announcement_ui/ap_common_announcement_ui.dart';
import 'package:ap_common_example_liquid_glass/pages/course_page.dart';
import 'package:ap_common_example_liquid_glass/pages/score_page.dart';
import 'package:ap_common_example_liquid_glass/res/assets.dart';
import 'package:ap_common_liquid_glass/ap_common_liquid_glass.dart';
import 'package:flutter/material.dart';

/// Main page after login with bottom tab navigation.
class GlassMainPage extends StatefulWidget {
  const GlassMainPage({
    super.key,
    required this.onLogout,
  });

  final VoidCallback onLogout;

  @override
  State<GlassMainPage> createState() =>
      _GlassMainPageState();
}

class _GlassMainPageState extends State<GlassMainPage> {
  int _selectedIndex = 0;

  HomeState _homeState = HomeState.loading;
  List<Announcement> _announcements = <Announcement>[];

  @override
  void initState() {
    super.initState();
    _getAnnouncements();
  }

  Future<void> _getAnnouncements() async {
    final ApiResult<List<Announcement>> result =
        await AnnouncementHelper.instance
            .getAnnouncements(tags: <String>[]);
    if (!mounted) return;
    switch (result) {
      case ApiSuccess<List<Announcement>>(
        :final List<Announcement> data,
      ):
        setState(() {
          _announcements = data;
          _homeState = data.isEmpty
              ? HomeState.empty
              : HomeState.finish;
        });
      case ApiFailure<List<Announcement>>():
      case ApiError<List<Announcement>>():
        setState(() => _homeState = HomeState.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = context.ap;

    return AdaptiveLiquidGlassLayer(
      child: Scaffold(
        drawer: _buildDrawer(context, ap),
        body: Stack(
          children: <Widget>[
            IndexedStack(
              index: _selectedIndex,
              children: <Widget>[
                _buildHomeTab(),
                const GlassCoursePage(),
                const GlassScorePage(),
                _buildSettingsTab(),
              ],
            ),
            Positioned(
              left: 16,
              right: MediaQuery.of(context)
                      .size
                      .width *
                  0.2,
              bottom:
                  MediaQuery.of(context)
                      .padding
                      .bottom +
                  8,
              child: Builder(
                builder: (BuildContext ctx) {
                  final bool isDark =
                      Theme.of(ctx).brightness ==
                          Brightness.dark;
                  final Color iconColor = isDark
                      ? Colors.white
                      : Colors.black;
                  return GlassBottomBar(
                    tabs: <GlassBottomBarTab>[
                      GlassBottomBarTab(
                        icon: Icon(ApIcon.home),
                        label: ap.home,
                      ),
                      GlassBottomBarTab(
                        icon: Icon(ApIcon.classIcon),
                        label: ap.course,
                      ),
                      GlassBottomBarTab(
                        icon: Icon(ApIcon.assignment),
                        label: ap.score,
                      ),
                      GlassBottomBarTab(
                        icon: Icon(ApIcon.person),
                        label: ap.settings,
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabSelected: (int index) {
                      setState(
                        () =>
                            _selectedIndex = index,
                      );
                    },
                    barHeight: 52,
                    barBorderRadius: 26,
                    horizontalPadding: 10,
                    verticalPadding: 10,
                    iconSize: 22,
                    selectedIconColor: iconColor,
                    unselectedIconColor:
                        iconColor.withAlpha(153),
                    textStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: iconColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return GlassHomePageScaffold(
      state: _homeState,
      announcements: _announcements,
      isLogin: true,
      title: 'Liquid Glass',
      bottomPadding: 80,
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
          iconSize: 22,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
        ),
      ],
      onImageTapped: (Announcement announcement) {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) =>
                GlassAnnouncementContentPage(
              announcement: announcement,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawer(
    BuildContext context,
    ApLocalizations ap,
  ) {
    return GlassApDrawer(
      imageAsset: ImageAssets.K,
      userInfo: const UserInfo(
        id: 'C000000000',
        name: 'AP Example',
        className: '資工四甲',
        department: '資訊工程系',
      ),
      onTapHeader: () {},
      widgets: <Widget>[
        DrawerItem(
          icon: ApIcon.home,
          title: ap.home,
          onTap: () {
            Navigator.pop(context);
            setState(() => _selectedIndex = 0);
          },
        ),
        DrawerItem(
          icon: ApIcon.classIcon,
          title: ap.course,
          onTap: () {
            Navigator.pop(context);
            setState(() => _selectedIndex = 1);
          },
        ),
        DrawerItem(
          icon: ApIcon.assignment,
          title: ap.score,
          onTap: () {
            Navigator.pop(context);
            setState(() => _selectedIndex = 2);
          },
        ),
        DrawerItem(
          icon: ApIcon.settings,
          title: ap.settings,
          onTap: () {
            Navigator.pop(context);
            setState(() => _selectedIndex = 3);
          },
        ),
        const GlassDivider(),
        DrawerItem(
          icon: ApIcon.powerSettingsNew,
          title: ap.logout,
          onTap: () {
            Navigator.pop(context);
            widget.onLogout();
          },
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    final ApLocalizations ap = context.ap;
    final LiquidGlassApAppState appState =
        LiquidGlassApApp.of(context);

    return AdaptiveLiquidGlassLayer(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(
                top:
                    MediaQuery.of(context).padding.top +
                        60 +
                        16,
                left: 16,
                right: 16,
                bottom: 80,
              ),
              children: <Widget>[
          GlassCard(
            child: Column(
              children: <Widget>[
                GlassListTile(
                  leading: const Icon(
                    Icons.brightness_6,
                  ),
                  title: const Text('Dark Mode'),
                  trailing: GlassSwitch(
                    value: appState.themeMode ==
                        ThemeMode.dark,
                    onChanged: (bool value) {
                      appState.setThemeMode(
                        value
                            ? ThemeMode.dark
                            : ThemeMode.light,
                      );
                    },
                  ),
                ),
                const GlassDivider(),
                GlassListTile(
                  leading: const Icon(
                    Icons.info_outline,
                  ),
                  title: Text(ap.about),
                  trailing: GlassListTile.chevron,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) =>
                            const GlassAboutUsPage(
                          assetImage:
                              ImageAssets.K,
                          githubName: 'NKUST-ITC',
                          email:
                              'abc873693@gmail.com',
                          appLicense:
                              'MIT License',
                          fbFanPageId:
                              '735951703168873',
                          fbFanPageUrl:
                              'https://www.facebook.com/NKUST.ITC/',
                          githubUrl:
                              'https://github.com/NKUST-ITC',
                        ),
                      ),
                    );
                  },
                ),
                const GlassDivider(),
                GlassListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: Text(ap.logout),
                  onTap: widget.onLogout,
                ),
              ],
            ),
          ),
            ],
            ),
            GlassFloatingToolbar(
              leading: <Widget>[
                Text(
                  ap.settings,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
