import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/pages/home_page.dart';
import 'package:ap_common_example/pages/school_info_page.dart';
import 'package:ap_common_example/pages/setting_page.dart';
import 'package:ap_common_example/pages/study/course_page.dart';
import 'package:ap_common_example/pages/study/score_page.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          builder: (_) => const _HomeTab(),
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
          icon: Icon(Icons.more_horiz),
          label: context.ap.otherInfo,
          builder: (_) => const _MoreTab(),
        ),
      ],
    );
  }
}

// ─── Home Tab ─────────────────────────────────────────────

class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  HomeState state = HomeState.loading;
  List<Announcement> announcements = <Announcement>[];
  CourseData? courseData;

  @override
  void initState() {
    super.initState();
    _getAnnouncements();
    _loadCourseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.ap.home),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (state) {
      case HomeState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case HomeState.finish:
        return _buildContent();
      case HomeState.error:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: context.ap.somethingError,
        );
      case HomeState.empty:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: context.ap.announcementEmpty,
        );
      case HomeState.offline:
        return HintContent(
          icon: ApIcon.offlineBolt,
          content: context.ap.offlineMode,
        );
    }
  }

  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: courseData != null
              ? TodayScheduleCard(
                  courseData: courseData!,
                )
              : EmptyScheduleCard(
                  message: context.ap.courseEmpty,
                ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            context.ap.announcements,
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        ...announcements.map(_buildAnnouncementTile),
      ],
    );
  }

  Widget _buildAnnouncementTile(
    Announcement announcement,
  ) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 56,
          height: 56,
          child: ApNetworkImage(
            url: announcement.imgUrl,
          ),
        ),
      ),
      title: Text(
        announcement.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        ApUtils.pushCupertinoStyle(
          context,
          AnnouncementContentPage(
            announcement: announcement,
          ),
        );
      },
    );
  }

  Future<void> _getAnnouncements() async {
    final ApiResult<List<Announcement>> result =
        await AnnouncementHelper.instance
            .getAnnouncements(tags: <String>[]);
    switch (result) {
      case ApiSuccess<List<Announcement>>(
        :final List<Announcement> data,
      ):
        announcements = data;
        setState(() {
          state = announcements.isEmpty
              ? HomeState.empty
              : HomeState.finish;
        });
      case ApiFailure<List<Announcement>>():
      case ApiError<List<Announcement>>():
        setState(() => state = HomeState.error);
    }
  }

  Future<void> _loadCourseData() async {
    final String rawString =
        await rootBundle.loadString(
      FileAssets.courses,
    );
    setState(() {
      courseData =
          CourseData.fromRawJson(rawString);
    });
  }
}

// ─── More Tab ─────────────────────────────────────────────

class _MoreTab extends StatelessWidget {
  const _MoreTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.ap.otherInfo),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(ApIcon.info),
            title: Text(context.ap.schoolInfo),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              ApUtils.pushCupertinoStyle(
                context,
                SchoolInfoPage(),
              );
            },
          ),
          ListTile(
            leading: Icon(ApIcon.settings),
            title: Text(context.ap.settings),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              ApUtils.pushCupertinoStyle(
                context,
                SettingPage(),
              );
            },
          ),
          ListTile(
            leading: Icon(ApIcon.face),
            title: Text(context.ap.about),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {
              ApUtils.pushCupertinoStyle(
                context,
                HomePage.aboutPage(context),
              );
            },
          ),
        ],
      ),
    );
  }
}
