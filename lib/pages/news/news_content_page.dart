import 'dart:io';

import 'package:ap_common/config/ApConstant.dart';
import 'package:ap_common/models/new_response.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/widgets/ap_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

enum _Status { loading, finish, error, empty }

class NewsContentPage extends StatefulWidget {
  static const String routerName = "/news/content";

  final News news;

  const NewsContentPage({Key key, this.news}) : super(key: key);

  @override
  NewsContentPageState createState() => NewsContentPageState();
}

class NewsContentPageState extends State<NewsContentPage> {
  _Status state = _Status.finish;
  ApLocalizations app;

  @override
  void initState() {
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
        title: Text(app.news),
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
          tag: widget.news.hashCode,
          child: ApNetworkImage(
            url: widget.news.imageUrl,
          ),
        ),
      ),
      onTap: () {
        ApUtils.pushCupertinoStyle(
          context,
          Scaffold(
            appBar: AppBar(
              title: Text(widget.news.title),
              backgroundColor: ApTheme.of(context).blue,
            ),
            body: PhotoView(
              imageProvider: (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
                  ? CachedNetworkImageProvider(widget.news.imageUrl)
                  : NetworkImage(widget.news.imageUrl),
            ),
          ),
        );
      },
    );
    final List<Widget> newsContent = <Widget>[
      Hero(
        tag: ApConstants.TAG_NEWS_TITLE,
        child: Material(
          color: Colors.transparent,
          child: SelectableText(
            widget.news.title,
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
        tag: ApConstants.TAG_NEWS_ICON,
        child: Icon(ApIcon.arrowDropDown),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: orientation == Orientation.portrait ? 16.0 : 0.0),
        child: SelectableText(
          widget.news.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: ApTheme.of(context).greyText,
          ),
        ),
      ),
      if (widget.news.url != null && widget.news.url.isNotEmpty) ...[
        SizedBox(height: 16.0),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          onPressed: () {
            launch(widget.news.url);
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
        ...newsContent,
      ];
    } else {
      return <Widget>[
        Expanded(child: image),
        SizedBox(width: 32.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: newsContent,
          ),
        ),
      ];
    }
  }
}
