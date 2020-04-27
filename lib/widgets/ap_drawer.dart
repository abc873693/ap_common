
import 'package:ap_common/models/user_info.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApDrawer extends StatefulWidget {
  final UserInfo userInfo;
  final Function onTapHeader;
  final String imageAsset;
  final List<Widget> widgets;
  final String imageHeroTag;

  const ApDrawer({
    Key key,
    @required this.onTapHeader,
    @required this.widgets,
    @required this.userInfo,
    this.imageAsset,
    this.imageHeroTag = 'image',
  }) : super(key: key);

  @override
  ApDrawerState createState() => ApDrawerState();
}

class ApDrawerState extends State<ApDrawer> {
  ApLocalizations app;

  bool displayPicture = true;

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
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: widget.onTapHeader,
              child: Stack(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    margin: const EdgeInsets.all(0),
                    currentAccountPicture:
                        widget.userInfo?.pictureBytes != null && displayPicture
                            ? Hero(
                                tag: widget.imageHeroTag,
                                child: Container(
                                  width: 72.0,
                                  height: 72.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: MemoryImage(
                                        widget.userInfo.pictureBytes,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: 72.0,
                                height: 72.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  ApIcon.accountCircle,
                                  color: Colors.white,
                                  size: 72.0,
                                ),
                              ),
                    accountName: Text(
                      (widget.userInfo == null)
                          ? app.notLogin
                          : (widget.userInfo?.name ?? ''),
                      style: TextStyle(color: Colors.white),
                    ),
                    accountEmail: Text(
                      widget.userInfo?.id ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: ApTheme.of(context).blue,
                      image: DecorationImage(
                        image: AssetImage(ApTheme.of(context).drawerBackground),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  if (widget.imageAsset != null)
                    Positioned(
                      bottom: 20.0,
                      right: 20.0,
                      child: Opacity(
                        opacity: ApTheme.of(context).drawerIconOpacity,
                        child: Image.asset(
                          widget.imageAsset,
                          width: 90.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            ...widget.widgets,
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget page;
  final bool needLogin;

  const DrawerItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.page,
    this.needLogin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ApTheme.of(context).grey),
      title: Text(
        title,
        style: TextStyle(
          color: ApTheme.of(context).grey,
          fontSize: 16.0,
        ),
      ),
      onTap: () async {
        Navigator.of(context).pop();
        if (needLogin)
          ApUtils.showToast(
            context,
            ApLocalizations.of(context).notLoginHint,
          );
        else
          ApUtils.pushCupertinoStyle(context, page);
      },
    );
  }
}

class DrawerSubItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget page;
  final bool needLogin;

  const DrawerSubItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.page,
    this.needLogin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 72.0),
      leading: Icon(icon, color: ApTheme.of(context).grey),
      title: Text(
        title,
        style: TextStyle(
          color: ApTheme.of(context).grey,
          fontSize: 16.0,
        ),
      ),
      onTap: () async {
        Navigator.of(context).pop();
        if (needLogin)
          ApUtils.showToast(
            context,
            ApLocalizations.of(context).notLoginHint,
          );
        else
          ApUtils.pushCupertinoStyle(context, page);
      },
    );
  }
}
