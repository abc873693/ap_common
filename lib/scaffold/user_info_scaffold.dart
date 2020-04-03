import 'dart:typed_data';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/user_info.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:flutter/material.dart';

enum _Status { loading, finish, error, empty }

class UserInfoScaffold extends StatefulWidget {
  final UserInfo userInfo;
  final Uint8List pictureBytes;
  final String heroTag;
  final List<Widget> actions;
  final Future<UserInfo> Function() onRefresh;

  const UserInfoScaffold({
    Key key,
    @required this.userInfo,
    this.pictureBytes,
    this.heroTag,
    this.actions,
    this.onRefresh,
  }) : super(key: key);

  @override
  UserInfoScaffoldState createState() => UserInfoScaffoldState();
}

class UserInfoScaffoldState extends State<UserInfoScaffold> {
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
        title: Text(app.userInfo),
        backgroundColor: ApTheme.of(context).blue,
        actions: widget.actions,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (widget.onRefresh != null) await widget.onRefresh();
          return null;
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 8.0),
            widget.pictureBytes != null
                ? SizedBox(
                    height: 320,
                    child: AspectRatio(
                      aspectRatio: 2.0,
                      child: Hero(
                        tag: widget.heroTag ?? ApConstants.TAG_STUDENT_PICTURE,
                        child: Image.memory(
                          widget.pictureBytes,
                        ),
                      ),
                    ),
                  )
                : SizedBox(height: 0.0),
            SizedBox(height: 8.0),
            UserInfoCard(
              userInfo: widget.userInfo,
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  final UserInfo userInfo;

  const UserInfoCard({Key key, this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(ApLocalizations.of(context).studentNameCht),
              subtitle: Text(userInfo?.name ?? ''),
            ),
            Divider(height: 1.0),
            if (userInfo?.educationSystem != null) ...[
              ListTile(
                title: Text(ApLocalizations.of(context).educationSystem),
                subtitle: Text(userInfo?.educationSystem ?? ''),
              ),
              Divider(height: 1.0),
            ],
            if (userInfo?.email != null) ...[
              ListTile(
                title: Text(ApLocalizations.of(context).email),
                subtitle: Text(userInfo?.email ?? ''),
              ),
              Divider(height: 1.0),
            ],
            ListTile(
              title: Text(ApLocalizations.of(context).department),
              subtitle: Text(userInfo?.department ?? ''),
            ),
            Divider(height: 1.0),
            ListTile(
              title: Text(ApLocalizations.of(context).studentClass),
              subtitle: Text(userInfo?.className ?? ''),
            ),
            Divider(height: 1.0),
            ListTile(
              title: Text(ApLocalizations.of(context).studentId),
              subtitle: Text(userInfo?.id ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
