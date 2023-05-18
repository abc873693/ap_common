import 'package:ap_common/models/user_info.dart';
import 'package:ap_common/scaffold/user_info_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/assets.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key, this.userInfo}) : super(key: key);

  static const String routerName = '/userInfo';

  final UserInfo? userInfo;

  @override
  UserInfoPageState createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  UserInfo? userInfo;

  @override
  void initState() {
    userInfo = widget.userInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UserInfoScaffold(
      userInfo: widget.userInfo!,
      enableBarCode: true,
      onRefresh: () async {
        final String rawString =
            await rootBundle.loadString(FileAssets.userInfo);
        final UserInfo userInfo = UserInfo.fromRawJson(rawString);
        if (userInfo != null) {
          setState(
            () => this.userInfo = userInfo.copyWith(
              pictureBytes: this.userInfo!.pictureBytes,
            ),
          );
        }
//        FirebaseAnalyticsUtils.instance.logUserInfo(userInfo);
        return null;
      },
    );
  }
}
