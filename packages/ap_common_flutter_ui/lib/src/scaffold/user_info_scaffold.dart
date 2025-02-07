import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

enum BarCodeMode { code39, qrCode }

class UserInfoScaffold extends StatefulWidget {
  const UserInfoScaffold({
    super.key,
    required this.userInfo,
    this.heroTag,
    this.actions,
    this.onRefresh,
    this.enableBarCode = false,
  });

  final UserInfo userInfo;
  final String? heroTag;
  final List<Widget>? actions;
  final Future<UserInfo?> Function()? onRefresh;
  final bool enableBarCode;

  @override
  UserInfoScaffoldState createState() => UserInfoScaffoldState();
}

class UserInfoScaffoldState extends State<UserInfoScaffold> {
  ApLocalizations get app => ApLocalizations.of(context);

  BarCodeMode codeMode = BarCodeMode.qrCode;

  String get iconName {
    switch (codeMode) {
      case BarCodeMode.code39:
        return ApImageIcons.qrcode;
      case BarCodeMode.qrCode:
        return ApImageIcons.barcode;
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(app.userInfo),
        // backgroundColor: ApTheme.of(context).blue,
        actions: <Widget>[
          ...widget.actions ?? <Widget>[],
          if (widget.enableBarCode)
            IconButton(
              icon: Image.asset(
                iconName,
                height: 24.0,
                width: 24.0,
              ),
              onPressed: () {
                setState(
                  () => codeMode = BarCodeMode
                      .values[(codeMode.index + 1) % BarCodeMode.values.length],
                );
                AnalyticsUtil.instance.logEvent('user_info_barcode_switch');
              },
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (widget.onRefresh != null) await widget.onRefresh!();
          AnalyticsUtil.instance.logEvent('user_info_refresh');
          return;
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 8.0),
            if (widget.userInfo.pictureBytes != null)
              SizedBox(
                height: 320,
                child: AspectRatio(
                  aspectRatio: 2.0,
                  child: Hero(
                    tag: widget.heroTag ?? ApConstants.tagStudentPicture,
                    child: Image.memory(
                      widget.userInfo.pictureBytes!,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 0.0),
            const SizedBox(height: 8.0),
            UserInfoCard(
              userInfo: widget.userInfo,
              codeMode: codeMode,
              enableBarCode: widget.enableBarCode,
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    super.key,
    this.userInfo,
    this.codeMode,
    this.enableBarCode = false,
  });

  final UserInfo? userInfo;
  final BarCodeMode? codeMode;
  final bool enableBarCode;

  Barcode get barcode {
    switch (codeMode) {
      case BarCodeMode.code39:
        return Barcode.code39();
      case BarCodeMode.qrCode:
      default:
        return Barcode.qrCode();
    }
  }

  double get barcodeHeight {
    switch (codeMode) {
      case BarCodeMode.code39:
        return 100.0;
      case BarCodeMode.qrCode:
      default:
        return 180.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            if (enableBarCode)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 4.0,
                ),
                child: BarcodeWidget(
                  barcode: barcode,
                  data: userInfo!.id,
                  color: ApTheme.of(context).barCode,
                  height: barcodeHeight,
                ),
              ),
            ListTile(
              title: Text(ApLocalizations.of(context).studentNameCht),
              subtitle: Text(userInfo?.name ?? ''),
            ),
            const Divider(height: 1.0),
            if (userInfo?.educationSystem != null) ...<Widget>[
              ListTile(
                title: Text(ApLocalizations.of(context).educationSystem),
                subtitle: Text(userInfo?.educationSystem ?? ''),
              ),
              const Divider(height: 1.0),
            ],
            if (userInfo?.email != null) ...<Widget>[
              ListTile(
                title: Text(ApLocalizations.of(context).email),
                subtitle: Text(userInfo?.email ?? ''),
              ),
              const Divider(height: 1.0),
            ],
            ListTile(
              title: Text(ApLocalizations.of(context).department),
              subtitle: Text(userInfo?.department ?? ''),
            ),
            const Divider(height: 1.0),
            ListTile(
              title: Text(ApLocalizations.of(context).studentClass),
              subtitle: Text(userInfo?.className ?? ''),
            ),
            const Divider(height: 1.0),
            ListTile(
              title: Text(ApLocalizations.of(context).studentId),
              subtitle: Text(userInfo?.id ?? ''),
            ),
            const Divider(height: 1.0),
          ],
        ),
      ),
    );
  }
}
