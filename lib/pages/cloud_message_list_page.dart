import 'package:ap_common/pages/cloud_message_content_page.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common/utils/cloud_message_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CloudMessageListPage extends StatefulWidget {
  const CloudMessageListPage({Key? key}) : super(key: key);

  @override
  _CloudMessageListPageState createState() => _CloudMessageListPageState();
}

class _CloudMessageListPageState extends State<CloudMessageListPage> {
  Box<CloudMessage> box = CloudMessageUtils.instance.box;

  ApLocalizations get ap => ApLocalizations.of(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ap.notifications),
      ),
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              onPressed: () {
                box.add(CloudMessage.sample());
                setState(() {});
              },
            )
          : null,
      body: ListView.builder(
        itemCount: box.length,
        itemBuilder: (_, int index) {
          final CloudMessage item = box.getAt(index)!;
          return ListTile(
            title: Text(
              item.title,
              maxLines: 1,
            ),
            subtitle: Text(
              item.content ?? '',
              maxLines: 2,
            ),
            onTap: () {
              ApUtils.pushCupertinoStyle(
                context,
                CloudMessageContentPage(message: item),
              );
            },
          );
        },
      ),
    );
  }
}
