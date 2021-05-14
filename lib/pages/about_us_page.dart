import 'dart:io';

import 'package:ap_common/resources/resources.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  /// /aboutus
  static const String routerName = '/about';
  final String assetImage;
  final String fbFanPageUrl;
  final String fbFanPageId;
  final String githubUrl;
  final String githubName;
  final String email;
  final String appLicense;
  final List<Widget>? actions;

  const AboutUsPage({
    Key? key,
    required this.assetImage,
    required this.fbFanPageUrl,
    required this.fbFanPageId,
    required this.githubUrl,
    required this.githubName,
    required this.email,
    required this.appLicense,
    this.actions,
  }) : super(key: key);

  @override
  AboutUsPageState createState() => AboutUsPageState();
}

class AboutUsPageState extends State<AboutUsPage> {
  ApLocalizations get app => ApLocalizations.of(context);

  @override
  void initState() {
    AnalyticsUtils.instance?.setCurrentScreen(
      'AboutUsPage',
      'about_us_page.dart',
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double expandedHeight = MediaQuery.of(context).size.height * 0.25;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: expandedHeight,
            pinned: true,
            title: Text(app.about),
            actions: widget.actions,
            backgroundColor: ApTheme.of(context).blue,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.assetImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            <Widget>[
              _item(app.aboutAuthorTitle, app.aboutAuthorContent),
              _item(app.about, app.aboutUsContent),
              _item(app.aboutRecruitTitle, app.aboutRecruitContent),
              Stack(
                children: <Widget>[
                  _item(app.aboutItcTitle, app.aboutItcContent),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 26.0,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        ApImageAssets.nkutstItc,
                        width: 64.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    left: 16.0,
                    bottom: 16.0,
                    right: 16.0,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SelectableText(
                        app.aboutContactUsTitle,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset(ApImageAssets.fb),
                              onPressed: () {
                                if (kIsWeb) {
                                  launch(widget.fbFanPageUrl);
                                } else if (Platform.isAndroid) {
                                  launch('fb://page/${widget.fbFanPageId}')
                                      .catchError((dynamic onError) =>
                                          launch(widget.fbFanPageUrl));
                                } else if (Platform.isIOS) {
                                  launch('fb://profile/${widget.fbFanPageId}')
                                      .catchError((dynamic onError) =>
                                          launch(widget.fbFanPageUrl));
                                } else {
                                  launch(widget.fbFanPageUrl).catchError(
                                    (dynamic onError) {
                                      ApUtils.showToast(
                                        context,
                                        app.platformError,
                                      );
                                    },
                                  );
                                }
                                AnalyticsUtils.instance?.logEvent('fb_click');
                              },
                              iconSize: 48.0,
                            ),
                            IconButton(
                              icon: Image.asset(ApImageAssets.github),
                              onPressed: () {
                                if (kIsWeb) {
                                  launch(widget.githubUrl);
                                } else if (Platform.isAndroid) {
                                  launch('github://organization/${widget.githubName}')
                                      // ignore: always_specify_types
                                      .catchError(
                                    (dynamic onError) =>
                                        launch(widget.githubUrl),
                                  );
                                } else if (Platform.isIOS) {
                                  launch(widget.githubUrl);
                                } else {
                                  launch(widget.githubUrl).catchError(
                                    (dynamic onError) {
                                      ApUtils.showToast(
                                        context,
                                        app.platformError,
                                      );
                                    },
                                  );
                                }
                                AnalyticsUtils.instance
                                    ?.logEvent('github_click');
                              },
                              iconSize: 48.0,
                            ),
                            IconButton(
                              icon: Image.asset(ApImageAssets.email),
                              onPressed: () {
                                launch('mailto:${widget.email}').catchError(
                                  (dynamic onError) {
                                    ApUtils.showToast(
                                      context,
                                      app.platformError,
                                    );
                                  },
                                );
                                AnalyticsUtils.instance
                                    ?.logEvent('email_click');
                              },
                              iconSize: 48.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _item(app.aboutOpenSourceTitle, widget.appLicense),
            ],
          )),
        ],
      ),
    );
  }

  Widget _item(String text, String subText) => Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: const EdgeInsets.only(
              top: 24.0, left: 16.0, bottom: 16.0, right: 16.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SelectableLinkify(
                text: text,
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 4.0,
              ),
              SelectableLinkify(
                text: subText,
                style: TextStyle(
                  fontSize: 14.0,
                  color: ApTheme.of(context).grey,
                ),
                options: const LinkifyOptions(humanize: false),
                onOpen: (LinkableElement link) async =>
                    ApUtils.launchUrl(link.url),
              ),
            ],
          ),
        ),
      );
}
