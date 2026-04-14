import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:ap_common_liquid_glass/src/widgets/glass_floating_toolbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:photo_view/photo_view.dart';

/// A glass-enhanced version of [AnnouncementContentPage].
///
/// Uses [GlassFloatingToolbar] for navigation,
/// [GlassCard] for content sections, and
/// [GlassButton] for links.
class GlassAnnouncementContentPage extends StatefulWidget {
  const GlassAnnouncementContentPage({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  @override
  GlassAnnouncementContentPageState createState() =>
      GlassAnnouncementContentPageState();
}

class GlassAnnouncementContentPageState
    extends State<GlassAnnouncementContentPage> {
  @override
  void initState() {
    AnalyticsUtil.instance.setCurrentScreen(
      'GlassAnnouncementContentPage',
      'glass_announcement_content_page.dart',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding =
        MediaQuery.of(context).padding.top;

    return AdaptiveLiquidGlassLayer(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            OrientationBuilder(
              builder: (
                _,
                Orientation orientation,
              ) {
                return orientation ==
                        Orientation.portrait
                    ? SingleChildScrollView(
                        padding: EdgeInsets.only(
                          top: topPadding + 52,
                          bottom: 32,
                        ),
                        child: Column(
                          children:
                              _renderContent(
                            orientation,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          top: topPadding + 52,
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                          children:
                              _renderContent(
                            orientation,
                          ),
                        ),
                      );
              },
            ),
            GlassFloatingToolbar(
              leading: <Widget>[
                GestureDetector(
                  onTap: () =>
                      Navigator.pop(context),
                  child: const Icon(
                    Icons
                        .arrow_back_ios_new_rounded,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    context.ap.announcements,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow:
                        TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _renderContent(
    Orientation orientation,
  ) {
    final ColorScheme colorScheme =
        Theme.of(context).colorScheme;

    final Widget image = GestureDetector(
      onTap: () {
        ApUtils.pushCupertinoStyle(
          context,
          Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              title: Text(
                widget.announcement.title,
              ),
            ),
            body: PhotoView(
              imageProvider:
                  (ApUtils.isSupportCacheNetworkImage
                          ? CachedNetworkImageProvider(
                              widget.announcement
                                  .imgUrl,
                            )
                          : NetworkImage(
                              widget.announcement
                                  .imgUrl,
                            ))
                      as ImageProvider<Object>?,
            ),
          ),
        );
        AnalyticsUtil.instance.logEvent(
          'announcement_content_image_click',
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio:
                orientation == Orientation.portrait
                    ? 4 / 3
                    : 9 / 16,
            child: Hero(
              tag:
                  widget.announcement.hashCode,
              child: ApNetworkImage(
                url:
                    widget.announcement.imgUrl,
              ),
            ),
          ),
        ),
      ),
    );

    final Widget contentCard = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: GlassCard(
        useOwnLayer: true,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag:
                  ApConstants.tagAnnouncementTitle,
              child: Material(
                color: Colors.transparent,
                child: SelectableText(
                  widget.announcement.title,
                  style: TextStyle(
                    fontSize: 20,
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (widget
                    .announcement
                    .publishedTime !=
                null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                widget.announcement
                    .publishedTime!,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme
                      .onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 12),
            SelectableLinkify(
              text: widget
                  .announcement.description,
              style: TextStyle(
                fontSize: 15,
                color:
                    colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              linkStyle: TextStyle(
                color: colorScheme.primary,
              ),
              options: const LinkifyOptions(
                humanize: false,
              ),
              onOpen: (LinkableElement link) =>
                  PlatformUtil.instance
                      .launchUrl(link.url),
            ),
            if (widget.announcement.url !=
                    null &&
                widget.announcement.url!
                    .isNotEmpty) ...<Widget>[
              const SizedBox(height: 16),
              Center(
                child: GlassButton.custom(
                  onTap: () {
                    PlatformUtil.instance
                        .launchUrl(
                      widget.announcement.url!,
                    );
                    AnalyticsUtil.instance
                        .logEvent(
                      'announcement_link_click',
                    );
                  },
                  width: 56,
                  height: 56,
                  child: Icon(
                    ApIcon.exitToApp,
                    color:
                        colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );

    if (orientation == Orientation.portrait) {
      return <Widget>[
        const SizedBox(height: 8),
        image,
        const SizedBox(height: 16),
        contentCard,
      ];
    } else {
      return <Widget>[
        const SizedBox(width: 16),
        Expanded(child: image),
        const SizedBox(width: 16),
        Expanded(
          child: SingleChildScrollView(
            child: contentCard,
          ),
        ),
        const SizedBox(width: 16),
      ];
    }
  }
}
