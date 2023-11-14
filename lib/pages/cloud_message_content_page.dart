import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/resources/ap_theme.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/cloud_message_utils.dart';
import 'package:ap_common/widgets/ap_network_image.dart';
import 'package:flutter/material.dart';

class CloudMessageContentPage extends StatefulWidget {
  const CloudMessageContentPage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final CloudMessage message;

  @override
  _CloudMessageContentPageState createState() =>
      _CloudMessageContentPageState();
}

class _CloudMessageContentPageState extends State<CloudMessageContentPage> {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Box<CloudMessage> box = CloudMessageUtils.instance.box;

  ApLocalizations get ap => ApLocalizations.of(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CloudMessage item = widget.message;
    return Scaffold(
      appBar: AppBar(
        title: Text(ap.notifications),
      ),
      floatingActionButton: item.url != null
          ? FloatingActionButton(
              onPressed: () {
                ApUtils.launchUrl(item.url!);
              },
              child: Icon(
                ApIcon.exitToApp,
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (item.imageUrl != null) ApNetworkImage(url: item.imageUrl!),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: ApTheme.of(context).greyText,
                      ),
                    ),
                  ),
                  if (item.dateTime != null)
                    Text(
                      dateFormat.format(item.dateTime!),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: ApTheme.of(context).greyText,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.content ?? '',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
