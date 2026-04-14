import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_floating_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A glass-enhanced version of [AboutUsPage].
///
/// Replaces the [SliverAppBar] with [GlassFloatingToolbar],
/// [Card] surfaces with [GlassCard], and uses
/// [AdaptiveLiquidGlassLayer] for the glass effect.
class GlassAboutUsPage extends StatefulWidget {
  const GlassAboutUsPage({
    super.key,
    required this.assetImage,
    required this.fbFanPageUrl,
    required this.fbFanPageId,
    this.instagramUsername,
    required this.githubUrl,
    required this.githubName,
    required this.email,
    required this.appLicense,
    this.actions,
    this.applicationName,
    this.applicationVersion,
    this.applicationIcon,
    this.applicationLegalese,
  });

  final String assetImage;
  final String fbFanPageUrl;
  final String fbFanPageId;
  final String? instagramUsername;
  final String githubUrl;
  final String githubName;
  final String email;
  final String appLicense;
  final String? applicationName;
  final String? applicationVersion;
  final Widget? applicationIcon;
  final String? applicationLegalese;
  final List<Widget>? actions;

  @override
  GlassAboutUsPageState createState() =>
      GlassAboutUsPageState();
}

class GlassAboutUsPageState
    extends State<GlassAboutUsPage> {
  @override
  void initState() {
    AnalyticsUtil.instance.setCurrentScreen(
      'GlassAboutUsPage',
      'glass_about_us_page.dart',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ApLocalizations ap = context.ap;
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;
    final double topPadding =
        MediaQuery.of(context).padding.top;

    return AdaptiveLiquidGlassLayer(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(
                top: topPadding + 52,
                bottom: 32,
              ),
              children: <Widget>[
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildInfoCard(
                  ap.aboutAuthorTitle,
                  ap.aboutAuthorContent,
                ),
                _buildInfoCard(
                  ap.about,
                  ap.aboutUsContent,
                ),
                _buildInfoCard(
                  ap.aboutRecruitTitle,
                  ap.aboutRecruitContent,
                ),
                _buildInfoCardWithLogo(
                  ap.aboutItcTitle,
                  ap.aboutItcContent,
                  ApImageAssets.nkutstItc,
                ),
                _buildInfoCardWithLogo(
                  ap.aboutNsysuCodeClubTitle,
                  ap.aboutNsysuCodeClubContent,
                  ApImageAssets.nsysuGdsc,
                ),
                _buildContactCard(
                  context,
                  ap,
                  colorScheme,
                ),
                _buildInfoCard(
                  ap.aboutOpenSourceTitle,
                  widget.appLicense,
                ),
              ],
            ),
            GlassFloatingToolbar(
              leading: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  ap.about,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              trailing: <Widget>[
                ...widget.actions ?? <Widget>[],
                IconButton(
                  icon: Icon(ApIcon.codeIcon),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => LicensePage(
                          applicationName:
                              widget.applicationName,
                          applicationVersion:
                              widget
                                  .applicationVersion,
                          applicationIcon:
                              widget.applicationIcon,
                          applicationLegalese:
                              widget
                                  .applicationLegalese,
                        ),
                      ),
                    );
                    AnalyticsUtil.instance
                        .logEvent('license_page_click');
                  },
                  iconSize: 22,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          widget.assetImage,
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      child: GlassCard(
        useOwnLayer: true,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: <Widget>[
              SelectableLinkify(
                text: title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SelectableLinkify(
                text: content,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      colorScheme.onSurfaceVariant,
                ),
                options: const LinkifyOptions(
                  humanize: false,
                ),
                onOpen: (LinkableElement link) =>
                    PlatformUtil.instance
                        .launchUrl(link.url),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCardWithLogo(
    String title,
    String content,
    String logoAsset,
  ) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      child: GlassCard(
        useOwnLayer: true,
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 72,
                    ),
                    child: SelectableLinkify(
                      text: title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableLinkify(
                    text: content,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme
                          .onSurfaceVariant,
                    ),
                    options: const LinkifyOptions(
                      humanize: false,
                    ),
                    onOpen: (LinkableElement link) =>
                        PlatformUtil.instance
                            .launchUrl(link.url),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  logoAsset,
                  width: 56,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    ApLocalizations ap,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      child: GlassCard(
        useOwnLayer: true,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              ap.aboutContactUsTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildContactIcon(
                  ApImageAssets.fb,
                  colorScheme.onSurface,
                  () {
                    PlatformUtil.instance.launchUrl(
                      'https://m.me/'
                      '${widget.fbFanPageId}',
                    );
                    AnalyticsUtil.instance
                        .logEvent('fb_click');
                  },
                ),
                if (widget.instagramUsername
                    case final String username?)
                  _buildContactIcon(
                    ApImageAssets.instagram,
                    null,
                    () {
                      PlatformUtil.instance.launchUrl(
                        'https://ig.me/m/$username',
                      );
                      AnalyticsUtil.instance
                          .logEvent('instagram_click');
                    },
                  ),
                _buildContactIcon(
                  ApImageAssets.github,
                  colorScheme.onSurface,
                  () {
                    PlatformUtil.instance
                        .launchUrl(widget.githubUrl);
                    AnalyticsUtil.instance
                        .logEvent('github_click');
                  },
                ),
                _buildContactIcon(
                  ApImageAssets.email,
                  colorScheme.onSurface,
                  () {
                    PlatformUtil.instance.launchUrl(
                      'mailto:${widget.email}',
                    );
                    AnalyticsUtil.instance
                        .logEvent('email_click');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactIcon(
    String asset,
    Color? color,
    VoidCallback onTap,
  ) {
    return GlassIconButton(
      icon: Image.asset(
        asset,
        color: color,
        width: 28,
        height: 28,
      ),
      onPressed: onTap,
    );
  }
}
