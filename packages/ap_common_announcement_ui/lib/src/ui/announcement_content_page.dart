import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:photo_view/photo_view.dart';

enum _Status { loading, finish, error, empty }

class AnnouncementContentPage extends StatefulWidget {
  const AnnouncementContentPage({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  @override
  AnnouncementContentPageState createState() => AnnouncementContentPageState();
}

class AnnouncementContentPageState extends State<AnnouncementContentPage> {
  _Status state = _Status.finish;

  ApLocalizations get app => ApLocalizations.of(context);

  @override
  void initState() {
    AnalyticsUtil.instance.setCurrentScreen(
      'AnnouncementContentPage',
      'announcement_content_page.dart',
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app.announcements),
      ),
      body: _homebody(),
    );
  }

  Widget? _homebody() {
    switch (state) {
      case _Status.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case _Status.finish:
        return OrientationBuilder(
          builder: (_, Orientation orientation) {
            return orientation == Orientation.portrait
                ? SingleChildScrollView(
                    child: Flex(
                      direction: orientation == Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _renderContent(orientation),
                    ),
                  )
                : Flex(
                    direction: orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _renderContent(orientation),
                  );
          },
        );
      case _Status.error:
      case _Status.empty:
        return HintContent(
          icon: ApIcon.error,
          content: app.somethingError,
        );
    }
  }

  List<Widget> _renderContent(Orientation orientation) {
    final Widget image = GestureDetector(
      onTap: () {
        ApUtils.pushCupertinoStyle(
          context,
          Scaffold(
            appBar: AppBar(
              title: Text(widget.announcement.title),
            ),
            body: PhotoView(
              imageProvider: (ApUtils.isSupportCacheNetworkImage
                      ? CachedNetworkImageProvider(widget.announcement.imgUrl)
                      : NetworkImage(widget.announcement.imgUrl))
                  as ImageProvider<Object>?,
            ),
          ),
        );
        AnalyticsUtil.instance.logEvent('announcement_content_image_click');
      },
      child: AspectRatio(
        aspectRatio: orientation == Orientation.portrait ? 4 / 3 : 9 / 16,
        child: Hero(
          tag: widget.announcement.hashCode,
          child: ApNetworkImage(
            url: widget.announcement.imgUrl,
          ),
        ),
      ),
    );
    final List<Widget> content = <Widget>[
      Hero(
        tag: ApConstants.tagAnnouncementTitle,
        child: Material(
          color: Colors.transparent,
          child: SelectableText(
            widget.announcement.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: ApTheme.of(context).greyText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      Hero(
        tag: ApConstants.tagAnnouncementIcon,
        child: Icon(ApIcon.arrowDropDown),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: orientation == Orientation.portrait ? 16.0 : 0.0,
        ),
        child: SelectableLinkify(
          text: widget.announcement.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: ApTheme.of(context).greyText,
          ),
          options: const LinkifyOptions(humanize: false),
          onOpen: (LinkableElement link) async =>
              PlatformUtil.instance.launchUrl(link.url),
        ),
      ),
      if (widget.announcement.url != null &&
          widget.announcement.url!.isNotEmpty) ...<Widget>[
        const SizedBox(height: 16.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            backgroundColor: ApTheme.of(context).yellow,
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 30.0,
            ),
          ),
          onPressed: () {
            PlatformUtil.instance.launchUrl(widget.announcement.url!);
            AnalyticsUtil.instance.logEvent('announcement_link_click');
          },
          child: Icon(
            ApIcon.exitToApp,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    ];
    if (orientation == Orientation.portrait) {
      return <Widget>[
        const SizedBox(height: 16.0),
        image,
        const SizedBox(height: 16.0),
        ...content,
      ];
    } else {
      return <Widget>[
        const SizedBox(width: 16.0),
        Expanded(child: image),
        const SizedBox(width: 32.0),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: content,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
      ];
    }
  }
}
