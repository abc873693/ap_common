import 'dart:typed_data';

import 'package:ap_common/config/ap_constants.dart';
import 'package:ap_common/models/user_info.dart';
import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:flutter/material.dart';

class ApDrawer extends StatefulWidget {
  const ApDrawer({
    super.key,
    required this.onTapHeader,
    required this.widgets,
    this.userInfo,
    this.imageAsset,
    this.imageHeroTag = ApConstants.tagStudentPicture,
    this.displayPicture = false,
  });

  final UserInfo? userInfo;
  final Function() onTapHeader;
  final String? imageAsset;
  final List<Widget> widgets;
  final String imageHeroTag;
  final bool displayPicture;

  @override
  ApDrawerState createState() => ApDrawerState();
}

class ApDrawerState extends State<ApDrawer> {
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
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: widget.onTapHeader,
              child: Stack(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    currentAccountPicture:
                        widget.userInfo?.pictureBytes != null &&
                                widget.displayPicture
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
                                        widget.userInfo?.pictureBytes ??
                                            Uint8List(0),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: 72.0,
                                height: 72.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  ApIcon.accountCircle,
                                  color: Colors.white,
                                  size: 72.0,
                                ),
                              ),
                    accountName: Text(
                      widget.userInfo == null
                          ? ApLocalizations.of(context).notLogin
                          : (widget.userInfo?.name ?? ''),
                      style: const TextStyle(color: Colors.white),
                    ),
                    accountEmail: Text(
                      widget.userInfo?.id ?? '',
                      style: const TextStyle(color: Colors.white),
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
                          widget.imageAsset!,
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
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Function() onTap;

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
      onTap: onTap,
    );
  }
}

class DrawerSubItem extends StatelessWidget {
  const DrawerSubItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 72.0),
      leading: Icon(icon, color: ApTheme.of(context).grey),
      title: Text(
        title,
        style: TextStyle(
          color: ApTheme.of(context).grey,
          fontSize: 16.0,
        ),
      ),
      onTap: onTap,
    );
  }
}
