import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/ap_network_image.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

enum _Status { loading, finish, error, empty }

class AnnouncementContentPage extends StatefulWidget {
  final Announcement announcement;

  const AnnouncementContentPage({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  @override
  AnnouncementContentPageState createState() => AnnouncementContentPageState();
}

class AnnouncementContentPageState extends State<AnnouncementContentPage> {
  _Status state = _Status.finish;
  late ApLocalizations app;

  @override
  void initState() {
    AnalyticsUtils.instance?.setCurrentScreen(
      "AnnouncementContentPage",
      "announcement_content_page.dart",
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    app = ApLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(app.announcements),
        backgroundColor: ApTheme.of(context).blue,
      ),
      body: _homebody(),
    );
  }

  Widget? _homebody() {
    switch (state) {
      case _Status.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case _Status.finish:
        return OrientationBuilder(
          builder: (_, orientation) {
            return orientation == Orientation.portrait
                ? SingleChildScrollView(
                    child: Flex(
                      direction: orientation == Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _renderContent(orientation),
                    ),
                  )
                : Flex(
                    direction: orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
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

  _renderContent(Orientation orientation) {
    final Widget image = GestureDetector(
      child: AspectRatio(
        aspectRatio: orientation == Orientation.portrait ? 4 / 3 : 9 / 16,
        child: Hero(
          tag: widget.announcement.hashCode,
          child: ApNetworkImage(
            url: widget.announcement.imgUrl,
          ),
        ),
      ),
      onTap: () {
        ApUtils.pushCupertinoStyle(
          context,
          Scaffold(
            appBar: AppBar(
              title: Text(widget.announcement.title!),
              backgroundColor: ApTheme.of(context).blue,
            ),
            body: PhotoView(
              imageProvider: (ApUtils.isSupportCacheNetworkImage
                      ? CachedNetworkImageProvider(widget.announcement.imgUrl!)
                      : NetworkImage(widget.announcement.imgUrl!))
                  as ImageProvider<Object>?,
            ),
          ),
        );
        AnalyticsUtils.instance?.logEvent('announcement_content_image_click');
      },
    );
    final List<Widget> content = <Widget>[
      Hero(
        tag: ApConstants.TAG_ANNOUNCEMENT_TITLE,
        child: Material(
          color: Colors.transparent,
          child: SelectableText(
            widget.announcement.title!,
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
        tag: ApConstants.TAG_ANNOUNCEMENT_ICON,
        child: Icon(ApIcon.arrowDropDown),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: orientation == Orientation.portrait ? 16.0 : 0.0,
        ),
        child: Linkify(
          text: widget.announcement.description ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: ApTheme.of(context).greyText,
          ),
          options: LinkifyOptions(humanize: false),
          onOpen: (link) async => ApUtils.launchUrl(link.url),
        ),
      ),
      if (widget.announcement.url != null &&
          widget.announcement.url!.isNotEmpty) ...[
        SizedBox(height: 16.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 30.0,
            ),
            primary: ApTheme.of(context).yellow,
          ),
          onPressed: () {
            launch(widget.announcement.url!);
            AnalyticsUtils.instance?.logEvent('announcement_link_click');
          },
          child: Icon(
            ApIcon.exitToApp,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.0),
      ],
    ];
    if (orientation == Orientation.portrait) {
      return <Widget>[
        SizedBox(height: 16.0),
        image,
        SizedBox(height: 16.0),
        ...content,
      ];
    } else {
      return <Widget>[
        SizedBox(width: 16.0),
        Expanded(child: image),
        SizedBox(width: 32.0),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: content,
            ),
          ),
        ),
        SizedBox(width: 16.0),
      ];
    }
  }
}
