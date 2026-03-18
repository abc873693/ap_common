import 'package:ap_common/ap_common.dart';
import 'package:ap_common_example/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      userInfo: userInfo!,
      enableBarCode: true,
      onRefresh: () async {
        final String rawString =
            await rootBundle.loadString(FileAssets.userInfo);
        setState(
          () => userInfo = UserInfo.fromRawJson(rawString).copyWith(
            pictureBytes: userInfo!.pictureBytes,
          ),
        );
        return userInfo;
      },
    );
  }
}
