import 'package:ap_common_flutter_ui/ap_common_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

/// 關於頁面的資訊卡片，顯示標題與可連結的內文
class AboutInfoCard extends StatelessWidget {
  const AboutInfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24.0,
          left: 16.0,
          bottom: 16.0,
          right: 16.0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 52.0),
                child: SelectableLinkify(
                  text: title,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              SelectableLinkify(
                text: content,
                style: TextStyle(
                  fontSize: 14.0,
                  color: colorScheme.onSurfaceVariant,
                ),
                options: const LinkifyOptions(humanize: false),
                onOpen: (LinkableElement link) =>
                    PlatformUtil.instance.launchUrl(link.url),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
