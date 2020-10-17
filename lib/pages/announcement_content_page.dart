import 'dart:io';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/ap_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

enum _Status { loading, finish, error, empty }

class AnnouncementContentPage extends StatefulWidget {
  final Announcement announcement;
  final Function() setCurrentScreen;

  const AnnouncementContentPage(
      {Key key, this.announcement, this.setCurrentScreen})
      : super(key: key);

  @override
  AnnouncementContentPageState createState() => AnnouncementContentPageState();
}

class AnnouncementContentPageState extends State<AnnouncementContentPage> {
  _Status state = _Status.finish;
  ApLocalizations app;

  @override
  void initState() {
    if (widget.setCurrentScreen != null) widget.setCurrentScreen();
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

  Widget _homebody() {
    switch (state) {
      case _Status.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      case _Status.finish:
        return OrientationBuilder(
          builder: (_, orientation) {
            return Flex(
              direction: orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _renderContent(orientation),
            );
          },
        );
      default:
        return Container();
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
              title: Text(widget.announcement.title),
              backgroundColor: ApTheme.of(context).blue,
            ),
            body: PhotoView(
              imageProvider: (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
                  ? CachedNetworkImageProvider(widget.announcement.imgUrl)
                  : NetworkImage(widget.announcement.imgUrl),
            ),
          ),
        );
      },
    );
    final List<Widget> content = <Widget>[
      Hero(
        tag: ApConstants.TAG_ANNOUNCEMENT_TITLE,
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
        tag: ApConstants.TAG_ANNOUNCEMENT_ICON,
        child: Icon(ApIcon.arrowDropDown),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: orientation == Orientation.portrait ? 16.0 : 0.0),
        child: SelectableLinkify(
          text: widget.announcement.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: ApTheme.of(context).greyText,
          ),
          options: LinkifyOptions(humanize: false),
          onOpen: (link) async => ApUtils.launchUrl(link?.url),
        ),
      ),
      if (widget.announcement.url != null &&
          widget.announcement.url.isNotEmpty) ...[
        SizedBox(height: 16.0),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          onPressed: () {
            launch(widget.announcement.url);
          },
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
          color: ApTheme.of(context).yellow,
          child: Icon(
            ApIcon.exitToApp,
            color: Colors.white,
          ),
        ),
      ],
    ];
    if (orientation == Orientation.portrait) {
      return <Widget>[
        image,
        SizedBox(height: 16.0),
        ...content,
      ];
    } else {
      return <Widget>[
        Expanded(child: image),
        SizedBox(width: 32.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: content,
          ),
        ),
      ];
    }
  }
}
